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
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/cart/count")
public class CartCountServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("=== CartCountServlet.doGet() START ===");

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        PrintWriter out = resp.getWriter();

        try {
            HttpSession session = req.getSession(false);
            int count = 0;

            if (session != null) {
                User user = (User) session.getAttribute("user");
                if (user != null) {
                    System.out.println("Getting cart count for user: " + user.getUserId());
                    count = cartDAO.getCartItemCount(user.getUserId());
                    System.out.println("Cart count: " + count);
                } else {
                    System.out.println("No user in session");
                }
            } else {
                System.out.println("No session found");
            }

            String jsonResponse = "{\"count\": " + count + "}";
            System.out.println("Sending JSON response: " + jsonResponse);
            out.print(jsonResponse);

        } catch (SQLException e) {
            System.err.println("SQLException in CartCountServlet: " + e.getMessage());
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"Database error\", \"count\": 0}");
        } catch (Exception e) {
            System.err.println("Unexpected error in CartCountServlet: " + e.getMessage());
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"Unexpected error\", \"count\": 0}");
        } finally {
            out.flush();
        }

        System.out.println("=== CartCountServlet.doGet() END ===");
    }
}
