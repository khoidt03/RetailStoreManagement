/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin;

import DAL.CategoryDAO;
import DAL.ProductDAO;
import DAL.SupplierDAO;
import Model.ProductExcel;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type; 
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class Inventory extends HttpServlet {
   
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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Inventory</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Inventory at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        request.setAttribute("inventory", dao.getInventory());
        request.getRequestDispatcher("View/Admin/Inventory.jsp").forward(request, response);
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
        ProductDAO dao = new ProductDAO();
        SupplierDAO supplier = new SupplierDAO();
        CategoryDAO category = new CategoryDAO();
        String message = "Thêm sản phẩm thất bại";
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();  
        String data = request.getParameter("data");
        Gson gson = new Gson(); 
        Type personListType = new TypeToken<List<ProductExcel>>() {}.getType();
        List<ProductExcel> productData = gson.fromJson(data, personListType); 
        for (ProductExcel p : productData) {
            if(dao.addProductInventory(p.getProductName(), p.getQuantity(), p.getReceiveDate(),p.getExpiredDate(), 
                    p.getPrice(), p.getSalePrice(),category.getCategoryID(p.getCategory()) , supplier.getIdbyNameSupplier(p.getSupplier()), dao.getLocationID(p.getLocation())))
                message = "Thêm lô sản phẩm thành công!";
        }
        out.print(message);
        out.flush();
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
