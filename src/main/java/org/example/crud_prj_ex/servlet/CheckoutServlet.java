package org.example.crud_prj_ex.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.crud_prj_ex.dao.CartDAO;
import org.example.crud_prj_ex.dao.OrderDAO;
import org.example.crud_prj_ex.model.CartItem;
import org.example.crud_prj_ex.model.Order;
import org.example.crud_prj_ex.model.OrderItem;
import org.example.crud_prj_ex.model.User;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            // Redirect to login if not logged in
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            List<CartItem> cartItems = cartDAO.getCartItems(user.getUser_id());
            BigDecimal total = calculateTotal(cartItems);

            req.setAttribute("cartItems", cartItems);
            req.setAttribute("total", total);
            req.getRequestDispatcher("/order/checkout.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            // Get cart items
            List<CartItem> cartItems = cartDAO.getCartItems(user.getUser_id());
            if (cartItems.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }

            // Get form data
            String customerName = req.getParameter("customerName");
            String phoneNumber = req.getParameter("phoneNumber");
            String shippingAddress = req.getParameter("shippingAddress");
            String note = req.getParameter("note");
            String paymentMethod = req.getParameter("paymentMethod");

            // Create order
            Order order = new Order();
            order.setUserId(user.getUser_id());
            order.setTotalPrice(calculateTotal(cartItems));
            order.setStatus("pending");
            order.setCustomerName(customerName != null ? customerName : user.getFullName());
            order.setPhoneNumber(phoneNumber != null ? phoneNumber : user.getPhoneNumber());
            order.setShippingAddress(shippingAddress);
            order.setNote(note);
            order.setPaymentMethod(paymentMethod);
            order.setEmail(user.getEmail());

            // Process payment
            boolean paymentSuccess = processPayment(paymentMethod, order.getTotalPrice());

            if (paymentSuccess) {
                // Save order using insertOrder method which handles CartItem directly
                int orderId = orderDAO.insertOrder(order, cartItems);

                // Clear cart after successful order
                cartDAO.clearCart(user.getUser_id());

                // Redirect to confirmation page
                resp.sendRedirect(req.getContextPath() + "/order/confirmation?id=" + orderId);
            } else {
                req.setAttribute("error", "Payment processing failed. Please try again.");
                req.setAttribute("cartItems", cartItems);
                req.setAttribute("total", order.getTotalPrice());
                req.getRequestDispatcher("/order/checkout.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private BigDecimal calculateTotal(List<CartItem> cartItems) {
        return cartItems.stream()
                .map(CartItem::getTotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    private boolean processPayment(String method, BigDecimal amount) {
        // Simulate payment processing - always return true for demo
        return true;
    }

    private List<OrderItem> convertCartItemsToOrderItems(List<CartItem> cartItems) {
        List<OrderItem> orderItems = new ArrayList<>();

        for (CartItem cartItem : cartItems) {
            OrderItem orderItem = new OrderItem();
            orderItem.setProductId(cartItem.getProductId());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPrice(cartItem.getPrice());
            orderItems.add(orderItem);
        }

        return orderItems;
    }
}