<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách danh mục</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <div class="header">
        <h1>📋 Danh sách danh mục</h1>
        <p>Quản lý tất cả các danh mục sản phẩm trong hệ thống</p>
    </div>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/categories/add" class="btn btn-success">➕ Thêm danh mục mới</a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">🏠 Trang chủ</a>
    </div>

    <div class="table-container">
        <table class="table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên danh mục</th>
                <th>Ngày tạo</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${list}" var="c">
                <tr>
                    <td>${c.id}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/categories/detail?id=${c.id}">
                                ${c.name}
                        </a>
                    </td>
                    <td>${c.createdAt}</td>
                    <td>
                        <div class="table-actions">
                            <a href="${pageContext.request.contextPath}/categories/detail?id=${c.id}" class="btn btn-primary btn-sm" style="color: white">👁️ Xem</a>
                            <a href="${pageContext.request.contextPath}/categories/edit?id=${c.id}" class="btn btn-warning btn-sm" style="color: white">✏️ Sửa</a>
                            <a href="${pageContext.request.contextPath}/categories/delete?id=${c.id}" class="btn btn-danger btn-sm" style="color: white"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?')">🗑️ Xóa</a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>