package org.example.crud_prj_ex.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.crud_prj_ex.dao.ProductDAO;
import org.example.crud_prj_ex.model.Product;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/test-products")
public class TestProductServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("=== TestProductServlet.doGet() START ===");

        resp.setContentType("text/html; charset=UTF-8");
        PrintWriter out = resp.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Test Products</title></head><body>");
        out.println("<h1>Product Test Results</h1>");

        try {
            System.out.println("Calling productDAO.getAll()...");
            List<Product> products = productDAO.getAll();

            out.println("<h2>Database Connection: SUCCESS</h2>");
            out.println("<p>Total products found: " + (products != null ? products.size() : 0) + "</p>");

            if (products != null && !products.isEmpty()) {
                out.println("<h3>First 5 Products:</h3>");
                out.println("<ul>");
                for (int i = 0; i < Math.min(5, products.size()); i++) {
                    Product p = products.get(i);
                    out.println("<li>ID: " + p.getId() + " - Name: " + p.getName() + " - Price: " + p.getPrice() + "</li>");
                }
                out.println("</ul>");

                out.println("<h3>All Products:</h3>");
                out.println("<table border='1'>");
                out.println("<tr><th>ID</th><th>Name</th><th>Price</th><th>Category</th><th>Stock</th></tr>");
                for (Product p : products) {
                    out.println("<tr>");
                    out.println("<td>" + p.getId() + "</td>");
                    out.println("<td>" + p.getName() + "</td>");
                    out.println("<td>" + p.getPrice() + "</td>");
                    out.println("<td>" + p.getCategoryName() + "</td>");
                    out.println("<td>" + p.getStock() + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            } else {
                out.println("<p><strong>No products found in database!</strong></p>");
                out.println("<p>This means either:</p>");
                out.println("<ul>");
                out.println("<li>Database is empty</li>");
                out.println("<li>All products have deleted_at IS NOT NULL</li>");
                out.println("<li>Database connection issue</li>");
                out.println("</ul>");
            }

        } catch (SQLException e) {
            System.err.println("SQLException in TestProductServlet: " + e.getMessage());
            e.printStackTrace();

            out.println("<h2>Database Connection: FAILED</h2>");
            out.println("<p><strong>Error:</strong> " + e.getMessage() + "</p>");
            out.println("<p><strong>SQL State:</strong> " + e.getSQLState() + "</p>");
            out.println("<p><strong>Error Code:</strong> " + e.getErrorCode() + "</p>");

        } catch (Exception e) {
            System.err.println("Unexpected error in TestProductServlet: " + e.getMessage());
            e.printStackTrace();

            out.println("<h2>Unexpected Error</h2>");
            out.println("<p><strong>Error:</strong> " + e.getMessage() + "</p>");
        }

        out.println("<hr>");
        out.println("<p><a href='/CRUD_PRJ_EX_war_exploded/shop'>Go to Shop</a></p>");
        out.println("</body></html>");

        System.out.println("=== TestProductServlet.doGet() END ===");
    }
}
