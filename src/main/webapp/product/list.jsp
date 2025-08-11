<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <div class="header">
        <h1>📦 Danh sách sản phẩm</h1>
        <p>Quản lý tất cả các sản phẩm trong hệ thống</p>
    </div>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/products/add" class="btn btn-success">➕ Thêm sản phẩm mới</a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">🏠 Trang chủ</a>
    </div>

    <div class="table-container">
        <table class="table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Hình ảnh</th>
                <th>Tên sản phẩm</th>
                <th>Danh mục</th>
                <th>Giá</th>
                <th>Tồn kho</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${list}" var="p">
                <tr>
                    <td>${p.id}</td>
                    <td>
                        <c:if test="${not empty p.imageUrl}">
                            <img src="${p.imageUrl}" alt="${p.name}" style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;">
                        </c:if>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/products/detail?id=${p.id}">
                                ${p.name}
                        </a>
                    </td>
                    <td>${p.categoryName}</td>
                    <td>
                        <c:if test="${p.discount != null && p.discount > 0}">
                            <span style="text-decoration: line-through; color: #999;">${p.price}</span>
                            <span style="color: red; font-weight: bold;">${p.finalPrice}</span>
                        </c:if>
                        <c:if test="${p.discount == null || p.discount == 0}">
                            ${p.price}
                        </c:if>
                    </td>
                    <td>${p.stock}</td>
                    <td>
                        <div class="table-actions">
                            <a href="${pageContext.request.contextPath}/products/detail?id=${p.id}" class="btn btn-primary btn-sm" style="color: white">👁️ Xem</a>
                            <a href="${pageContext.request.contextPath}/products/edit?id=${p.id}" class="btn btn-warning btn-sm" style="color: white">✏️ Sửa</a>
                            <a href="${pageContext.request.contextPath}/products/delete?id=${p.id}" class="btn btn-danger btn-sm" style="color: white"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')">🗑️ Xóa</a>
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