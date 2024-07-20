package Controller.Admin;

import DAL.SupplierDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import Model.Supplier;

public class AddSupplier extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddSupplier</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddSupplier at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("View/Admin/AddSupplier.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        SupplierDAO dao = new SupplierDAO();
        String nameSupplier = request.getParameter("nameSupplier");
        String phoneSupplier = request.getParameter("phoneSupplier");
        String addressSupplier = request.getParameter("addressSupplier");
        String emailSupplier = request.getParameter("emailSupplier");
        String message = "";

        try {
            Supplier existingSupplier = dao.exitAddInfoSupplier(nameSupplier, phoneSupplier, addressSupplier);

            if (existingSupplier != null) {
                message = "Nhà cung cấp đã tồn tại.";
                request.setAttribute("message", message);
                request.getRequestDispatcher("View/Admin/AddSupplier.jsp").forward(request, response);
            } else {
                Supplier newSupplier = new Supplier(nameSupplier, phoneSupplier, addressSupplier, emailSupplier);
                dao.addInfoSupplier(newSupplier);
                message = "Thêm nhà cung cấp thành công";
            }
        } catch (ServletException | IOException e) {
            System.out.println(e);
        }

        try {
            List<Supplier> suppliers = dao.getInfoSupplier();
            request.setAttribute("listSuppliers", suppliers);
        } catch (Exception e) {
            System.out.println(e);
        }

        request.setAttribute("message", message);
        request.getRequestDispatcher("View/Admin/Supplier.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
