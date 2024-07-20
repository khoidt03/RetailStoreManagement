/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Model.Category;
import Model.Inventory;
import Model.Location;
import Model.Product;
import Model.ProductSale;
import Model.Supplier;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.RandomCode;

/**
 *
 * @author ADMIN
 */
public class ProductDAO extends DBContext {
 
    public List<Product> getProduct() {
        List<Product> list = new ArrayList<>();
        String sql = "select P.id, P.name, price, sale_price, C.id,P.date_expried,P.status,C.name "
                + "from Product P join Category C on P.category_id = C.id where P.status != 0";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Category category = new Category(rs.getInt(5), rs.getString(8));
                list.add(new Product(rs.getString(1),
                                     rs.getString(2),
                                     rs.getFloat(3),
                                     rs.getFloat(4),
                                     rs.getString(6),
                                     category,
                               rs.getInt(7)));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public List<Product> getExpiredProduct(){ 
        List<Product> listProduct = new ArrayList<>();
        String sql = "select P.id, P.name, price, sale_price, C.id,P.date_expried,P.status,C.name "
                + "from Product P join Category C on P.category_id = C.id where P.status != 0 "
                + "and date_expried <= DATEADD(day, 3, GETDATE())"; 
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Category category = new Category(rs.getInt(5), rs.getString(8));
                listProduct.add(new Product(rs.getString(1),
                                     rs.getString(2),
                                     rs.getFloat(3),
                                     rs.getFloat(4),
                                     rs.getString(6),
                                     category,
                               rs.getInt(7)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listProduct; 
    }  
    
    public List<ProductSale> getDiscountProduct(){ 
        List<ProductSale> listProduct = new ArrayList<>(); 
        String sql = "select PS.id, PS.product_id, P.name, P.sale_price, PS.sale_percent "
                   + "from Product_Sale PS join Product P on P.id = PS.product_id "
                   + "where PS.status = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Product p = new Product(rs.getString(2), rs.getString(3), rs.getFloat(4), 1);
                listProduct.add(new ProductSale(rs.getInt(1),
                                                p,
                                                rs.getInt(5)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listProduct; 
    }  

    public List<Category> getCategory() {
        List<Category> list = new ArrayList<>();
        String sql = "select id, name from Category";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt(1), rs.getString(2)));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    public List<Location> getLocation() {
        List<Location> list = new ArrayList<>();
        String sql = "select LocationId, LocationName from Location";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Location(rs.getInt(1), rs.getString(2)));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public int getLocationID(String locationName){
        String sql = "select LocationID from Location where LocationName LIKE ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) { 
            stm.setString(1, "%" + locationName + "%");
            ResultSet rs = stm.executeQuery();
            while(rs.next()){  
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public boolean addCategory(String categoryName) {
        String sql = "INSERT INTO Category VALUES(?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, categoryName);
            stm.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean isExistProduct(String productName) {
        String sql = "select P.id from Product P where P.name LIKE ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, productName);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
    
    public boolean addLocation(String locationName){
        String sql = "insert into Location(LocationName) values(?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, locationName); 
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
 
    public boolean addProductInventory(String name, int quantity, String receiveDate, String expriedDate, float price, float salePrice, int categoryID, int supplierID, int location) {
        RandomCode code = new RandomCode();
        String sql = "INSERT INTO Inventory VALUES(?,?,?,?,?,?, 1)";
        try {
            String id = code.generateCode();
            if (addProduct(id, name, price, salePrice, expriedDate, categoryID)) {
                PreparedStatement stm = connection.prepareStatement(sql);
                stm.setString(1, id);
                stm.setInt(2, quantity);
                stm.setFloat(3, price);
                stm.setString(4, receiveDate); 
                stm.setInt(5, supplierID);
                stm.setInt(6, location); 
                stm.executeUpdate();
                return true;
            } 
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean addProduct(String id, String name, float price, float salePrice, String expiredDate, int categoryID) {
        String sql = "INSERT INTO Product VALUES(?,?,?,?,?,?, 1)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            stm.setString(2, name);
            stm.setFloat(3, price);
            stm.setFloat(4, salePrice);
            stm.setString(5, expiredDate);
            stm.setInt(6, categoryID);
            stm.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public List<Product> searchProductByName(String pName) {
        List<Product> list = new ArrayList<>();
        String sql = "select P.id, P.name, P.sale_price from Product P where P.name LIKE ? "
                + "and P.status != 0";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + pName + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getString(1), rs.getString(2), rs.getFloat(3),1));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
 
    public Product getProduct(String pID) {
        String sql = "select P.id, P.name, P.sale_price from Product P where P.id = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, pID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return new Product(rs.getString(1), rs.getString(2), rs.getFloat(3), 1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Inventory> getInventory() {
        List<Inventory> list = new ArrayList<>();
        String sql = "select product_id, P.name, P.price, quantity,receive_date, S.name,I.LocationID,LocationName " 
                   + "from Inventory I join Product P on P.id = I.product_id join Supplier S "
                   + "on S.id = I.supplier_id join Location L on L.LocationID = I.LocationID "
                   + "where I.status != 0";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Location location = new Location(rs.getInt(7), rs.getString(8));
                Product p = new Product(rs.getString(1), rs.getString(2), rs.getFloat(3), 0);
                Supplier s = new Supplier(rs.getString(6));
                list.add(new Inventory(p, rs.getInt(4),rs.getDate(5), s, location));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;

    }

    public List<Product> getNameProduct() {
        List<Product> listProduct = new ArrayList<>();
        String sql = "SELECT id, [name] FROM Product";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getString("id"));
                product.setProductName(rs.getString("name"));
                listProduct.add(product);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listProduct; 
    }
     
    public boolean deleteProduct(String pID){
        String sql = "update Product set status = 0 where id = ? ";
        try {
            PreparedStatement stm = connection.prepareStatement(sql); 
            stm.setString(1, pID); 
            stm.executeUpdate();
            return true;
        } catch (SQLException e) {
        }
        return false;
    }
    
    public boolean updateProduct(String pID, String name, float price, float salePrice, int categoryID){
        String sql = "update Product set name = ?, price = ?, sale_price = ?, category_id = ? where id = ? ";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, name);
            stm.setFloat(2, price);
            stm.setFloat(3, salePrice);
            stm.setInt(4, categoryID);
            stm.setString(5, pID);
            stm.executeUpdate();
            return true;
        } catch (SQLException e) {
        }
        return false;
    }
    
    public boolean updateSalePrice(String pID, float price){
        String sql = "update Product set sale_price = ? where id = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setFloat(1, price);
            stm.setString(2, pID);
            stm.executeUpdate(); 
            return true;
        } catch (Exception e) {
        }
        return false;
    }
    
    public boolean isExistProductSale(String pID){
        String sql = "select * from Product_Sale where product_id = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, pID); 
            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                return true;
            }  
        } catch (SQLException e) {
        }
        return false;
    }
    
    public boolean addDiscount(String pID, int percent){
        String sql = "insert into Product_Sale(product_id, sale_percent, status) values (?,?,1)";
        try {
            if(!isExistProductSale(pID)){
                PreparedStatement stm = connection.prepareStatement(sql);
                stm.setString(1, pID); 
                stm.setInt(2, percent);
                stm.executeUpdate();
                return true;
            }  
        } catch (SQLException e) {
        }
        return false;
    }
    
    public boolean changeDiscount(String pID, int percent){
        String sql = "update Product_Sale set sale_percent = ? where product_id = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql); 
            stm.setInt(1, percent);
            stm.setString(2, pID);
            stm.executeUpdate(); 
            return true;
        } catch (Exception e) {
        }
        return false;
    }
    
    public int getQuantityProduct(String pID){ 
        String sql = "select I.quantity from Inventory I where I.product_id = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql); 
            stm.setString(1, pID);
            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        } 
        return 0; 
    }
    public void updateQuantity(String pID, int quantity){
        String sql = "update Inventory set quantity = ? where product_id = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, quantity); 
            stm.setString(2, pID);
            stm.executeUpdate(); 
        } catch (SQLException e) {
        } 
    }
}
