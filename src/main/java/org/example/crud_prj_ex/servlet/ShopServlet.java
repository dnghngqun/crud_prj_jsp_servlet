package org.example.crud_prj_ex.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.crud_prj_ex.dao.CategoryDAO;
import org.example.crud_prj_ex.dao.ProductDAO;
import org.example.crud_prj_ex.model.Category;
import org.example.crud_prj_ex.model.Product;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/shop")
public class ShopServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    public ShopServlet() {
        System.out.println("=== ShopServlet CONSTRUCTOR CALLED ===");
    }

    @Override
    public void init() throws ServletException {
        System.out.println("=== ShopServlet INIT CALLED ===");
        super.init();
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("=== ShopServlet.doGet() START ===");
        System.out.println("Request URI: " + req.getRequestURI());
        System.out.println("Context Path: " + req.getContextPath());
        System.out.println("Servlet Path: " + req.getServletPath());

        try {
            String categoryIdParam = req.getParameter("categoryId");
            String searchQuery = req.getParameter("search");

            System.out.println("Parameters - categoryId: " + categoryIdParam + ", search: " + searchQuery);

            List<Product> products;
            List<Category> categories = categoryDAO.getAll();

            System.out.println("Categories loaded: " + (categories != null ? categories.size() : "null"));

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                System.out.println("Searching products by name: " + searchQuery.trim());
                products = productDAO.searchByName(searchQuery.trim());
                req.setAttribute("searchQuery", searchQuery.trim());
            } else if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                try {
                    int categoryId = Integer.parseInt(categoryIdParam);
                    System.out.println("Getting products by categoryId: " + categoryId);
                    products = productDAO.getByCategoryId(categoryId);
                    req.setAttribute("selectedCategoryId", categoryId);
                } catch (NumberFormatException e) {
                    System.out.println("Invalid categoryId format, getting all products");
                    products = productDAO.getAll();
                }
            } else {
                System.out.println("Getting all products");
                products = productDAO.getAll();
            }

            System.out.println("Products loaded: " + (products != null ? products.size() : "null"));

            if (products != null && products.size() > 0) {
                System.out.println("First product: " + products.get(0));
            }

            req.setAttribute("products", products);
            req.setAttribute("categories", categories);

            System.out.println("Forwarding to /shop/index.jsp");
            req.getRequestDispatcher("/shop/index.jsp").forward(req, resp);

        } catch (SQLException e) {
            System.err.println("SQLException in ShopServlet: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra khi tải sản phẩm. Vui lòng thử lại.");
            req.getRequestDispatcher("/shop/index.jsp").forward(req, resp);
        } catch (Exception e) {
            System.err.println("Unexpected error in ShopServlet: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi không mong muốn xảy ra.");
            req.getRequestDispatcher("/shop/index.jsp").forward(req, resp);
        }

        System.out.println("=== ShopServlet.doGet() END ===");
    }
}