package org.example.crud_prj_ex.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.crud_prj_ex.dao.CategoryDAO;
import org.example.crud_prj_ex.model.Category;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/categories/add")
public class CategoryAddServlet extends HttpServlet {
    private CategoryDAO dao = new CategoryDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        Category c = new Category();
        c.setName(name);
        try {
            dao.insert(c);
            resp.sendRedirect(req.getContextPath() + "/categories");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/category/form.jsp").forward(req, resp);
    }
}
