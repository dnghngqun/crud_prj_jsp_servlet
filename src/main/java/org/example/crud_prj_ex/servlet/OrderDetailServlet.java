package org.example.crud_prj_ex.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.crud_prj_ex.dao.OrderDAO;
import org.example.crud_prj_ex.model.Order;
import org.example.crud_prj_ex.model.OrderItem;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/orders/detail")
public class OrderDetailServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String orderId = req.getParameter("id");

            if (orderId == null || orderId.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/orders");
                return;
            }

            Order order = orderDAO.getById(Integer.parseInt(orderId));
            if (order == null) {
                resp.sendRedirect(req.getContextPath() + "/orders");
                return;
            }

            List<OrderItem> orderItems = orderDAO.getOrderItems(Integer.parseInt(orderId));

            req.setAttribute("order", order);
            req.setAttribute("orderItems", orderItems);
            req.getRequestDispatcher("/order/detail.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}