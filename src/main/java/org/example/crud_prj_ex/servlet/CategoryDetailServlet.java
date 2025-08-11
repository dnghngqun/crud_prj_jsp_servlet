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

@WebServlet("/categories/detail")
public class CategoryDetailServlet extends HttpServlet {
    private CategoryDAO dao = new CategoryDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        try {
            Category c = dao.getById(id);
            if (c != null) {
                req.setAttribute("category", c);
                req.getRequestDispatcher("/category/detail.jsp").forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Category not found");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
