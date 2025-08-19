package org.example.crud_prj_ex.dao;

import org.example.crud_prj_ex.model.CartItem;
import org.example.crud_prj_ex.model.Order;
import org.example.crud_prj_ex.model.OrderItem;
import org.example.crud_prj_ex.model.Product;

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
        String orderSql = "INSERT INTO orders (user_id, total_price, status, shipping_address, customer_name, phone_number, note) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String orderItemSql = "INSERT INTO order_details (order_id, product_id, price, quantity, status) VALUES (?, ?, ?, ?, ?)";

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
            orderStmt.setString(5, order.getCustomerName());
            orderStmt.setString(6, order.getPhoneNumber());
            orderStmt.setString(7, order.getNote());

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
                itemStmt.setString(5, "pending");
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

    public int insertOrder(Order order, List<CartItem> cartItems) throws SQLException {
        // Convert CartItems to OrderItems
        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem cartItem : cartItems) {
            OrderItem orderItem = new OrderItem();
            orderItem.setProductId(cartItem.getProductId());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPrice(cartItem.getProduct().getPrice());
            orderItem.setStatus("pending");
            orderItems.add(orderItem);
        }

        return createOrder(order, orderItems);
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

    public List<Order> getOrdersByUserId(String userId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE user_id = ? AND deleted_at IS NULL ORDER BY created_at DESC";
        List<Order> orders = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                // Load order items for each order
                order.setOrderItems(getOrderItemsByOrderId(order.getOrderId()));
                orders.add(order);
            }
        }
        return orders;
    }

    public Order getOrderById(int orderId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE order_id = ? AND deleted_at IS NULL";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                order.setOrderItems(getOrderItemsByOrderId(orderId));
                return order;
            }
        }
        return null;
    }

    public List<OrderItem> getOrderItemsByOrderId(int orderId) throws SQLException {
        String sql = "SELECT od.*, p.name, p.description, p.image_url, p.category_id, " +
                    "c.name as category_name FROM order_details od " +
                    "LEFT JOIN products p ON od.product_id = p.product_id " +
                    "LEFT JOIN categories c ON p.category_id = c.category_id " +
                    "WHERE od.order_id = ? AND od.deleted_at IS NULL";

        List<OrderItem> orderItems = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OrderItem orderItem = mapResultSetToOrderItem(rs);
                orderItems.add(orderItem);
            }
        }
        return orderItems;
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

    public void cancelOrder(int orderId) throws SQLException {
        updateOrderStatus(orderId, "cancelled");
    }

    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setUserId(rs.getString("user_id"));
        order.setTotalPrice(rs.getBigDecimal("total_price"));
        order.setStatus(rs.getString("status"));
        order.setAddressBookId(rs.getInt("address_book_id"));
        order.setShippingAddress(rs.getString("shipping_address"));
        order.setPhoneNumber(rs.getString("phone_number"));
        order.setCustomerName(rs.getString("customer_name"));
        order.setNote(rs.getString("note"));

        if (rs.getObject("discount_id") != null) {
            order.setDiscountId(rs.getInt("discount_id"));
        }

        order.setCreatedAt(rs.getTimestamp("created_at"));
        order.setUpdatedAt(rs.getTimestamp("updated_at"));
        order.setDeletedAt(rs.getTimestamp("deleted_at"));

        return order;
    }

    private OrderItem mapResultSetToOrderItem(ResultSet rs) throws SQLException {
        OrderItem orderItem = new OrderItem();
        orderItem.setOrderDetailId(rs.getInt("order_detail_id"));
        orderItem.setOrderId(rs.getInt("order_id"));
        orderItem.setProductId(rs.getInt("product_id"));
        orderItem.setQuantity(rs.getInt("quantity"));
        orderItem.setPrice(rs.getBigDecimal("price"));
        orderItem.setStatus(rs.getString("status"));
        orderItem.setCreatedAt(rs.getTimestamp("created_at"));
        orderItem.setUpdatedAt(rs.getTimestamp("updated_at"));
        orderItem.setDeletedAt(rs.getTimestamp("deleted_at"));

        // Map product info
        try {
            ProductDAO productDAO = new ProductDAO();
            Product product = new Product();
            product.setId(rs.getInt("product_id"));
            product.setName(rs.getString("name"));
            product.setDescription(rs.getString("description"));
            product.setImageUrl(rs.getString("image_url"));
            product.setCategoryId(rs.getInt("category_id"));
            product.setCategoryName(rs.getString("category_name"));

            orderItem.setProduct(product);
        } catch (SQLException e) {
            // If product data is not available, set a minimal product object
            Product product = new Product();
            product.setId(rs.getInt("product_id"));
            product.setName("Sản phẩm đã bị xóa");
            orderItem.setProduct(product);
        }

        return orderItem;
    }
}
