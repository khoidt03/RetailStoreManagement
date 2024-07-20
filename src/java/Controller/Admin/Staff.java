/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin;

import DAL.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.Encode;

/**
 *
 * @author ADMIN
 */
public class Staff extends HttpServlet { 
    UserDAO dao; 
    public void init(){
        dao = new UserDAO();
    }
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
        request.setAttribute("userList", dao.getUserInfo());
        request.setAttribute("listRole", dao.getUserRole());
        request.getRequestDispatcher("View/Admin/StaffManager.jsp").forward(request, response);
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
        Encode encode = new Encode();
        String action = request.getParameter("action");
        String message = "";
        int userID = Integer.parseInt(request.getParameter("uID"));
        switch (action) {
            case "edit" -> { 
                String password = encode.EncodePassword(request.getParameter("password"));
                String firstName = request.getParameter("firstname");
                String lastName = request.getParameter("lastname"); 
                String date = request.getParameter("date");
                int gender = Integer.parseInt(request.getParameter("gender"));
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String email = request.getParameter("email");
                int status = Integer.parseInt(request.getParameter("status"));
                int roleID = Integer.parseInt(request.getParameter("role"));
                if(dao.updateUser(userID, password, status, roleID, firstName, lastName, date, gender, phone, address, email))
                    message = "Cập nhật thông tin nhân viên thành công!"; 
                else message = "Cập nhật thông tin thất bại!";
            }
            case "delete" -> {
                if(dao.deleteUser(userID)) message = "Xóa nhân viên thành công!"; 
                else message = "Xóa nhân viên thất bại!";
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
