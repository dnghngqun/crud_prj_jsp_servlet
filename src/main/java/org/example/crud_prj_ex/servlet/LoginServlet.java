package org.example.crud_prj_ex.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.crud_prj_ex.model.User;

import java.io.IOException;

@WebServlet({"/auth/login", "/login"})
public class LoginServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if user is already logged in
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");  // Changed from username to email
        String password = req.getParameter("password");
        String redirectURL = req.getParameter("redirect");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ email và mật khẩu");
            req.setAttribute("redirect", redirectURL);
            req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);
            return;
        }

        try {
            User user = userService.login(email.trim(), password);

            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUser_id());

                // Redirect to original page or default to home
                if (redirectURL != null && !redirectURL.isEmpty()) {
                    resp.sendRedirect(redirectURL);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/");
                }
            } else {
                req.setAttribute("error", "Email hoặc mật khẩu không đúng");
                req.setAttribute("email", email); // Preserve email
                req.setAttribute("redirect", redirectURL);
                req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Có lỗi xảy ra trong quá trình đăng nhập. Vui lòng thử lại.");
            req.setAttribute("email", email);
            req.setAttribute("redirect", redirectURL);
            req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);
        }
    }
}
