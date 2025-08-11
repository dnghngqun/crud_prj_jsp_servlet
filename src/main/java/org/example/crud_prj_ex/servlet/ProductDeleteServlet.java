package org.example.crud_prj_ex.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.crud_prj_ex.dao.ProductDAO;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/products/delete")
public class ProductDeleteServlet extends HttpServlet {
    private ProductDAO dao = new ProductDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        try {
            dao.delete(id);
            resp.sendRedirect(req.getContextPath() + "/products");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}