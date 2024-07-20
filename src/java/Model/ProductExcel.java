/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import com.google.gson.annotations.SerializedName;

/**
 *
 * @author ADMIN
 */
public class ProductExcel {
    @SerializedName("Tên Sản Phẩm")
    private String productName;
    @SerializedName("Số Lượng")
    private int quantity;
    @SerializedName("Đơn Giá")
    private float price;
    @SerializedName("Giá Bán")
    private float salePrice;
    @SerializedName("Danh Mục")
    private String category;
    @SerializedName("Hạn Sử Dụng")
    private String expiredDate;
    @SerializedName("Nhà Cung Cấp")
    private String supplier;
    @SerializedName("Vị Trí")
    private String location;
    @SerializedName("Ngày Nhập")
    private String receiveDate;

    public ProductExcel() {
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public float getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(float salePrice) {
        this.salePrice = salePrice;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(String expiredDate) {
        this.expiredDate = expiredDate;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getReceiveDate() {
        return receiveDate;
    }

    public void setReceiveDate(String receiveDate) {
        this.receiveDate = receiveDate;
    }

    @Override
    public String toString() {
        return "ProductExcel{" + "productName=" + productName + ", quantity=" + quantity + ", price=" + price + ", salePrice=" + salePrice + ", category=" + category + ", expiredDate=" + expiredDate + ", supplier=" + supplier + ", location=" + location + ", receiveDate=" + receiveDate + '}';
    }
    
}
