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

@WebServlet("/categories/edit")
public class CategoryEditServlet extends HttpServlet {
    private CategoryDAO dao = new CategoryDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        try {
            Category c = dao.getById(id);
            req.setAttribute("category", c);
            req.getRequestDispatcher("/category/form.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");

        Category c = new Category();
        c.setId(id);
        c.setName(name);

        try {
            dao.update(c);
            resp.sendRedirect(req.getContextPath() + "/categories");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}