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

@WebServlet("/cart/add")
public class CartAddServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("=== CartAddServlet.doPost() START ===");

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        PrintWriter out = resp.getWriter();

        try {
            HttpSession session = req.getSession(false);
            if (session == null) {
                System.out.println("No session found");
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print("{\"success\": false, \"message\": \"Vui lòng đăng nhập\"}");
                return;
            }

            User user = (User) session.getAttribute("user");
            if (user == null) {
                System.out.println("No user in session");
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print("{\"success\": false, \"message\": \"Vui lòng đăng nhập\"}");
                return;
            }

            String productIdStr = req.getParameter("productId");
            String quantityStr = req.getParameter("quantity");

            System.out.println("Adding to cart - productId: " + productIdStr + ", quantity: " + quantityStr + ", userId: " + user.getUserId());

            if (productIdStr == null || quantityStr == null) {
                out.print("{\"success\": false, \"message\": \"Thiếu thông tin sản phẩm\"}");
                return;
            }

            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);

            if (quantity <= 0) {
                out.print("{\"success\": false, \"message\": \"Số lượng phải lớn hơn 0\"}");
                return;
            }

            cartDAO.addToCart(user.getUserId(), productId, quantity);
            System.out.println("Successfully added to cart");

            out.print("{\"success\": true, \"message\": \"Đã thêm sản phẩm vào giỏ hàng\"}");

        } catch (NumberFormatException e) {
            System.err.println("Invalid number format: " + e.getMessage());
            out.print("{\"success\": false, \"message\": \"Thông tin sản phẩm không hợp lệ\"}");
        } catch (SQLException e) {
            System.err.println("SQLException in CartAddServlet: " + e.getMessage());
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"message\": \"Lỗi cơ sở dữ liệu\"}");
        } catch (Exception e) {
            System.err.println("Unexpected error in CartAddServlet: " + e.getMessage());
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"message\": \"Có lỗi xảy ra\"}");
        } finally {
            out.flush();
        }

        System.out.println("=== CartAddServlet.doPost() END ===");
    }
}
