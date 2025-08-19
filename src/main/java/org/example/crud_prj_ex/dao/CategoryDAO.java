package org.example.crud_prj_ex.dao;

import org.example.crud_prj_ex.model.Category;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
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

    public List<Category> getAll() throws SQLException {
        System.out.println("=== CategoryDAO.getAll() START ===");
        String sql = "SELECT * FROM categories WHERE deleted_at IS NULL ORDER BY name";
        System.out.println("SQL Query: " + sql);

        List<Category> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            System.out.println("Database connection successful for categories");
            int count = 0;
            while (rs.next()) {
                count++;
                Category category = mapResultSetToCategory(rs);
                list.add(category);
                if (count <= 3) {
                    System.out.println("Category " + count + ": " + category.getName() + " (ID: " + category.getCategoryId() + ")");
                }
            }
            System.out.println("Total categories found: " + count);
        } catch (SQLException e) {
            System.err.println("SQLException in CategoryDAO.getAll(): " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
        System.out.println("=== CategoryDAO.getAll() END - Returning " + list.size() + " categories ===");
        return list;
    }

    public Category getById(int id) throws SQLException {
        String sql = "SELECT * FROM categories WHERE category_id = ? AND deleted_at IS NULL";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToCategory(rs);
            }
        }
        return null;
    }

    public void insert(Category category) throws SQLException {
        String sql = "INSERT INTO categories (name) VALUES (?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category.getName());
            stmt.executeUpdate();
        }
    }

    public void update(Category category) throws SQLException {
        String sql = "UPDATE categories SET name = ? WHERE category_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category.getName());
            stmt.setInt(2, category.getCategoryId());
            stmt.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "UPDATE categories SET deleted_at = CURRENT_TIMESTAMP WHERE category_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public long count() throws SQLException {
        String sql = "SELECT COUNT(*) FROM categories WHERE deleted_at IS NULL";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getLong(1);
            }
        }
        return 0;
    }

    private Category mapResultSetToCategory(ResultSet rs) throws SQLException {
        Category category = new Category();
        category.setCategoryId(rs.getInt("category_id"));
        category.setName(rs.getString("name"));
        category.setCreatedAt(rs.getTimestamp("created_at"));
        category.setUpdatedAt(rs.getTimestamp("updated_at"));
        category.setDeletedAt(rs.getTimestamp("deleted_at"));
        return category;
    }
}