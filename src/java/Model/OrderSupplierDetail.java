package Model;

public class OrderSupplierDetail {

    private int id;
    private OrderSupplier orderSupplierId;
    private Product productId;
    private int quantity;
    private int price;

    public OrderSupplierDetail() {
    }

    public OrderSupplierDetail(int id, OrderSupplier orderSupplierId, Product productId, int quantity, int price) {
        this.id = id;
        this.orderSupplierId = orderSupplierId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public OrderSupplier getOrderSupplierId() {
        return orderSupplierId;
    }

    public void setOrderSupplierId(OrderSupplier orderSupplierId) {
        this.orderSupplierId = orderSupplierId;
    }

    public Product getProductId() {
        return productId;
    }

    public void setProductId(Product productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }
}
