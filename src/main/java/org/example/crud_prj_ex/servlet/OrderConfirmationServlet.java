package org.example.crud_prj_ex.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.crud_prj_ex.dao.OrderDAO;
import org.example.crud_prj_ex.model.Order;
import org.example.crud_prj_ex.model.User;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/order/confirmation")
public class OrderConfirmationServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderId = req.getParameter("id");
        if (orderId == null || orderId.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/orders");
            return;
        }

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        try {
            // Use getOrderById instead of getById to fetch order with order items
            Order order = orderDAO.getOrderById(Integer.parseInt(orderId));
            if (order != null && user != null) {
                // Set the email if it's not already set
                if (order.getEmail() == null || order.getEmail().isEmpty()) {
                    order.setEmail(user.getEmail());
                }
                // Set payment method if not set
                if (order.getPaymentMethod() == null || order.getPaymentMethod().isEmpty()) {
                    order.setPaymentMethod("on_delivery");
                }
            }
            req.setAttribute("order", order);
            req.getRequestDispatcher("/order/confirmation.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
