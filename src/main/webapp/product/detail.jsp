<%@ page import="org.example.crud_prj_ex.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    Product p = (Product) request.getAttribute("product");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <div class="header">
        <h1>👁️ Chi tiết sản phẩm</h1>
        <p>Thông tin chi tiết của sản phẩm: <strong><%= p.getName() %></strong></p>
    </div>

    <div class="detail-card">
        <% if (p.getImageUrl() != null && !p.getImageUrl().isEmpty()) { %>
        <div style="text-align: center; margin-bottom: 20px;">
            <img src="<%= p.getImageUrl() %>" alt="<%= p.getName() %>"
                 style="max-width: 300px; max-height: 300px; object-fit: contain; border-radius: 8px; box-shadow: var(--shadow-md);">
        </div>
        <% } %>

        <div class="detail-item">
            <div class="detail-label">🆔 ID:</div>
            <div class="detail-value"><%= p.getId() %></div>
        </div>

        <div class="detail-item">
            <div class="detail-label">📝 Tên sản phẩm:</div>
            <div class="detail-value"><%= p.getName() %></div>
        </div>

        <div class="detail-item">
            <div class="detail-label">📁 Danh mục:</div>
            <div class="detail-value"><%= p.getCategoryName() != null ? p.getCategoryName() : "Chưa phân loại" %></div>
        </div>

        <div class="detail-item">
            <div class="detail-label">💰 Giá:</div>
            <div class="detail-value">
                <% if (p.getDiscount() != null && p.getDiscount().compareTo(java.math.BigDecimal.ZERO) > 0) { %>
                <span style="text-decoration: line-through; color: #999;"><%= p.getPrice() %></span>
                <span style="color: red; font-weight: bold;"><%= p.getFinalPrice() %></span>
                <% } else { %>
                <%= p.getPrice() %>
                <% } %>
            </div>
        </div>

        <% if (p.getDiscount() != null && p.getDiscount().compareTo(java.math.BigDecimal.ZERO) > 0) { %>
        <div class="detail-item">
            <div class="detail-label">🏷️ Giảm giá:</div>
            <div class="detail-value"><%= p.getDiscount() %></div>
        </div>
        <% } %>

        <div class="detail-item">
            <div class="detail-label">📦 Tồn kho:</div>
            <div class="detail-value"><%= p.getStock() %></div>
        </div>

        <% if (p.getDescription() != null && !p.getDescription().isEmpty()) { %>
        <div class="detail-item">
            <div class="detail-label">📄 Mô tả:</div>
            <div class="detail-value"><%= p.getDescription() %></div>
        </div>
        <% } %>

        <div class="detail-item">
            <div class="detail-label">📅 Ngày tạo:</div>
            <div class="detail-value"><%= p.getCreatedAt() %></div>
        </div>

        <% if (p.getUpdatedAt() != null) { %>
        <div class="detail-item">
            <div class="detail-label">🔄 Ngày cập nhật:</div>
            <div class="detail-value"><%= p.getUpdatedAt() %></div>
        </div>
        <% } %>
    </div>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/products/edit?id=<%= p.getId() %>" class="btn btn-warning" style="color: #fff">✏️ Sửa sản phẩm</a>
        <a href="${pageContext.request.contextPath}/products/delete?id=<%= p.getId() %>" class="btn btn-danger" style="color: #fff"
           onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')">🗑️ Xóa sản phẩm</a>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary" style="color: #fff">↩️ Quay lại danh sách</a>
    </div>
</div>
</body>
</html>