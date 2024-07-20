/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Model.Customer;
import Model.Invoice;
import Model.InvoiceDetail;
import Model.Product;
import Model.ProductOrder;
import Model.User;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author ADMIN
 */
public class InvoiceDAO extends DBContext {

    public List<Invoice> getAllInvoice() {
        List<Invoice> list = new ArrayList<>();
        String sql = "  select I.id, U.id, U.username, C.id, C.name, I.date, I.total_price "
                + "from Invoice I join Users U on I.staff_id = U.id join Customer C on "
                + "I.customer_id = C.id order by I.date desc";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User user = new User(rs.getInt(2), rs.getString(3));
                Customer customer = new Customer(rs.getInt(4), rs.getString(5));
                Invoice invoice = new Invoice(rs.getString(1), user, customer, rs.getString(6), rs.getFloat(7));
                list.add(invoice);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<InvoiceDetail> getInvoiceDetail() {
        List<InvoiceDetail> list = new ArrayList<>();
        String sql = " select I.*,P.name, P.price  from Invoice_Detail I"
                + " join Product P on I.product_id = P.id";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Product p = new Product(rs.getNString(3), rs.getString(5), rs.getFloat(6), 0);
                list.add(new InvoiceDetail(rs.getInt(1), rs.getString(2), p, rs.getInt(4)));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
 
    public float getAllRevenue(){
        String sql = "SELECT SUM(Invoice.total_price) AS total_sum FROM Invoice";
        try (PreparedStatement stm = connection.prepareStatement(sql)) { 
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getFloat(1);
            }            
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }  
    
    public float getRevenueDaily(){
        String sql = "SELECT SUM(total_price) AS dailyRevenue FROM Invoice " 
                  +  "WHERE CAST(date AS DATE) = CAST(GETDATE() AS DATE)";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getFloat(1);
            }  
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }
    public Map<Integer, Float> getMonthRevenue() {
        Map<Integer, Float> revenueMap = new HashMap<>();
        String sql = "SELECT MONTH(Invoice.date) AS month, SUM(total_price) AS total_revenue "
                   + "FROM Invoice WHERE YEAR(date) = YEAR(GETDATE()) "
                   + "GROUP BY MONTH(date)";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                revenueMap.put(rs.getInt(1), rs.getFloat(2));
            } 
            return revenueMap;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return revenueMap;
    }
    
    public boolean addDetailInvoice(List<ProductOrder> pOrder, String invoiceID) {
        ProductDAO product = new ProductDAO();
        String sql = "insert into Invoice_Detail (bill_id, product_id, quantity) values(?,?,?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            for (ProductOrder p : pOrder) { 
                ps.setString(1, invoiceID);
                ps.setString(2, p.getProductID());
                ps.setInt(3, p.getQuantity());
                product.updateQuantity(p.getProductID(), product.getQuantityProduct(p.getProductID()) - p.getQuantity());
                ps.executeUpdate();
            }
            return true;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
    
    public boolean createInvoice(String invoiceID, int staffID, int customerID, float totalPrice, List<ProductOrder> pOrder) {
        DecimalFormat decimalFormat = new DecimalFormat("#,###");
        SystemLogDAO log = new SystemLogDAO();
        String action = "Tạo thành công hóa đơn #" + invoiceID + " giá " + decimalFormat.format(totalPrice);
        String sql = "insert into Invoice (id, staff_id, customer_id, total_price, [date]) values(?,?,?,?,GETDATE())";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, invoiceID);
            ps.setInt(2, staffID);
            ps.setInt(3, customerID);
            ps.setFloat(4, totalPrice);
            ps.executeUpdate();
            if (addDetailInvoice(pOrder, invoiceID)) {
                log.insertIntoSystemLog(staffID, action);
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
}
