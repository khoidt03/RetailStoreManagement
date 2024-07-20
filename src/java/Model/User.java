/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package Model;

/**
 *
 * @author
 */
public class User {
    private int userID;
    private String username;
    private String password; 
    private int status; 
    private Role role; 
    private UserInfo info;

    public User() {
    }

    public User(int userID, String username){
        this.userID = userID;
        this.username = username;
    }
    public User(int userID, String username, String password, int status) {
        this.userID = userID;
        this.username = username;
        this.password = password;
        this.status = status;
    }

    
    public User(int userID, String username, String password, Role role) {
        this.userID = userID;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public User(int userID, String username, String password, int status, Role role, UserInfo info) {
        this.userID = userID;
        this.username = username;
        this.password = password;
        this.status = status;
        this.role = role;
        this.info = info;
    }
    
    
    public User(int userID, String username, String password, int status, Role role) {
        this.userID = userID;
        this.username = username;
        this.password = password;
        this.status = status;
        this.role = role;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public UserInfo getInfo() {
        return info;
    }

    public void setInfo(UserInfo info) {
        this.info = info;
    }
    
    
 
}
