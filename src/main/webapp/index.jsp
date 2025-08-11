<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gomsu - Gốm sứ đẹp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <div class="header">
        <h1>🏺 Chào mừng đến với Gomsu</h1>
        <p>Hệ thống quản lý sản phẩm gốm sứ</p>

        <c:if test="${not empty user}">
            <div style="background: rgba(0, 122, 255, 0.1); padding: 12px; border-radius: 8px; margin-top: 15px;">
                <strong>Xin chào, ${user.fullName}!</strong>
                <a href="${pageContext.request.contextPath}/logout" style="margin-left: 15px; color: #d00;">Đăng xuất</a>
            </div>
        </c:if>
    </div>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
            📦 Quản lý sản phẩm
        </a>
        <a href="${pageContext.request.contextPath}/categories" class="btn btn-primary">
            📁 Quản lý danh mục
        </a>
        <a href="${pageContext.request.contextPath}/shop" class="btn btn-success">
            🛍️ Cửa hàng
        </a>
        <a href="${pageContext.request.contextPath}/cart" class="btn btn-warning">
            🛒 Giỏ hàng
        </a>

        <c:if test="${empty user}">
            <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary">
                🔐 Đăng nhập
            </a>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-secondary">
                📝 Đăng ký
            </a>
        </c:if>
    </div>

    <div class="detail-card">
        <h2>🌟 Về Gomsu</h2>
        <p>Gomsu là hệ thống quản lý và bán hàng chuyên về các sản phẩm gốm sứ chất lượng cao.
            Chúng tôi cung cấp các tính năng:</p>

        <ul style="margin: 20px 0; padding-left: 20px;">
            <li>📦 Quản lý sản phẩm và danh mục</li>
            <li>🛍️ Giao diện mua sắm thân thiện</li>
            <li>🛒 Giỏ hàng và đặt hàng</li>
            <li>👥 Hệ thống đăng ký/đăng nhập</li>
            <li>📱 Giao diện responsive trên mọi thiết bị</li>
        </ul>
    </div>
</div>
</body>
</html>