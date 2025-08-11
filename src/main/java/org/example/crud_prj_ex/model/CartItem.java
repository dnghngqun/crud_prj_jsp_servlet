package org.example.crud_prj_ex.model;

import java.math.BigDecimal;

public class CartItem {
    private int id;
    private String userId;
    private int productId;
    private int quantity;

    // Product information (for display)
    private String productName;
    private String imageUrl;
    private BigDecimal price;
    private BigDecimal discount;

    public CartItem() {}

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public BigDecimal getDiscount() { return discount; }
    public void setDiscount(BigDecimal discount) { this.discount = discount; }

    // Calculate item total
    public BigDecimal getTotal() {
        BigDecimal finalPrice = price;
        if (discount != null && discount.compareTo(BigDecimal.ZERO) > 0) {
            finalPrice = price.subtract(discount);
        }
        return finalPrice.multiply(BigDecimal.valueOf(quantity));
    }
}