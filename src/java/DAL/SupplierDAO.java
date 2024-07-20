package DAL;

import Model.OrderSupplier;
import Model.OrderSupplierDetail;
import Model.Product;
import Model.Supplier;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class SupplierDAO extends DBContext {

    public List<Supplier> getInfoSupplier() {
        List<Supplier> listSupplier = new ArrayList<>();
        String sql = "SELECT * FROM Supplier";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Supplier supplier = new Supplier();
                supplier.setId(rs.getInt("id"));
                supplier.setName(rs.getString("name"));
                supplier.setPhone(rs.getString("phone"));
                supplier.setAddress(rs.getString("address"));
                supplier.setEmail(rs.getString("email"));
                listSupplier.add(supplier);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listSupplier;
    }

    public void addInfoSupplier(Supplier supplier) {
        String sql = "INSERT INTO Supplier ([name], [phone], [address], [email]) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, supplier.getName());
            ps.setString(2, supplier.getPhone());
            ps.setString(3, supplier.getAddress());
            ps.setString(4, supplier.getEmail());
            int executeSuccess = ps.executeUpdate();
            if (executeSuccess > 0) {
                System.out.println("Supplier added successfully");
            } else {
                System.out.println("Failed to add supplier");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Supplier exitAddInfoSupplier(String name, String phone, String address) {
        Supplier exitSupplier = null;
        StringBuilder sql = new StringBuilder("SELECT * FROM Supplier WHERE 1 = 1");

        try {
            List<Object> parameters = new ArrayList<>();

            if (name != null && !name.isEmpty()) {
                sql.append(" AND name = ?");
                parameters.add(name);
            }

            if (phone != null && !phone.isEmpty()) {
                sql.append(" OR phone = ?");
                parameters.add(phone);
            }

            if (address != null && !address.isEmpty()) {
                sql.append(" OR address = ?");
                parameters.add(address);
            }

//            if (email != null && !email.isEmpty()) {
//                sql.append(" OR email = ?");
//                parameters.add(email);
//            }
            try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
                for (int i = 0; i < parameters.size(); i++) {
                    ps.setObject(i + 1, parameters.get(i));
                }

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        exitSupplier = new Supplier();
                        exitSupplier.setName(rs.getString("name"));
                        exitSupplier.setPhone(rs.getString("phone"));
                        exitSupplier.setAddress(rs.getString("address"));
//                        exitSupplier.setEmail(rs.getString("email"));
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return exitSupplier;
    }

    public static void main(String[] args) {
        SupplierDAO dao = new SupplierDAO();
        System.out.println(dao.getIdbyNameSupplier("Công Ty 1 Thành Viên"));
    }
    public int getIdbyNameSupplier(String name) {
        int idSupplier = - 1;
        String sql = "SELECT [id] FROM Supplier WHERE [name] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql);) {
            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    idSupplier = rs.getInt("id");
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return idSupplier;
    }

    public void editSupplier(Supplier supplier) {
        String sql = "UPDATE Supplier SET [name] = ?, [phone] = ?, [address] = ?, [email] = ? WHERE [id] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, supplier.getName());
            ps.setString(2, supplier.getPhone());
            ps.setString(3, supplier.getAddress());
            ps.setString(4, supplier.getEmail());
            ps.setInt(5, supplier.getId());
            int executeSuccess = ps.executeUpdate();
            if (executeSuccess > 0) {
                System.out.println("Supplier edited successfully");
            } else {
                System.out.println("Failed to edit supplier");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void deleteSupplier(int idSupplier) {
        String sql = "DELETE FROM Supplier WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, idSupplier);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public String getNameSupplierById(int supplierId) {
        String supplierName = null;
        String sql = "SELECT name FROM Supplier WHERE id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, supplierId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                supplierName = rs.getString("name");
            }

        } catch (SQLException e) {
            System.out.println("Error fetching supplier name: " + e.getMessage());
        }

        return supplierName;
    }

    public List<OrderSupplierDetail> getOrderSupplierDetailsBySupplierId(int supplierId) {
        List<OrderSupplierDetail> orderSupplierDetails = new ArrayList<>();
        String sql = "SELECT S.id AS supplier, OS.id AS orderSupplierId, OSD.id AS orderDetailId, "
                + "P.name AS productName, OSD.quantity, OSD.price, OS.date "
                + "FROM Supplier S "
                + "JOIN Order_Supplier OS ON S.id = OS.supplier_id "
                + "JOIN Order_Supplier_Detail OSD ON OSD.order_id = OS.id "
                + "JOIN Product P ON P.id = OSD.product_id "
                + "WHERE S.id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, supplierId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int supplierIdResult = rs.getInt("supplier");
                    int orderSupplierIdResult = rs.getInt("orderSupplierId");
                    int orderDetailIdResult = rs.getInt("orderDetailId");
                    String productName = rs.getString("productName");
                    int quantity = rs.getInt("quantity");
                    int price = rs.getInt("price");
                    Date date = rs.getDate("date");

                    Supplier supplier = new Supplier();
                    supplier.setId(supplierIdResult);

                    Product product = new Product();
                    product.setProductName(productName);

                    OrderSupplier orderSupplier = new OrderSupplier();
                    orderSupplier.setId(orderSupplierIdResult);
                    orderSupplier.setDate(date);
                    orderSupplier.setSupplierId(supplier);

                    OrderSupplierDetail orderDetail = new OrderSupplierDetail();
                    orderDetail.setId(orderDetailIdResult);
                    orderDetail.setProductId(product);
                    orderDetail.setQuantity(quantity);
                    orderDetail.setPrice(price);
                    orderDetail.setOrderSupplierId(orderSupplier);

                    orderSupplierDetails.add(orderDetail);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching order supplier details: " + e.getMessage());
        }
        return orderSupplierDetails;
    }

    public void deleteOrderDetailSupplier(int idOrderSupplier) {
        String sql = "DELETE FROM Order_Supplier_Detail WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, idOrderSupplier);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addHistoryOrderSupplier(OrderSupplier orderSupplier) {
        String sql = "INSERT INTO Order_Supplier (supplier_id, [date]) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderSupplier.getSupplierId().getId());
            ps.setDate(2, new java.sql.Date(orderSupplier.getDate().getTime()));
            int executeSuccess = ps.executeUpdate();
            if (executeSuccess > 0) {
                System.out.println("Order Supplier added successfully");
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderSupplier.setId(rs.getInt(1));
                    }
                }
            } else {
                System.out.println("Failed to add order supplier");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addHistoryOrderSupplierDetail(OrderSupplierDetail orderSupplierDetail) {
        String sql = "INSERT INTO Order_Supplier_Detail (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderSupplierDetail.getOrderSupplierId().getId());
            ps.setString(2, orderSupplierDetail.getProductId().getProductID());
            ps.setInt(3, orderSupplierDetail.getQuantity());
            ps.setInt(4, orderSupplierDetail.getPrice());
            int executeSuccess = ps.executeUpdate();
            if (executeSuccess > 0) {
                System.out.println("Order Supplier Detail added successfully");
            } else {
                System.out.println("Failed to add order supplier detail");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public int getLastIdOrderSupplier() {
        int maxId = 0;
        String sql = "SELECT MAX(id) AS last_id FROM Order_Supplier";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery();) {
            if (rs.next()) {
                maxId = rs.getInt("last_id");
            }
        } catch (Exception e) {
            System.out.println("Error while fetching max ID from Order_Supplier: " + e.getMessage());
        }
        return maxId;
    } 
}
