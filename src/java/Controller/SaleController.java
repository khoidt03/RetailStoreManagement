/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.ProductDAO;
import Model.Product;
import Model.ProductOrder;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class SaleController extends HttpServlet {

    private ProductDAO dao = new ProductDAO();
    List<ProductOrder> list;

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Search</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Search at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        String textSearch = request.getParameter("textSearch");
        List<Product> products = dao.searchProductByName(textSearch);
        String json = new Gson().toJson(products);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
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
        HttpSession session = request.getSession();
        String type = request.getParameter("type");
        String pID = request.getParameter("pID");
        if (session.getAttribute("productOrder") != null) {
            list = (List<ProductOrder>) session.getAttribute("productOrder");
        } else {
            list = new ArrayList<>();
        }
        switch (type) {
            case "removeAll":
                session.removeAttribute("productOrder");
                break;
            case "order":
                addProductToOrder(pID, list, session);
                break;
            case "delete":
                DeleteProduct(pID, list, session);
                break;
            case "add":
                handleQuantity("add", list, pID, session);
                break;
            case "sub":
                handleQuantity("sub", list, pID, session);
                break;
            default:
                handleQuantity(type, list, pID, session);

        }
        response.sendRedirect("sale");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    private void addProductToOrder(String pID, List<ProductOrder> list, HttpSession session) { 
        Product p = dao.getProduct(pID);
        ProductOrder pOrder = new ProductOrder();
        if(productCanAdd(list, pID) == null){
            pOrder = new ProductOrder(p.getProductID(), p.getProductName(), p.getSale_price(), 1);
            list.add(pOrder);
        }
        else{
            pOrder = productCanAdd(list, pID);
            pOrder.setQuantity(pOrder.getQuantity() + 1);
        } 
        session.setAttribute("productOrder", list);
    }

    private ProductOrder productCanAdd(List<ProductOrder> list, String pID) {
        if (list.size() < 1) {
            return null;
        }
        for (ProductOrder productOrder : list) {
            if (productOrder.getProductID().equals(pID)) {
                return productOrder;
            }
        }
        return null;
    }

    private void DeleteProduct(String pID, List<ProductOrder> list, HttpSession session) {
        Iterator<ProductOrder> iterator = list.iterator();
        while (iterator.hasNext()) {
            ProductOrder productOrder = iterator.next();
            if (productOrder.getProductID().equals(pID)) {
                iterator.remove();
            }
        }
        session.setAttribute("productOrder", list);
    }

    private void handleQuantity(String type, List<ProductOrder> list, String pID, HttpSession session) {
        Iterator<ProductOrder> iterator = list.iterator();
        while (iterator.hasNext()) {
            ProductOrder productOrder = iterator.next();
            if (productOrder.getProductID().equals(pID)) {
                int pQuantity = productOrder.getQuantity();
                switch (type) {
                    case "add" ->
                        productOrder.setQuantity(pQuantity + 1);
                    case "sub" -> {
                        if (pQuantity > 1) {
                            productOrder.setQuantity(pQuantity - 1);
                        } else {
                            iterator.remove();
                        }
                    }
                    default -> {
                        int quantity = Integer.parseInt(type);
                        productOrder.setQuantity(quantity);
                    }
                }
            }
        }
        session.setAttribute("productOrder", list);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
