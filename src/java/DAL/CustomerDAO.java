/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Model.Customer; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class CustomerDAO extends DBContext{ 
    public int addCustomer(String name, String phone, int point) {
        String sql = "INSERT INTO Customer ([name], phone, point) VALUES (?, ?, ?)";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, name);
            stm.setString(2, phone);
            stm.setInt(3, point);
            stm.executeUpdate();  
        } catch (SQLException e) {
            e.printStackTrace();
        } 
        return getCurrID();
    }
    public int getCurrID(){
        String sql = "SELECT TOP 1 Customer.id FROM Customer ORDER BY Customer.id DESC";
        try (PreparedStatement stm = connection.prepareStatement(sql)) { 
            ResultSet rs = stm.executeQuery();
            while(rs.next()){  
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return -1;
    }
    public void updatePoint(int id, int point){
        String sql = "update Customer set point = ? where id = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.setInt(2, point); 
            stm.executeUpdate(); 
        } catch (Exception e) {
        } 
    }
    public List<Customer> getCustomer(){
        List<Customer> list = new ArrayList<>();
        String sql = "select C.id, C.name, C.phone, C.point from Customer C";
        try {
            PreparedStatement stm = connection.prepareStatement(sql); 
            ResultSet rs = stm.executeQuery();
            while(rs.next()){  
                list.add(new Customer(rs.getInt(1),
                                     rs.getString(2),
                                rs.getString(3),
                                    rs.getInt(4)));
            }
            return list;
        } catch (SQLException e) {
        } 
        return null;
    }
    public List<Customer> searchCustomerByPhone(String phoneNumber){
        List<Customer> list = new ArrayList<>();
        String sql = "select C.id, C.name, C.phone, C.point from Customer C where C.phone LIKE ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + phoneNumber + "%"); 
            ResultSet rs = stm.executeQuery();
            while(rs.next()){  
                list.add(new Customer(rs.getInt(1),
                                     rs.getString(2),
                                rs.getString(3),
                                    rs.getInt(4)));
            }
            return list;
        } catch (SQLException e) {
        } 
        return null;
    }
}
