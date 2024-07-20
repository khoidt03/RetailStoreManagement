/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import DAL.ScheduleDAO;
import DAL.UserDAO;
import Model.ScheduleLog;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author sinan
 */
public class Schedule extends HttpServlet {

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
            out.println("<title>Servlet Schedule</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Schedule at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    UserDAO dao;
    ScheduleDAO scheduleDAO;

    public void init() {
        dao = new UserDAO();
        scheduleDAO = new ScheduleDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("weekList", scheduleDAO.getAllWeekOfYear());
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
//        processRequest(request, response);
        int dateid = Integer.parseInt(request.getParameter("dateid"));
        int count = 0;
        int size = scheduleDAO.getAllScheduleLogByDateID(dateid).size();
        response.getWriter().write("[");
        for (ScheduleLog i : scheduleDAO.getAllScheduleLogByDateID(dateid)) {
            response.getWriter().write("{\"userid\": \"" + i.getStaffID() + "\","
                    + "\"dateid\": \"" + i.getDateId().getId() + "\","
                    + "\"dayOfWeek\": \"" + i.getDayOfWeek() + "\","
                    + "\"Info\": \"" + i.getWorkSessionID().getWorkSessionName() + scheduleDAO.subTime(i.getWorkSessionID().getStart_time())
                    + "-" + scheduleDAO.subTime(i.getWorkSessionID().getEnd_time()) + "\"}");
            if (count != size - 1) {
                response.getWriter().write(",");
            }
            count++;
        }
        response.getWriter().write("]");
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
