package org.example.crud_prj_ex.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.crud_prj_ex.dao.CartDAO;
import org.example.crud_prj_ex.model.CartItem;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("userId");

        // For demo purposes, use a fixed user ID if not logged in
        if (userId == null) {
            System.out.println("User ID not found in session, using demo user ID.");
            userId = "demo-user-id";
            session.setAttribute("userId", userId);
        }

        try {
            List<CartItem> cartItems = cartDAO.getByUserId(userId);
            req.setAttribute("cartItems", cartItems);

            // Calculate cart total
            double total = cartItems.stream()
                    .mapToDouble(item -> item.getTotal().doubleValue())
                    .sum();
            req.setAttribute("cartTotal", total);

            req.getRequestDispatcher("/cart/cart.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

}