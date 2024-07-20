/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAL.*;
import Model.*;

/**
 *
 * @author sinan
 */
public class AddNewSessionTime extends HttpServlet {

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
    UserDAO dao;
    ScheduleDAO scheduleDAO;

    public void init() {
        dao = new UserDAO();
        scheduleDAO = new ScheduleDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setAttribute("WorkSessionList", scheduleDAO.getAllWorkSession());
        request.setAttribute("scheduleList", dao.getUserInfo());
        request.getRequestDispatcher("View/Admin/Schedule.jsp").forward(request, response);
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
        response.setContentType("text/html;charset=UTF-8");       
        String starttime = request.getParameter("starttime");
        String endtime = request.getParameter("endtime");
        String workSession = request.getParameter("name");    
        System.out.println(starttime);
        System.out.println(endtime);
        System.out.println(workSession);
        System.out.println(scheduleDAO.InsertIntoWorkSession(workSession, starttime, endtime)); 
//      response.getWriter().write("<td> <input type=\"checkbox\" name=\"checkboxTime\" class=\"checkboxTime\" value=\""+starttime+" \"></td>\n" +
//"                                                <td>${c.getWorkSessionName()} ${c.getStart_time()}-${c.getEnd_time()}</td>");
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
