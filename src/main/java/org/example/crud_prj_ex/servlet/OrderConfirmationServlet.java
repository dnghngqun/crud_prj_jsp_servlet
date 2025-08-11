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

        try {
            Order order = orderDAO.getById(Integer.parseInt(orderId));
            req.setAttribute("order", order);
            req.getRequestDispatcher("/order/confirmation.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}