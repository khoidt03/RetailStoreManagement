/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ADMIN
 */
public class InvoiceDetail { 
    private int invoiceDetailID;
    private String invoiceID;
    private Product product;
    private int quantity;

    public InvoiceDetail() {
    }

    public InvoiceDetail(int invoiceDetailID, String invoiceID, Product product, int quantity) {
        this.invoiceDetailID = invoiceDetailID;
        this.invoiceID = invoiceID;
        this.product = product;
        this.quantity = quantity;
    }

    public int getInvoiceDetailID() {
        return invoiceDetailID;
    }

    public void setInvoiceDetailID(int invoiceDetailID) {
        this.invoiceDetailID = invoiceDetailID;
    }

    public String getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(String invoiceID) {
        this.invoiceID = invoiceID;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
 
    
}
