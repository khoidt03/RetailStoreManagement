package Controller.Admin;

//import DAL.CategoryDAO;
import DAL.ProductDAO;
import DAL.SupplierDAO;
import Model.OrderSupplier;
//import Model.OrderSupplier;
import Model.Supplier;
//import Model.Category;
import Model.Product;
import Model.OrderSupplierDetail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.Date;
//import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Random;

public class SupplierManager extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SupplierManager</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SupplierManager at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession sessionName = request.getSession();
        SupplierDAO dao = new SupplierDAO();
        ProductDAO dao2 = new ProductDAO();
        String type = request.getParameter("type");

        if (type == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing type parameter");
            return;
        }

        try {
            switch (type) {
                case "detail" -> {
                    String idOrderSupplier_param = request.getParameter("viewsupplier");
                    if (idOrderSupplier_param == null || idOrderSupplier_param.isEmpty()) {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing viewsupplier parameter");
                        return;
                    }
                    int idOrderSupplier = Integer.parseInt(idOrderSupplier_param);
                    String supplierName = dao.getNameSupplierById(idOrderSupplier);
                    List<OrderSupplierDetail> listOrderSupplierDetail = dao.getOrderSupplierDetailsBySupplierId(idOrderSupplier);
                    List<Product> listProduct = dao2.getNameProduct();
                    request.setAttribute("supplierName", supplierName);
                    sessionName.setAttribute("supplierName", supplierName);
                    request.setAttribute("listOrderSupplierDetail", listOrderSupplierDetail);
                    request.setAttribute("listProduct", listProduct);
                    request.getRequestDispatcher("View/Admin/DetailSupplier.jsp").forward(request, response);
                }
                case "delete" -> {
                    String idSupplier = request.getParameter("deleteSupplier");
                    if (idSupplier == null || idSupplier.isEmpty()) {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing deleteSupplier parameter");
                        return;
                    }
                    int idDeleteSupplier = Integer.parseInt(idSupplier);
                    dao.deleteSupplier(idDeleteSupplier);
                    response.sendRedirect(request.getContextPath() + "/supplier");
                }
                case "deletedp" -> {
                    String idOrderDetailSupplier_param = request.getParameter("deleteOSD");
                    String orderSupplierId_param = request.getParameter("viewsupplier");
                    if (idOrderDetailSupplier_param == null || idOrderDetailSupplier_param.isEmpty()) {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing deleteOSD parameter");
                        return;
                    }
                    int idOrderDetailSupplier = Integer.parseInt(idOrderDetailSupplier_param);
                    int orderSupplierId = Integer.parseInt(orderSupplierId_param);
                    dao.deleteOrderDetailSupplier(idOrderDetailSupplier);
                    response.sendRedirect(request.getContextPath() + "/suppliermanager?type=detail&viewsupplier=" + orderSupplierId);
                }
                default ->
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid type parameter");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format in request");
        } catch (ServletException | IOException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal server error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        String type = request.getParameter("type");
        HttpSession sessionName = request.getSession();
        SupplierDAO dao = new SupplierDAO();
        ProductDAO dao2 = new ProductDAO();
        switch (type) {
            case "edit" -> {
                String idEdit = request.getParameter("idEdit");
                String nameEdit = request.getParameter("nameEdit");
                String phoneEdit = request.getParameter("phoneEdit");
                String addressEdit = request.getParameter("addressEdit");
                String emailEdit = request.getParameter("emailEdit");
                String message = "";

                try {
                    Supplier updatedSupplier = new Supplier(Integer.parseInt(idEdit), nameEdit, phoneEdit, addressEdit, emailEdit);
                    dao.editSupplier(updatedSupplier);
                    message = "Sửa nhà cung cấp thành công";
                } catch (NumberFormatException e) {
                    System.out.println(e);
                } catch (Exception e) {
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

            case "history" -> {
                String nameSupplier = (String) sessionName.getAttribute("supplierName");
                int idSupplier = dao.getIdbyNameSupplier(nameSupplier);
                String productId = request.getParameter("productNameSelect");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                int price = Integer.parseInt(request.getParameter("price"));
                Date date = java.sql.Date.valueOf(request.getParameter("date"));
                int orderSupplierId = dao.getLastIdOrderSupplier() + 1;
                Supplier supplier = new Supplier();
                supplier.setId(idSupplier);

                OrderSupplier orderSupplier = new OrderSupplier();
                orderSupplier.setId(orderSupplierId);
                orderSupplier.setSupplierId(supplier);
                orderSupplier.setDate(date);

                Product product = new Product();
                product.setProductID(productId);

                OrderSupplierDetail orderSupplierDetail = new OrderSupplierDetail();
                orderSupplierDetail.setOrderSupplierId(orderSupplier);
                orderSupplierDetail.setProductId(product);
                orderSupplierDetail.setQuantity(quantity);
                orderSupplierDetail.setPrice(price);

                try {
                    dao.addHistoryOrderSupplier(orderSupplier);
                    orderSupplierDetail.setOrderSupplierId(orderSupplier);

                    dao.addHistoryOrderSupplierDetail(orderSupplierDetail);

                    String supplierName = dao.getNameSupplierById(idSupplier);
                    List<OrderSupplierDetail> listOrderSupplierDetail = dao.getOrderSupplierDetailsBySupplierId(idSupplier);
                    List<Product> listProduct = dao2.getNameProduct();
                    request.setAttribute("supplierName", supplierName);
                    request.setAttribute("listOrderSupplierDetail", listOrderSupplierDetail);
                    request.setAttribute("listProduct", listProduct);
                    response.sendRedirect(request.getContextPath() + "/suppliermanager?type=detail&viewsupplier=" + idSupplier);
                } catch (IOException e) {
                    System.out.println(e);
                } catch (NumberFormatException e) {
                    System.out.println("Error: " + e.getMessage());
                }
            }

            default ->
                throw new AssertionError();
        }
    }

    public static String generateProductCode() {
        String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String digits = "0123456789";
        StringBuilder productCode = new StringBuilder();

        Random random = new Random();

        // Thêm ký tự 'P'
        productCode.append('P');

        // Thêm 3 chữ số ngẫu nhiên
        for (int i = 0; i < 3; i++) {
            int index = random.nextInt(digits.length());
            productCode.append(digits.charAt(index));
        }

        // Thêm 5 ký tự chữ cái hoặc số ngẫu nhiên
        for (int i = 0; i < 5; i++) {
            int index = random.nextInt(letters.length() + digits.length());
            if (index < letters.length()) {
                productCode.append(letters.charAt(index));
            } else {
                productCode.append(digits.charAt(index - letters.length()));
            }
        }

        return productCode.toString();
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
