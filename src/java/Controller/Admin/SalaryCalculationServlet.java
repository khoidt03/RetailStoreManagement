package Controller.Admin;

import DAL.SystemLogDAO;
import DAL.UserDAO;
import Model.User;
import Model.SalaryInfo;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class SalaryCalculationServlet extends HttpServlet {
    
    private SystemLogDAO systemLogDAO;
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        systemLogDAO = new SystemLogDAO();
        userDAO = new UserDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("account") != null) {
            // Lấy tháng và năm hiện tại
            Calendar cal = Calendar.getInstance();
            int currentMonth = cal.get(Calendar.MONTH) + 1; // Tháng trong Calendar bắt đầu từ 0
            int currentYear = cal.get(Calendar.YEAR);
            
            request.setAttribute("currentMonth", currentMonth);
            request.setAttribute("currentYear", currentYear);
            
            request.getRequestDispatcher("/View/Admin/Salary.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String monthYearStr = request.getParameter("monthYear");
        SimpleDateFormat sdf = new SimpleDateFormat("MM-yyyy");
        Calendar cal = Calendar.getInstance();
        
        try {
            Date date = sdf.parse(monthYearStr);
            cal.setTime(date);
        } catch (ParseException e) {
            e.printStackTrace();
            // Xử lý lỗi nếu cần
        }

        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);

        List<SalaryInfo> salaryList = new ArrayList<>();
        List<User> employees = userDAO.getUserInfo();
        for (User employee : employees) {
            int workingHours = systemLogDAO.getTotalWorkingHoursInMonth(employee.getUserID(), month, year);
            double salary = calculateSalary(workingHours);
            salaryList.add(new SalaryInfo(employee.getUsername(), workingHours, salary));
        }

        request.setAttribute("salaryList", salaryList);
        request.setAttribute("selectedMonth", month);
        request.setAttribute("selectedYear", year);
        request.getRequestDispatcher("/View/Admin/Salary.jsp").forward(request, response);
    }

    private double calculateSalary(int workingHours) {
        // Giả sử mức lương cơ bản là 20000/giờ
        double hourlyRate = 20000;
        return workingHours * hourlyRate;
    }
}