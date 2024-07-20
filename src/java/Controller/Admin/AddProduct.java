/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin;

import DAL.ProductDAO;
import DAL.SupplierDAO;
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
public class AddProduct extends HttpServlet { 
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    ProductDAO dao;
    SupplierDAO supplier;
    public void init(){
        dao = new ProductDAO();
        supplier = new SupplierDAO();
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
        request.setAttribute("listCategory", dao.getCategory());
        request.setAttribute("listLocation", dao.getLocation());
        request.setAttribute("listSupplier", supplier.getInfoSupplier()); 
        request.getRequestDispatcher("View/Admin/AddProduct.jsp").forward(request, response);
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
        String type = request.getParameter("type");
        String message = "";
        switch (type) {
            case "location" -> {
                String locatioName = request.getParameter("location");
                if(dao.addLocation(locatioName)) message = "Thêm vị trí kệ mới thành công!";
                else message = "Lỗi thêm kệ!";
            }
            case "category" -> {
                String categoryName = request.getParameter("categoryName");
                if(dao.addCategory(categoryName)) message = "Thêm danh mục thành công!";
                else message = "Lỗi thêm danh mục!";
            }
            case "product" -> {
                String productName = request.getParameter("name");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                String receiveDate = request.getParameter("receiveDate");
                String expriedDate = request.getParameter("expriedDate");
                float price = Float.parseFloat(request.getParameter("price"));
                float salePrice = Float.parseFloat(request.getParameter("salePrice"));
                int categoryID = Integer.parseInt(request.getParameter("category"));
                int supplierID = Integer.parseInt(request.getParameter("supplierID"));
                int locationId = Integer.parseInt(request.getParameter("location"));
                if(dao.addProductInventory(productName, quantity, receiveDate, expriedDate, price, salePrice, categoryID,supplierID, locationId))
                    message = "Thêm sản phẩm thành công !";
                else message = "Thêm sản phẩm thất bại !";
            }
            default -> throw new AssertionError();
        }
        request.setAttribute("message", message);
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
