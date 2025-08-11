<%@ page import="org.example.crud_prj_ex.model.Category" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    Category c = (Category) request.getAttribute("category");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết danh mục</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <div class="header">
        <h1>👁️ Chi tiết danh mục</h1>
        <p>Thông tin chi tiết của danh mục: <strong><%= c.getName() %></strong></p>
    </div>

    <div class="detail-card">
        <div class="detail-item">
            <div class="detail-label">🆔 ID:</div>
            <div class="detail-value"><%= c.getId() %></div>
        </div>

        <div class="detail-item">
            <div class="detail-label">📝 Tên danh mục:</div>
            <div class="detail-value"><%= c.getName() %></div>
        </div>

        <div class="detail-item">
            <div class="detail-label">📅 Ngày tạo:</div>
            <div class="detail-value"><%= c.getCreatedAt() %></div>
        </div>

        <% if (c.getUpdatedAt() != null) { %>
        <div class="detail-item">
            <div class="detail-label">🔄 Ngày cập nhật:</div>
            <div class="detail-value"><%= c.getUpdatedAt() %></div>
        </div>
        <% } %>
    </div>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/categories/edit?id=<%= c.getId() %>" class="btn btn-warning" style="color: #fff">✏️ Sửa danh mục</a>
        <a href="${pageContext.request.contextPath}/categories/delete?id=<%= c.getId() %>" class="btn btn-danger" style="color: #fff"
           onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?')">🗑️ Xóa danh mục</a>
        <a href="${pageContext.request.contextPath}/categories" class="btn btn-primary" style="color: #fff">↩️ Quay lại danh sách</a>
    </div>
</div>
</body>
</html>