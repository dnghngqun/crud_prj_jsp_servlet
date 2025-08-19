package org.example.crud_prj_ex.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class CartItem {
    private int cartId;
    private String userId;
    private int productId;
    private int quantity;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Related objects
    private Product product;
    private User user;

    // Default constructor
    public CartItem() {}

    // Constructor with essential fields
    public CartItem(String userId, int productId, int quantity) {
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
    }

    // Getters and Setters
    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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

    // Related objects getters/setters
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    // Utility methods
    public BigDecimal getTotal() {
        if (product != null && product.getPrice() != null) {
            BigDecimal finalPrice = product.getPrice();

            // Apply discount if available
            if (product.getDiscount() != null && product.getDiscount().compareTo(BigDecimal.ZERO) > 0) {
                BigDecimal discountMultiplier = BigDecimal.ONE.subtract(
                    product.getDiscount().divide(BigDecimal.valueOf(100))
                );
                finalPrice = product.getPrice().multiply(discountMultiplier);
            }

            return finalPrice.multiply(BigDecimal.valueOf(quantity));
        }
        return BigDecimal.ZERO;
    }

    public BigDecimal getItemPrice() {
        if (product != null && product.getPrice() != null) {
            BigDecimal finalPrice = product.getPrice();

            // Apply discount if available
            if (product.getDiscount() != null && product.getDiscount().compareTo(BigDecimal.ZERO) > 0) {
                BigDecimal discountMultiplier = BigDecimal.ONE.subtract(
                    product.getDiscount().divide(BigDecimal.valueOf(100))
                );
                finalPrice = product.getPrice().multiply(discountMultiplier);
            }

            return finalPrice;
        }
        return BigDecimal.ZERO;
    }

    // Legacy methods for backward compatibility with CartDAO
    public int getId() {
        return cartId;
    }

    public void setId(int id) {
        this.cartId = id;
    }

    public String getProductName() {
        return product != null ? product.getName() : null;
    }

    public void setProductName(String productName) {
        if (this.product == null) {
            this.product = new Product();
        }
        this.product.setName(productName);
    }

    public String getImageUrl() {
        return product != null ? product.getImageUrl() : null;
    }

    public void setImageUrl(String imageUrl) {
        if (this.product == null) {
            this.product = new Product();
        }
        this.product.setImageUrl(imageUrl);
    }

    public BigDecimal getPrice() {
        return product != null ? product.getPrice() : BigDecimal.ZERO;
    }

    public void setPrice(BigDecimal price) {
        if (this.product == null) {
            this.product = new Product();
        }
        this.product.setPrice(price);
    }

    public BigDecimal getDiscount() {
        return product != null ? product.getDiscount() : BigDecimal.ZERO;
    }

    public void setDiscount(BigDecimal discount) {
        if (this.product == null) {
            this.product = new Product();
        }
        this.product.setDiscount(discount);
    }

    public BigDecimal getTotalPrice() {
        return getTotal();
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        // This is typically calculated, but we can store it if needed
        // Usually this would be calculated from price * quantity
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "cartId=" + cartId +
                ", userId='" + userId + '\'' +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CartItem cartItem = (CartItem) o;
        return cartId == cartItem.cartId;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(cartId);
    }
}