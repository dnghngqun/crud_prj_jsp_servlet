package org.example.crud_prj_ex.dao;

import org.example.crud_prj_ex.model.Product;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
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

    public List<Product> getAll() throws SQLException {
        String sql = "SELECT p.*, c.name as category_name FROM products p " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "WHERE p.deleted_at IS NULL";
        List<Product> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToProduct(rs));
            }
        }
        return list;
    }

    public Product getById(int id) throws SQLException {
        String sql = "SELECT p.*, c.name as category_name FROM products p " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "WHERE p.product_id = ? AND p.deleted_at IS NULL";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToProduct(rs);
            }
        }
        return null;
    }

    public void insert(Product product) throws SQLException {
        String sql = "INSERT INTO products (name, description, price, image_url, category_id, stock, discount) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setBigDecimal(3, product.getPrice());
            stmt.setString(4, product.getImageUrl());

            if (product.getCategoryId() > 0) {
                stmt.setInt(5, product.getCategoryId());
            } else {
                stmt.setNull(5, Types.INTEGER);
            }

            stmt.setInt(6, product.getStock());

            if (product.getDiscount() != null) {
                stmt.setBigDecimal(7, product.getDiscount());
            } else {
                stmt.setNull(7, Types.DECIMAL);
            }

            stmt.executeUpdate();
        }
    }

    public void update(Product product) throws SQLException {
        String sql = "UPDATE products SET name = ?, description = ?, price = ?, " +
                "image_url = ?, category_id = ?, stock = ?, discount = ? " +
                "WHERE product_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setBigDecimal(3, product.getPrice());
            stmt.setString(4, product.getImageUrl());

            if (product.getCategoryId() > 0) {
                stmt.setInt(5, product.getCategoryId());
            } else {
                stmt.setNull(5, Types.INTEGER);
            }

            stmt.setInt(6, product.getStock());

            if (product.getDiscount() != null) {
                stmt.setBigDecimal(7, product.getDiscount());
            } else {
                stmt.setNull(7, Types.DECIMAL);
            }

            stmt.setInt(8, product.getId());
            stmt.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "UPDATE products SET deleted_at = CURRENT_TIMESTAMP WHERE product_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public List<Product> getByCategoryId(int categoryId) throws SQLException {
        String sql = "SELECT p.*, c.name as category_name FROM products p " +
                "LEFT JOIN categories c ON p.category_id = c.category_id " +
                "WHERE p.category_id = ? AND p.deleted_at IS NULL";

        List<Product> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToProduct(rs));
            }
        }
        return list;
    }

    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("product_id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getBigDecimal("price"));
        product.setImageUrl(rs.getString("image_url"));
        product.setCategoryId(rs.getInt("category_id"));
        product.setStock(rs.getInt("stock"));
        product.setDiscount(rs.getBigDecimal("discount"));
        product.setCreatedAt(rs.getTimestamp("created_at"));
        product.setUpdatedAt(rs.getTimestamp("updated_at"));
        product.setDeletedAt(rs.getTimestamp("deleted_at"));

        try {
            product.setCategoryName(rs.getString("category_name"));
        } catch (SQLException e) {
            // Ignore if category_name column is not in the result set
        }

        return product;
    }
}