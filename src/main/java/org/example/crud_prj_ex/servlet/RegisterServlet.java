package org.example.crud_prj_ex.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.crud_prj_ex.model.User;

import java.io.IOException;

@WebServlet({"/auth/register", "/register"})
public class RegisterServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if user is already logged in
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        req.getRequestDispatcher("/auth/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String email = req.getParameter("email");
        String fullName = req.getParameter("fullName");
        String phoneNumber = req.getParameter("phoneNumber");

        // Validation
        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            fullName == null || fullName.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
            req.setAttribute("email", email);
            req.setAttribute("fullName", fullName);
            req.setAttribute("phoneNumber", phoneNumber);
            req.getRequestDispatcher("/auth/register.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp");
            req.setAttribute("email", email);
            req.setAttribute("fullName", fullName);
            req.setAttribute("phoneNumber", phoneNumber);
            req.getRequestDispatcher("/auth/register.jsp").forward(req, resp);
            return;
        }

        if (password.length() < 6) {
            req.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự");
            req.setAttribute("email", email);
            req.setAttribute("fullName", fullName);
            req.setAttribute("phoneNumber", phoneNumber);
            req.getRequestDispatcher("/auth/register.jsp").forward(req, resp);
            return;
        }

        try {
            User user = new User(password.trim(), email.trim(), fullName.trim());
            if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
                user.setPhoneNumber(phoneNumber.trim());
            }

            if (userService.register(user)) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUser_id());
                resp.sendRedirect(req.getContextPath() + "/");
            } else {
                req.setAttribute("error", "Email đã được sử dụng. Vui lòng chọn email khác.");
                req.setAttribute("email", email);
                req.setAttribute("fullName", fullName);
                req.setAttribute("phoneNumber", phoneNumber);
                req.getRequestDispatcher("/auth/register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Có lỗi xảy ra trong quá trình đăng ký. Vui lòng thử lại.");
            req.setAttribute("email", email);
            req.setAttribute("fullName", fullName);
            req.setAttribute("phoneNumber", phoneNumber);
            req.getRequestDispatcher("/auth/register.jsp").forward(req, resp);
        }
    }
}
