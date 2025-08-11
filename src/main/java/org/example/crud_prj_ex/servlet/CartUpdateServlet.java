package org.example.crud_prj_ex.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.crud_prj_ex.dao.CartDAO;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/cart/update")
public class CartUpdateServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int cartId = Integer.parseInt(req.getParameter("cartId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        try {
            if (quantity > 0) {
                cartDAO.updateQuantity(cartId, quantity);
            } else {
                cartDAO.removeItem(cartId);
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}