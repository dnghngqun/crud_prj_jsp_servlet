package org.example.crud_prj_ex.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.crud_prj_ex.dao.CartDAO;
import org.example.crud_prj_ex.model.User;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/cart/add")
public class CartAddServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("userId");

        // If user is not logged in, redirect to login page
        if (userId == null) {
            String currentUrl = req.getRequestURL().toString();
            if (req.getQueryString() != null) {
                currentUrl += "?" + req.getQueryString();
            }
            resp.sendRedirect(req.getContextPath() + "/login?redirect=" +
                    java.net.URLEncoder.encode(currentUrl, "UTF-8"));
            return;
        }

        // Verify user exists in the system (using email as userId)
        User user = userService.getUserById(userId);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            cartDAO.addToCart(userId, productId, quantity);
            resp.sendRedirect(req.getContextPath() + "/cart");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}