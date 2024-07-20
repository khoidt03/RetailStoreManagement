/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Model.Role;
import Model.User;
import Model.UserInfo;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class UserDAO extends DBContext {

    SystemLogDAO log = new SystemLogDAO();
    public List<User> getUserInfo() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT Users.*, Role.name, (UI.first_name + ' ' + UI.last_name) AS fullname, "
                   + "UI.date_of_birth, UI.gender, UI.phone, UI.address, UI.email "
                   + "from Users join Role on role_id = Role.id join User_Info UI on Users.id = user_id"
                   + " where Users.Status != 0";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                UserInfo uInfo = new UserInfo(rs.getString(7),
                        rs.getDate(8),
                        rs.getInt(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getString(12));
                Role role = new Role(rs.getInt(5), rs.getString(6));
                list.add(new User(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        role,
                        uInfo));
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public User checkEmail(String email) {
        String sql = "select U.id, U.username, U.password, U.role_id from Users U "
                + "join User_Info UI on U.id = UI.user_id where UI.email = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Role role = new Role();
                return new User(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        role);
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public User login(String user, String pass) {
        String action = "Tài khoản " + user + " vừa đăng nhập vào hệ thống";
        String sql = "SELECT Users.*, Role.name from Users "
                + "join Role on role_id = Role.id where username= ? AND password = ?"
                + " AND Users.Status != 0";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, user);
            stm.setString(2, pass);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                log.insertIntoSystemLog(rs.getInt(1), action);
                Role role = new Role(rs.getInt(5), rs.getString(6));
                return new User(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        role);
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public boolean changePassword(int userID, String newpass) {
        String query = "update Users set password = ? where id = ?"; 
        try {
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setString(1, newpass);
            stm.setInt(2, userID);
            stm.executeUpdate();
            return true;
        } catch (SQLException e) {
        }
        return false;
    }

    public List<Role> getUserRole() {
        List<Role> list = new ArrayList<>();
        String sql = "select id,name from Role";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Role(rs.getInt(1), rs.getString(2)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public boolean addUser(String username, String pass, int status, int roleID) {
        String sql = "INSERT INTO Users VALUES(?,?,?,?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, pass);
            stm.setInt(3, status);
            stm.setInt(4, roleID);
            stm.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public int getInsertedID() {
        String sql = "SELECT TOP 1 * FROM Users ORDER BY Users.id DESC";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return -1;
    }

    public boolean addUserInfo(String fullname, String date, int gender, String phone, String address, String email) {
        String sql = "INSERT INTO User_Info VALUES(?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, fullname.split(" ")[0]);
            stm.setString(2, fullname.split(" ")[1]);
            stm.setString(3, date);
            stm.setInt(4, gender);
            stm.setString(5, phone);
            stm.setString(6, address);
            stm.setInt(7, getInsertedID());
            stm.setString(8, email);
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean updateUser(int userID, String password, int status, int roleID, String fName, String lName, String dob, int gender, String phone, String address, String email) {
        String sql1 = "update Users set password = ?, status = ?, role_id = ? where id = ?";
        String sql2 = "update User_Info set first_name = ?, last_name = ?, date_of_birth = ?, "
                + "gender = ?, phone = ?, address = ?, email = ? where user_id = ?";
        try {
            PreparedStatement stm1 = connection.prepareStatement(sql1);
            PreparedStatement stm2 = connection.prepareStatement(sql2);
            stm1.setString(1, password);
            stm1.setInt(2, status);
            stm1.setInt(3, roleID);
            stm1.setInt(4, userID);
            stm1.executeUpdate();

            stm2.setString(1, fName);
            stm2.setString(2, lName);
            stm2.setString(3, dob);
            stm2.setInt(4, gender);
            stm2.setString(5, phone);
            stm2.setString(6, address);
            stm2.setString(7, email);
            stm2.setInt(8, userID);
            stm2.executeUpdate();
            return true;
        } catch (Exception e) {
        }
        return false;
    }

    public void activeAccount(int userID) {
        String sql = "update Users set status = 1 where id = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, userID);
            stm.executeUpdate();
        } catch (Exception e) {
        }
    }

    public boolean deleteUser(int userID) {
        String sql = "update Users set status = ? where id = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, 0);
            stm.setInt(2, userID);
            stm.executeUpdate();
            return true;
        } catch (Exception e) {
        }
        return false;
    }
}
