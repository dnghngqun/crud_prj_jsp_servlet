package org.example.crud_prj_ex.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.crud_prj_ex.dao.CategoryDAO;
import org.example.crud_prj_ex.dao.ProductDAO;
import org.example.crud_prj_ex.model.Product;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/shop")
public class ShopServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String categoryIdParam = req.getParameter("categoryId");
            List<Product> products;

            if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                int categoryId = Integer.parseInt(categoryIdParam);
                products = productDAO.getByCategoryId(categoryId);
                req.setAttribute("selectedCategoryId", categoryId);
            } else {
                products = productDAO.getAll();
            }

            req.setAttribute("products", products);
            req.setAttribute("categories", categoryDAO.getAll());
            req.getRequestDispatcher("/shop/index.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}