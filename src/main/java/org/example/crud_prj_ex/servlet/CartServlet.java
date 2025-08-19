package org.example.crud_prj_ex.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.crud_prj_ex.dao.CartDAO;
import org.example.crud_prj_ex.model.CartItem;
import org.example.crud_prj_ex.model.User;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        // Check if user is logged in
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login?redirect=" + req.getRequestURL());
            return;
        }

        try {
            List<CartItem> cartItems = cartDAO.getCartItems(user.getUser_id());
            req.setAttribute("cartItems", cartItems);

            // Calculate cart total
            BigDecimal total = cartItems.stream()
                    .map(CartItem::getTotal)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            req.setAttribute("total", total);

            req.getRequestDispatcher("/cart/cart.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Có lỗi xảy ra khi tải giỏ hàng. Vui lòng thử lại.");
            req.getRequestDispatcher("/cart/cart.jsp").forward(req, resp);
        }
    }
}