package org.example.crud_prj_ex.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.crud_prj_ex.dao.OrderDAO;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/orders/update-status")
public class OrderUpdateStatusServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderIdParam = req.getParameter("id");
        String status = req.getParameter("status");
        if (orderIdParam == null || status == null) {
            resp.sendRedirect(req.getContextPath() + "/orders");
            return;
        }

        // Validate status to prevent SQL truncation error
        String[] validStatuses = {"pending", "success", "cancel", "error"};
        boolean isValidStatus = false;
        for (String validStatus : validStatuses) {
            if (validStatus.equals(status)) {
                isValidStatus = true;
                break;
            }
        }

        if (!isValidStatus) {
            resp.sendRedirect(req.getContextPath() + "/orders");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdParam);
            orderDAO.updateOrderStatus(orderId, status);
            resp.sendRedirect(req.getContextPath() + "/orders/detail?id=" + orderId);
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }
}
