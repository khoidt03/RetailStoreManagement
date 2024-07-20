package Model;

import java.util.Date;

public class OrderSupplier {

    private int id;
    private Supplier supplierId;
    private Date date;

    public OrderSupplier() {
    }

    public OrderSupplier(int id) {
        this.id = id;
    }

    public OrderSupplier(int id, Supplier supplierId, Date date) {
        this.id = id;
        this.supplierId = supplierId;
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Supplier getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Supplier supplierId) {
        this.supplierId = supplierId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
