package org.example.crud_prj_ex.dao;

import org.example.crud_prj_ex.model.CartItem;
import org.example.crud_prj_ex.model.Order;
import org.example.crud_prj_ex.model.OrderItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
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

    public int createOrder(Order order, List<OrderItem> orderItems) throws SQLException {
        String orderSql = "INSERT INTO orders (user_id, total_price, status, shipping_address, note) VALUES (?, ?, ?, ?, ?)";
        String orderItemSql = "INSERT INTO order_details (order_id, product_id, price, quantity) VALUES (?, ?, ?, ?)";

        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            // Insert order
            PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setString(1, order.getUserId());
            orderStmt.setBigDecimal(2, order.getTotalPrice());
            orderStmt.setString(3, order.getStatus());
            orderStmt.setString(4, order.getShippingAddress());
            orderStmt.setString(5, order.getNote());

            orderStmt.executeUpdate();

            ResultSet rs = orderStmt.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // Insert order items
            PreparedStatement itemStmt = conn.prepareStatement(orderItemSql);
            for (OrderItem item : orderItems) {
                itemStmt.setInt(1, orderId);
                itemStmt.setInt(2, item.getProductId());
                itemStmt.setBigDecimal(3, item.getPrice());
                itemStmt.setInt(4, item.getQuantity());
                itemStmt.addBatch();
            }
            itemStmt.executeBatch();

            conn.commit();
            return orderId;

        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    public Order getById(int orderId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToOrder(rs);
            }
        }
        return null;
    }

    public List<Order> getByUserId(String userId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY created_at DESC";
        List<Order> orders = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }
        }
        return orders;
    }

    public List<OrderItem> getOrderItems(int orderId) throws SQLException {
        String sql = "SELECT od.*, p.name AS product_name, (od.price * od.quantity) AS total FROM order_details od JOIN products p ON od.product_id = p.product_id WHERE od.order_id = ?";
        List<OrderItem> items = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderItemId(rs.getInt("order_detail_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("product_name"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setQuantity(rs.getInt("quantity"));
                item.setTotal(rs.getBigDecimal("total"));
                items.add(item);
            }
        }
        return items;
    }

    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setUserId(rs.getString("user_id"));
        order.setTotalPrice(rs.getBigDecimal("total_price"));
        order.setStatus(rs.getString("status"));
        order.setShippingAddress(rs.getString("shipping_address"));
        order.setNote(rs.getString("note"));
        order.setCreatedAt(rs.getTimestamp("created_at"));
        order.setUpdatedAt(rs.getTimestamp("updated_at"));
        return order;
    }
    public int insertOrder(Order order, List<CartItem> cartItems) throws SQLException {
        String orderSql = "INSERT INTO orders (user_id, total_price, shipping_address,customer_name, phone_number, note, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String orderItemSql = "INSERT INTO order_details (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";

        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);

            try {
                // Insert order
                PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
                orderStmt.setString(1, order.getUserId());
                orderStmt.setBigDecimal(2, order.getTotalPrice());
                orderStmt.setString(3, order.getShippingAddress());
                orderStmt.setString(4, order.getCustomerName());
                orderStmt.setString(5, order.getPhoneNumber());
                orderStmt.setString(6, order.getNote());
                orderStmt.setString(7, order.getStatus());

                orderStmt.executeUpdate();
                ResultSet rs = orderStmt.getGeneratedKeys();

                int orderId = 0;
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }

                // Insert order items
                PreparedStatement itemStmt = conn.prepareStatement(orderItemSql);
                for (CartItem item : cartItems) {
                    itemStmt.setInt(1, orderId);
                    itemStmt.setInt(2, item.getProductId());
                    itemStmt.setInt(3, item.getQuantity());
                    itemStmt.setBigDecimal(4, item.getPrice());
                    itemStmt.addBatch();
                }
                itemStmt.executeBatch();

                conn.commit();
                return orderId;

            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        }
    }

    public void updateOrderStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET status = ?, updated_at = CURRENT_TIMESTAMP WHERE order_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            stmt.executeUpdate();
        }
    }
}

