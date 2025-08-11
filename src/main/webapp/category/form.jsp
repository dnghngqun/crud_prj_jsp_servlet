<%@ page import="org.example.crud_prj_ex.model.Category" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    Category c = (Category) request.getAttribute("category");
    boolean edit = c != null;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= edit ? "Sửa" : "Thêm" %> danh mục</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <div class="header">
        <h1><%= edit ? "✏️ Sửa danh mục" : "➕ Thêm danh mục mới" %></h1>
        <p><%= edit ? "Cập nhật thông tin danh mục" : "Tạo danh mục sản phẩm mới" %></p>
    </div>

    <div class="form-container">
        <form method="post">
            <% if (edit) { %>
            <input type="hidden" name="id" value="<%= c.getId() %>"/>
            <% } %>

            <div class="form-group">
                <label for="name">Tên danh mục:</label>
                <input type="text" id="name" name="name" class="form-control"
                       value="<%= edit ? c.getName() : "" %>"
                       placeholder="Nhập tên danh mục..." required/>
            </div>

            <div class="actions">
                <button type="submit" class="btn btn-success">
                    <%= edit ? "💾 Cập nhật" : "➕ Thêm mới" %>
                </button>
                <a href="${pageContext.request.contextPath}/categories" class="btn btn-primary">↩️ Quay lại</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>