package org.example.crud_prj_ex.dao;

import org.example.crud_prj_ex.model.AddressBook;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AddressBookDAO {
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

    public List<AddressBook> getByUserId(String userId) throws SQLException {
        String sql = "SELECT * FROM address_book WHERE user_id = ?";
        List<AddressBook> addresses = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                AddressBook address = new AddressBook();
                address.setId(rs.getInt("address_book_id"));
                address.setFullName(rs.getString("full_name"));
                address.setPhoneNumber(rs.getString("phoneNumber"));
                address.setAddress(rs.getString("address"));
                address.setUserId(rs.getString("user_id"));
                addresses.add(address);
            }
        }
        return addresses;
    }

    public void insert(AddressBook addressBook) throws SQLException {
        String sql = "INSERT INTO address_book (full_name, phoneNumber, address, user_id) VALUES (?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, addressBook.getFullName());
            stmt.setString(2, addressBook.getPhoneNumber());
            stmt.setString(3, addressBook.getAddress());
            stmt.setString(4, addressBook.getUserId());
            stmt.executeUpdate();
        }
    }
    public AddressBook getById(int id) throws SQLException {
        String sql = "SELECT * FROM address_book WHERE address_book_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                AddressBook address = new AddressBook();
                address.setId(rs.getInt("address_book_id"));
                address.setFullName(rs.getString("full_name"));
                address.setPhoneNumber(rs.getString("phoneNumber"));
                address.setAddress(rs.getString("address"));
                address.setUserId(rs.getString("user_id"));
                return address;
            }
        }
        return null;
    }
}