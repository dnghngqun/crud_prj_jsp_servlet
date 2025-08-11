<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
</head>
<body>
<div class="container">
    <div class="header">
        <h1>🛒 Giỏ hàng của bạn</h1>
        <p>Xem lại các sản phẩm bạn đã chọn</p>
    </div>

    <div class="shop-actions">
        <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">🏬 Tiếp tục mua sắm</a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">🏠 Trang chủ</a>
    </div>

    <c:choose>
        <c:when test="${empty cartItems}">
            <div class="empty-cart">
                <div class="empty-cart-icon">🛒</div>
                <h2>Giỏ hàng của bạn đang trống</h2>
                <p>Hãy thêm sản phẩm vào giỏ hàng để tiếp tục</p>
                <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">Mua sắm ngay</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="cart-container">
                <div class="cart-items">
                    <c:forEach items="${cartItems}" var="item">
                        <div class="cart-item">
                            <div class="item-image">
                                <c:choose>
                                    <c:when test="${not empty item.imageUrl}">
                                        <img src="${item.imageUrl}" alt="${item.productName}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/images/default-product.jpg" alt="Default product image">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="item-details">
                                <div class="item-name">${item.productName}</div>
                                <div class="item-price">
                                    <c:if test="${item.discount != null && item.discount > 0}">
                                        <span class="original-price">${item.price} VNĐ</span>
                                        <span class="discounted-price">${item.price - item.discount} VNĐ</span>
                                    </c:if>
                                    <c:if test="${item.discount == null || item.discount == 0}">
                                        <span class="final-price">${item.price} VNĐ</span>
                                    </c:if>
                                </div>
                                <div class="item-actions">
                                    <form action="${pageContext.request.contextPath}/cart/update" method="post" class="quantity-form">
                                        <input type="hidden" name="cartId" value="${item.id}">
                                        <div class="quantity-controls">
                                            <button type="button" class="quantity-btn minus" onclick="decrementQuantity(this)">-</button>
                                            <input type="number" name="quantity" value="${item.quantity}" min="1" class="quantity-input">
                                            <button type="button" class="quantity-btn plus" onclick="incrementQuantity(this)">+</button>
                                        </div>
                                        <button type="submit" class="btn btn-primary btn-sm">Cập nhật</button>
                                    </form>
                                    <a href="${pageContext.request.contextPath}/cart/remove?id=${item.id}" class="btn btn-danger btn-sm"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?')">
                                        Xóa
                                    </a>
                                </div>
                            </div>
                            <div class="item-total">
                                <div class="total-label">Thành tiền:</div>
                                <div class="total-value">${item.total} VNĐ</div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="cart-summary">
                    <h3>Tổng đơn hàng</h3>
                    <div class="summary-row">
                        <div class="summary-label">Tạm tính:</div>
                        <div class="summary-value">${cartTotal} VNĐ</div>
                    </div>
                    <div class="summary-row total">
                        <div class="summary-label">Tổng cộng:</div>
                        <div class="summary-value">${cartTotal} VNĐ</div>
                    </div>
                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success checkout-btn">Tiến hành thanh toán</a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function incrementQuantity(btn) {
        const input = btn.parentNode.querySelector('.quantity-input');
        input.value = parseInt(input.value) + 1;
    }

    function decrementQuantity(btn) {
        const input = btn.parentNode.querySelector('.quantity-input');
        if (parseInt(input.value) > 1) {
            input.value = parseInt(input.value) - 1;
        }
    }
</script>
</body>
</html>