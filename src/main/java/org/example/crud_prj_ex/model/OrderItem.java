package org.example.crud_prj_ex.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class OrderItem {
    private int orderDetailId;
    private int orderId;
    private int productId;
    private int quantity;
    private BigDecimal price;
    private String status; // enum ('pending', 'success', 'cancel', 'error')
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Timestamp deletedAt;

    // Related objects
    private Product product;
    private Order order;

    // Default constructor
    public OrderItem() {}

    // Constructor with essential fields
    public OrderItem(int orderId, int productId, int quantity, BigDecimal price) {
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
        this.status = "pending";
    }

    // Getters and Setters
    public int getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Timestamp getDeletedAt() {
        return deletedAt;
    }

    public void setDeletedAt(Timestamp deletedAt) {
        this.deletedAt = deletedAt;
    }

    // Related objects getters/setters
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    // Legacy methods for backward compatibility
    public void setOrderItemId(int orderItemId) {
        this.orderDetailId = orderItemId;
    }

    public int getOrderItemId() {
        return orderDetailId;
    }

    public void setProductName(String productName) {
        if (this.product == null) {
            this.product = new Product();
        }
        this.product.setName(productName);
    }

    public String getProductName() {
        return product != null ? product.getName() : null;
    }

    public void setTotal(BigDecimal total) {
        // Calculate price from total and quantity if needed
        if (quantity > 0) {
            this.price = total.divide(BigDecimal.valueOf(quantity));
        }
    }

    // Utility methods
    public BigDecimal getTotal() {
        return price.multiply(BigDecimal.valueOf(quantity));
    }

    public String getStatusDisplayName() {
        switch (status) {
            case "pending": return "Chờ xử lý";
            case "success": return "Thành công";
            case "cancel": return "Đã hủy";
            case "error": return "Lỗi";
            default: return status;
        }
    }

    @Override
    public String toString() {
        return "OrderItem{" +
                "orderDetailId=" + orderDetailId +
                ", orderId=" + orderId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", price=" + price +
                ", status='" + status + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        OrderItem orderItem = (OrderItem) o;
        return orderDetailId == orderItem.orderDetailId;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(orderDetailId);
    }
}