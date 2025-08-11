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
import java.math.BigDecimal;
import java.sql.SQLException;

@WebServlet("/products/add")
public class ProductAddServlet extends HttpServlet {
    private ProductDAO dao = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setAttribute("categories", categoryDAO.getAll());
            req.getRequestDispatcher("/product/form.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Product p = new Product();
            p.setName(req.getParameter("name"));
            p.setDescription(req.getParameter("description"));
            p.setPrice(new BigDecimal(req.getParameter("price")));
            p.setImageUrl(req.getParameter("imageUrl"));

            String categoryId = req.getParameter("categoryId");
            p.setCategoryId(categoryId != null && !categoryId.isEmpty() ? Integer.parseInt(categoryId) : 0);

            p.setStock(Integer.parseInt(req.getParameter("stock")));

            String discount = req.getParameter("discount");
            if (discount != null && !discount.isEmpty()) {
                p.setDiscount(new BigDecimal(discount));
            }

            dao.insert(p);
            resp.sendRedirect(req.getContextPath() + "/products");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}