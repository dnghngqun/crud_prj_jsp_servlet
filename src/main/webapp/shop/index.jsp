<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gomsu Shop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop.css">
</head>
<body>
<div class="container">
    <div class="header">
        <h1>🛍️ Gomsu Shop</h1>
        <p>Chọn lựa sản phẩm gốm sứ đẹp và chất lượng</p>
    </div>

    <div class="shop-actions">
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">🏠 Trang chủ</a>
        <a href="${pageContext.request.contextPath}/cart" class="btn btn-warning">🛒 Giỏ hàng</a>
        <a href="${pageContext.request.contextPath}/orders" class="btn btn-success">📋 Đơn hàng</a>
    </div>

    <div class="shop-container">
        <div class="categories-sidebar">
            <h3>Danh mục sản phẩm</h3>
            <ul class="category-list">
                <li>
                    <a href="${pageContext.request.contextPath}/shop"
                       class="${empty selectedCategoryId ? 'active' : ''}">
                        Tất cả sản phẩm
                    </a>
                </li>
                <c:forEach items="${categories}" var="category">
                    <li>
                        <a href="${pageContext.request.contextPath}/shop?categoryId=${category.id}"
                           class="${selectedCategoryId == category.id ? 'active' : ''}">
                                ${category.name}
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <div class="products-grid">
            <c:if test="${empty products}">
                <div class="no-products">
                    <h3>Không có sản phẩm nào</h3>
                    <p>Không tìm thấy sản phẩm trong danh mục này</p>
                </div>
            </c:if>

            <c:forEach items="${products}" var="product">
                <div class="product-card">
                    <div class="product-image">
                        <c:choose>
                            <c:when test="${not empty product.imageUrl}">
                                <img src="${product.imageUrl}" alt="${product.name}">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/images/default-product.jpg" alt="Default product image">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="product-info">
                        <div class="product-name">${product.name}</div>
                        <div class="product-category">${product.categoryName}</div>

                        <div class="product-price">
                            <c:if test="${product.discount != null && product.discount > 0}">
                                <span class="original-price">${product.price} VNĐ</span>
                                <span class="discounted-price">${product.finalPrice} VNĐ</span>
                            </c:if>
                            <c:if test="${product.discount == null || product.discount == 0}">
                                <span class="final-price">${product.price} VNĐ</span>
                            </c:if>
                        </div>

                        <div class="product-actions">
                            <a href="${pageContext.request.contextPath}/products/detail?id=${product.id}" class="btn btn-secondary">
                                👁️ Chi tiết
                            </a>
                            <a href="${pageContext.request.contextPath}/cart/add?productId=${product.id}&quantity=1" class="btn btn-primary">
                                🛒 Thêm vào giỏ hàng
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>