/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import utils.Encode;
import DAL.UserDAO;
import Model.User;
import java.io.IOException; 
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
public class Login extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("View/Login.jsp").forward(request, response);
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
        UserDAO dao = new UserDAO();
        HttpSession session = request.getSession(); 
        Encode encode = new Encode();
        String user = request.getParameter("input-user");
        String pass = request.getParameter("input-pass");
        String rememberMe = request.getParameter("rememberMe");   
        User acc = dao.login(user,  encode.EncodePassword(pass));
        Cookie username = new Cookie("username", user);
        Cookie password = new Cookie("password", pass);
        Cookie remember = new Cookie("rememberMe", rememberMe);
        if (rememberMe != null) { 
            username.setMaxAge(2592000);
            password.setMaxAge(2592000);
            remember.setMaxAge(2592000);
        } else {
            username.setMaxAge(0);
            password.setMaxAge(0);
            remember.setMaxAge(0);
        }
        response.addCookie(username);
        response.addCookie(password);
        response.addCookie(remember);
        if(acc == null){
            request.setAttribute("message", "Thông tin tài khoản hoặc mật khẩu không chính xác!");
            request.getRequestDispatcher("View/Login.jsp").forward(request, response);
            return;
        } 
        session.setAttribute("account", acc); 
        response.sendRedirect(acc.getStatus() == 2 ? "changepassword":(acc.getRole().getRoleID() == 3 ? "sale":"dashboard"));
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
