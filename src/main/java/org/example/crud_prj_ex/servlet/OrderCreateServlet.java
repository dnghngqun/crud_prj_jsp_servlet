package org.example.crud_prj_ex.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.crud_prj_ex.dao.OrderDAO;
import org.example.crud_prj_ex.dao.CartDAO;
import org.example.crud_prj_ex.dao.AddressBookDAO;
import org.example.crud_prj_ex.model.Order;
import org.example.crud_prj_ex.model.CartItem;
import org.example.crud_prj_ex.model.AddressBook;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/order/create")
public class OrderCreateServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();
    private CartDAO cartDAO = new CartDAO();
    private AddressBookDAO addressBookDAO = new AddressBookDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login?redirect=" + req.getRequestURI());
            return;
        }

        try {
            // Get address information
            String addressBookId = req.getParameter("addressBookId");
            String shippingAddress = "";
            String customerName = "";
            String phoneNumber = "";

            if (addressBookId != null && !addressBookId.isEmpty()) {
                // Use saved address
                AddressBook savedAddress = addressBookDAO.getById(Integer.parseInt(addressBookId));
                if (savedAddress != null) {
                    shippingAddress = savedAddress.getAddress();
                    customerName = savedAddress.getFullName();
                    phoneNumber = savedAddress.getPhoneNumber();
                }
            } else {
                // Use new address
                String newFullName = req.getParameter("newFullName");
                String newPhoneNumber = req.getParameter("newPhoneNumber");
                String newAddress = req.getParameter("newAddress");

                if (newFullName == null || newFullName.trim().isEmpty() ||
                        newPhoneNumber == null || newPhoneNumber.trim().isEmpty() ||
                        newAddress == null || newAddress.trim().isEmpty()) {

                    resp.sendRedirect(req.getContextPath() + "/checkout?error=address");
                    return;
                }

                customerName = newFullName.trim();
                phoneNumber = newPhoneNumber.trim();
                shippingAddress = newAddress.trim();

                // Save address if requested
                String saveAddress = req.getParameter("saveAddress");
                if ("true".equals(saveAddress)) {
                    AddressBook addressBook = new AddressBook();
                    addressBook.setFullName(customerName);
                    addressBook.setPhoneNumber(phoneNumber);
                    addressBook.setAddress(shippingAddress);
                    addressBook.setUserId(userId);
                    addressBookDAO.insert(addressBook);
                }
            }

            // Get cart items and calculate total
            List<CartItem> cartItems = cartDAO.getByUserId(userId);
            if (cartItems.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }

            BigDecimal totalAmount = cartItems.stream()
                    .map(CartItem::getTotal)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);

            // Create order
            Order order = new Order();
            order.setUserId(userId);
            order.setTotalPrice(totalAmount);
            order.setShippingAddress(shippingAddress);
            order.setCustomerName(customerName);
            order.setPhoneNumber(phoneNumber);
            order.setNote(req.getParameter("note"));
            order.setStatus("pending");

            // Insert order and get order ID
            int orderId = orderDAO.insertOrder(order, cartItems);

            // Clear cart after successful order
            cartDAO.clearCart(userId);

            // Redirect to order confirmation
            resp.sendRedirect(req.getContextPath() + "/order/confirmation?id=" + orderId);

        } catch (SQLException e) {
            throw new ServletException("Error creating order", e);
        }
    }
}