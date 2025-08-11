package org.example.crud_prj_ex.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.crud_prj_ex.dao.ProductDAO;
import org.example.crud_prj_ex.model.Product;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/products/detail")
public class ProductDetailServlet extends HttpServlet {
    private ProductDAO dao = new ProductDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        try {
            Product p = dao.getById(id);
            if (p != null) {
                req.setAttribute("product", p);
                req.getRequestDispatcher("/product/detail.jsp").forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}