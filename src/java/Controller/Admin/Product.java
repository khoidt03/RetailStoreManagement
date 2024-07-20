/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin;

import DAL.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class Product extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    ProductDAO dao;
    public void init(){
        dao = new ProductDAO();
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException { 
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {  
        String type = request.getParameter("type");
        int isDiscount = 0;
        if(type != null){
            switch (type) {
            case "all":
                request.setAttribute("listProduct", dao.getProduct());
                break;
            case "expired":
                request.setAttribute("listProduct", dao.getExpiredProduct());
                break;
            case "sale":
                isDiscount = 1;
                request.setAttribute("listDiscount", dao.getDiscountProduct());
                break;
            default: 
                throw new AssertionError();
            }    
        }
        else{
            request.setAttribute("listProduct", dao.getProduct());
        }
        request.setAttribute("discount", isDiscount); 
        request.setAttribute("listCategory", dao.getCategory()); 
        request.getRequestDispatcher("View/Admin/Product.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String message = "Có lỗi xảy ra, vui lòng thử lại!";
        String type = "error";
        ProductDAO dao = new ProductDAO();
        String action = request.getParameter("action");
        String pID = request.getParameter("pID");
        float salePrice = Float.parseFloat(request.getParameter("salePrice")); 
        switch (action) {
            case "edit":
                String name = request.getParameter("name");
                float price = Float.parseFloat(request.getParameter("price")); 
                int category = Integer.parseInt(request.getParameter("category"));
                if (dao.updateProduct(pID, name, price, salePrice, category)) {
                    message = "Cập nhật sản phẩm thành công!";
                }
                type = "success";
                break;
            case "delete":
                if (dao.deleteProduct(pID)) {
                    message = "Xoá sản phẩm thành công!";
                    type = "success";
                }
                break;
            case "removeDiscount":
                break;
            case "changeDiscount":
                int percentChange = Integer.parseInt(request.getParameter("percent"));  
                break;
            case "discount":
                int percent = Integer.parseInt(request.getParameter("percent")); 
                float saleDiscount = salePrice * (100 - percent) / 100;
                if (dao.addDiscount(pID, percent)) {
                    if (dao.updateSalePrice(pID, saleDiscount)) {
                        message = "Giảm giá " + percent + "% sản phẩm thành công!";
                        type = "success";
                    }
                }
                else{
                    message = "Sản phẩm này đã giảm giá, vui lòng vào danh sách giảm giá để thay đổi !";
                }
                break;
            default:
                throw new AssertionError();
        }
        request.setAttribute("message", message);
        request.setAttribute("type", type);
        doGet(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
