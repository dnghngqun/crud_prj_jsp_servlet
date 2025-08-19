package org.example.crud_prj_ex.dao;

import org.example.crud_prj_ex.model.CartItem;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/gomsu";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    public List<CartItem> getByUserId(String userId) throws SQLException {
        String sql = "SELECT c.*, p.name AS product_name, p.image_url, p.price, p.discount " +
                "FROM cart c " +
                "JOIN products p ON c.product_id = p.product_id " +
                "WHERE c.user_id = ?";

        List<CartItem> items = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setId(rs.getInt("cart_id"));
                item.setUserId(rs.getString("user_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setProductName(rs.getString("product_name"));
                item.setImageUrl(rs.getString("image_url"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setDiscount(rs.getBigDecimal("discount"));
                items.add(item);
            }
        }
        return items;
    }

    public CartItem getByUserAndProduct(String userId, int productId) throws SQLException {
        String sql = "SELECT c.*, p.name AS product_name, p.image_url, p.price, p.discount " +
                "FROM cart c " +
                "JOIN products p ON c.product_id = p.product_id " +
                "WHERE c.user_id = ? AND c.product_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            stmt.setInt(2, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                CartItem item = new CartItem();
                item.setId(rs.getInt("cart_id"));
                item.setUserId(rs.getString("user_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setProductName(rs.getString("product_name"));
                item.setImageUrl(rs.getString("image_url"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setDiscount(rs.getBigDecimal("discount"));
                return item;
            }
        }
        return null;
    }

    public void addToCart(String userId, int productId, int quantity) throws SQLException {
        // Check if item already exists in cart
        CartItem existing = getByUserAndProduct(userId, productId);

        if (existing != null) {
            // Update quantity if item exists
            updateQuantity(existing.getId(), existing.getQuantity() + quantity);
        } else {
            // Add new item to cart
            String sql = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";

            try (Connection conn = getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, userId);
                stmt.setInt(2, productId);
                stmt.setInt(3, quantity);
                stmt.executeUpdate();
            }
        }
    }

    public void updateQuantity(int cartId, int quantity) throws SQLException {
        String sql = "UPDATE cart SET quantity = ? WHERE cart_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, cartId);
            stmt.executeUpdate();
        }
    }

    public void removeItem(int cartId) throws SQLException {
        String sql = "DELETE FROM cart WHERE cart_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            stmt.executeUpdate();
        }
    }

    public void clearCart(String userId) throws SQLException {
        String sql = "DELETE FROM cart WHERE user_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            stmt.executeUpdate();
        }
    }
    public List<CartItem> getCartItems(String userId) throws SQLException {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT c.cart_id, c.product_id, c.quantity, p.name as product_name, " +
                "p.price, p.discount, p.image_url " +
                "FROM cart c " +
                "JOIN products p ON c.product_id = p.product_id " +
                "WHERE c.user_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setId(rs.getInt("cart_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("product_name"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setDiscount(rs.getBigDecimal("discount"));
                item.setQuantity(rs.getInt("quantity"));
                item.setImageUrl(rs.getString("image_url"));

                // Calculate total price for this item
                BigDecimal price = item.getPrice();
                BigDecimal discount = item.getDiscount() != null ? item.getDiscount() : BigDecimal.ZERO;
                BigDecimal finalPrice = price.subtract(discount);
                BigDecimal total = finalPrice.multiply(new BigDecimal(item.getQuantity()));
                item.setTotalPrice(total);

                cartItems.add(item);
            }
        }

        return cartItems;
    }

    public int getCartItemCount(String userId) throws SQLException {
        System.out.println("=== CartDAO.getCartItemCount() for userId: " + userId + " ===");
        String sql = "SELECT SUM(quantity) FROM cart WHERE user_id = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("Cart item count from database: " + count);
                return count;
            }
        } catch (SQLException e) {
            System.err.println("SQLException in getCartItemCount: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
        return 0;
    }

}