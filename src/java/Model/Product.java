/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ADMIN
 */
public class Product {
    private String productID;
    private String productName;
    private float price;
    private float sale_price;
    private String expiredDate;
    private Category category;
    private int status;

    public Product() {
    }

    public Product(String productID) {
        this.productID = productID;
    } 
    
    public Product(String productID, String productName) {
        this.productID = productID;
        this.productName = productName;
    }

    public Product(String productID, String productName, float price, int type) {
        this.productID = productID;
        this.productName = productName;
        if(type == 0){
            this.price = price;
        }
        else{
            this.sale_price = price;
        } 
    }
     
    public Product(String productID, String productName, float price, float sale_price, String expiredDate, Category category, int status) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.sale_price = sale_price;
        this.expiredDate = expiredDate;
        this.category = category;
        this.status = status;
    } 
    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public float getSale_price() {
        return sale_price;
    }

    public void setSale_price(float sale_price) {
        this.sale_price = sale_price;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(String expiredDate) {
        this.expiredDate = expiredDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    
    
}
