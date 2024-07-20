/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.CustomerDAO;
import DAL.InvoiceDAO;
import Model.Customer;
import Model.ProductOrder;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "InvoiceController", urlPatterns = {"/invoice"})
public class InvoiceController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        InvoiceDAO invoice = new InvoiceDAO();
        CustomerDAO cDAO = new CustomerDAO();
        Customer customer = new Customer();
        String message = "error";
        Gson gson = new Gson();
        String staffID = request.getParameter("staffID");
        String invoiceID = request.getParameter("invoiceID");
        int customerID = 0;
        String nameCustomer = "";
        String phoneCustomer = ""; 
        List<ProductOrder> pOrder = (List<ProductOrder>) session.getAttribute("productOrder");
        String customerString = request.getParameter("customerString");
        float total = Float.parseFloat(request.getParameter("totalPrice")); 
        if(!customerString.equals("null")){
            customer = gson.fromJson(customerString, Customer.class); 
            cDAO.updatePoint(customer.getId(), customer.getPoint() + Math.round(total / 100));
            if (invoice.createInvoice(invoiceID, Integer.parseInt(staffID), customer.getId(), total, pOrder)) { 
                message = "success";
            }
        }
        else{
            nameCustomer = request.getParameter("nameValue");
            phoneCustomer = request.getParameter("phoneValue"); 
            customerID = cDAO.addCustomer(nameCustomer, phoneCustomer, Math.round(total / 100));
                if (invoice.createInvoice(invoiceID, Integer.parseInt(staffID), customerID, total, pOrder)) {
                    message = "success";
                }
        }  
        out.print(message);
        out.flush();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
