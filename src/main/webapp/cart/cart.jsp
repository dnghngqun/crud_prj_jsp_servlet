<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng - GoMsu Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #667eea;
            --primary-dark: #5a67d8;
            --secondary: #f093fb;
            --accent: #4ecdc4;
            --success: #48bb78;
            --warning: #ed8936;
            --danger: #f56565;
            --dark: #1a202c;
            --light: #2d3748;
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: rgba(255, 255, 255, 0.2);
            --text-primary: #ffffff;
            --text-secondary: #e2e8f0;
            --text-muted: #a0aec0;
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.3);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.4);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.5);
            --radius: 8px;
            --radius-md: 12px;
            --radius-lg: 16px;
            --radius-xl: 20px;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #0f0f23 0%, #1a1a2e 50%, #16213e 100%);
            background-attachment: fixed;
            min-height: 100vh;
            margin: 0;
            padding: 0;
            color: var(--text-primary);
            overflow-x: hidden;
        }

        .navbar {
            background: rgba(26, 32, 44, 0.95);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--glass-border);
            padding: 1rem 0;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            transition: all 0.3s ease;
        }

        .navbar-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .navbar-nav {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
            gap: 2rem;
        }

        .nav-link {
            color: var(--text-secondary);
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: var(--radius);
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .nav-link:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-1px);
        }

        .main-content {
            margin-top: 100px;
            padding: 2rem;
            min-height: calc(100vh - 100px);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .cart-header {
            text-align: center;
            margin-bottom: 3rem;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            padding: 2rem;
            border-radius: var(--radius-xl);
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-md);
        }

        .cart-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .cart-subtitle {
            color: var(--text-secondary);
            font-size: 1.1rem;
        }

        .cart-content {
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: 2rem;
        }

        .cart-items {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--radius-xl);
            border: 1px solid var(--glass-border);
            overflow: hidden;
            box-shadow: var(--shadow-md);
        }

        .cart-item {
            display: grid;
            grid-template-columns: 120px 1fr auto;
            gap: 1.5rem;
            padding: 2rem;
            border-bottom: 1px solid var(--glass-border);
            align-items: center;
            transition: all 0.2s ease;
            will-change: transform, background-color;
        }

        .cart-item:hover {
            background: rgba(102, 126, 234, 0.08);
            transform: translateX(2px);
        }

        .cart-item:last-child {
            border-bottom: none;
        }

        .item-image {
            width: 120px;
            height: 120px;
            border-radius: var(--radius-lg);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            position: relative;
        }

        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.2s ease;
        }

        .cart-item:hover .item-image img {
            transform: scale(1.02);
        }

        .item-details {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .item-name {
            font-weight: 700;
            font-size: 1.25rem;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            line-height: 1.3;
        }

        .item-category {
            color: var(--text-muted);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 500;
        }

        .item-price {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            flex-wrap: wrap;
        }

        .current-price {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--primary);
        }

        .original-price {
            font-size: 1rem;
            color: var(--text-muted);
            text-decoration: line-through;
        }

        .discount-badge {
            background: var(--danger);
            color: white;
            padding: 0.25rem 0.5rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .item-actions {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 1rem;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            border-radius: var(--radius-lg);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
        }

        .qty-btn {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: transparent;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            font-weight: bold;
            color: var(--primary);
            transition: all 0.2s ease;
        }

        .qty-btn:hover:not(:disabled) {
            background: var(--primary);
            color: white;
        }

        .qty-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .qty-input {
            width: 60px;
            height: 40px;
            text-align: center;
            border: none;
            background: transparent;
            font-size: 1rem;
            font-weight: 600;
            color: var(--text-primary);
        }

        .item-total {
            text-align: center;
        }

        .total-value {
            font-weight: 700;
            font-size: 1.1rem;
            color: var(--text-primary);
        }

        .remove-btn {
            background: var(--danger);
            color: white;
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
            margin-top: 0.5rem;
        }

        .remove-btn:hover {
            background: #e53e3e;
            transform: scale(1.05);
        }

        .cart-summary {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--radius-xl);
            border: 1px solid var(--glass-border);
            padding: 2rem;
            height: fit-content;
            position: sticky;
            top: 120px;
            box-shadow: var(--shadow-md);
        }

        .summary-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: var(--text-primary);
            text-align: center;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--primary);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px dashed var(--glass-border);
        }

        .summary-row:last-of-type {
            border-bottom: none;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 2px solid var(--glass-border);
            font-size: 1.1rem;
            font-weight: 700;
        }

        .summary-label {
            color: var(--text-secondary);
            font-weight: 500;
        }

        .summary-value {
            font-weight: 600;
            color: var(--text-primary);
        }

        .checkout-btn {
            width: 100%;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: var(--radius-lg);
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 1.5rem;
            transition: all 0.2s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .checkout-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .empty-cart {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--radius-xl);
            border: 1px solid var(--glass-border);
            padding: 4rem 2rem;
            text-align: center;
            box-shadow: var(--shadow-md);
        }

        .empty-cart-icon {
            font-size: 4rem;
            color: var(--text-muted);
            margin-bottom: 1.5rem;
            opacity: 0.7;
        }

        .empty-cart-title {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: var(--text-primary);
        }

        .empty-cart-message {
            color: var(--text-secondary);
            margin-bottom: 2rem;
            font-size: 1.1rem;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            border-radius: var(--radius-lg);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.2s ease;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .continue-shopping {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: var(--radius-xl);
            padding: 1.5rem;
            margin-top: 2rem;
            text-align: center;
            box-shadow: var(--shadow-sm);
        }

        .continue-shopping a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.2s ease;
        }

        .continue-shopping a:hover {
            color: var(--secondary);
            transform: translateX(-2px);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .cart-content {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .cart-item {
                grid-template-columns: 80px 1fr;
                gap: 1rem;
                padding: 1.5rem;
            }

            .item-actions {
                grid-column: 1 / -1;
                flex-direction: row;
                justify-content: space-between;
                margin-top: 1rem;
            }

            .item-image {
                width: 80px;
                height: 80px;
            }

            .cart-title {
                font-size: 2rem;
            }

            .navbar-nav {
                display: none;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="navbar-container">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">
                <i class="fas fa-store"></i>
                GoMsu Store
            </a>
            <ul class="navbar-nav">
                <li><a href="${pageContext.request.contextPath}/" class="nav-link">
                    <i class="fas fa-home"></i> Trang Chủ
                </a></li>
                <li><a href="${pageContext.request.contextPath}/shop" class="nav-link">
                    <i class="fas fa-shopping-bag"></i> Cửa Hàng
                </a></li>
                <li><a href="${pageContext.request.contextPath}/cart" class="nav-link active">
                    <i class="fas fa-shopping-cart"></i> Giỏ Hàng
                </a></li>
                <c:if test="${not empty sessionScope.user}">
                    <li><a href="${pageContext.request.contextPath}/orders" class="nav-link">
                        <i class="fas fa-list"></i> Đơn hàng
                    </a></li>
                    <li><a href="${pageContext.request.contextPath}/logout" class="nav-link">
                        <i class="fas fa-sign-out-alt"></i> Đăng xuất
                    </a></li>
                </c:if>
                <c:if test="${empty sessionScope.user}">
                    <li><a href="${pageContext.request.contextPath}/login" class="nav-link">
                        <i class="fas fa-sign-in-alt"></i> Đăng nhập
                    </a></li>
                </c:if>
            </ul>
        </div>
    </nav>

    <main class="main-content">
        <div class="container">
            <!-- Cart Header -->
            <div class="cart-header">
                <h1 class="cart-title">
                    <i class="fas fa-shopping-cart"></i>
                    Giỏ Hàng
                </h1>
                <p class="cart-subtitle">Quản lý sản phẩm trong giỏ hàng của bạn</p>
            </div>

            <c:choose>
                <c:when test="${not empty cartItems}">
                    <div class="cart-content">
                        <!-- Cart Items -->
                        <div class="cart-items">
                            <c:forEach var="item" items="${cartItems}">
                                <div class="cart-item" data-product-id="${item.productId}">
                                    <div class="item-image">
                                        <img src="${pageContext.request.contextPath}${item.product.imageUrl}"
                                             alt="${item.product.name}"
                                             onerror="this.src='${pageContext.request.contextPath}/images/no-image.png'">
                                    </div>

                                    <div class="item-details">
                                        <h3 class="item-name">${item.product.name}</h3>
                                        <div class="item-category">
                                            <i class="fas fa-tag"></i> ${item.product.categoryName}
                                        </div>
                                        <div class="item-price">
                                            <span class="current-price">
                                                <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                            </span>
                                        </div>
                                    </div>

                                    <div class="item-actions">
                                        <div class="quantity-controls">
                                            <button class="qty-btn" onclick="updateQuantity(${item.productId}, ${item.quantity - 1})"
                                                    ${item.quantity <= 1 ? 'disabled' : ''}>
                                                <i class="fas fa-minus"></i>
                                            </button>
                                            <input type="number" class="qty-input" value="${item.quantity}"
                                                   min="1" readonly>
                                            <button class="qty-btn" onclick="updateQuantity(${item.productId}, ${item.quantity + 1})">
                                                <i class="fas fa-plus"></i>
                                            </button>
                                        </div>

                                        <div class="item-total">
                                            <div class="total-value">
                                                <fmt:formatNumber value="${item.product.price * item.quantity}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                            </div>
                                        </div>

                                        <button class="remove-btn" onclick="removeFromCart(${item.productId})" title="Xóa khỏi giỏ hàng">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Cart Summary -->
                        <div class="cart-summary">
                            <h3 class="summary-title">
                                <i class="fas fa-calculator"></i>
                                Tổng Đơn Hàng
                            </h3>

                            <div class="summary-row">
                                <span class="summary-label">Tạm tính:</span>
                                <span class="summary-value">
                                    <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                </span>
                            </div>

                            <div class="summary-row">
                                <span class="summary-label">Phí vận chuyển:</span>
                                <span class="summary-value">Miễn phí</span>
                            </div>

                            <div class="summary-row">
                                <span class="summary-label">Tổng cộng:</span>
                                <span class="summary-value" style="color: var(--primary); font-size: 1.2rem;">
                                    <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                </span>
                            </div>

                            <a href="${pageContext.request.contextPath}/checkout" class="checkout-btn">
                                <i class="fas fa-credit-card"></i>
                                Thanh Toán Ngay
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-cart">
                        <div class="empty-cart-icon">
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                        <h2 class="empty-cart-title">Giỏ hàng trống</h2>
                        <p class="empty-cart-message">
                            Bạn chưa có sản phẩm nào trong giỏ hàng. Hãy khám phá cửa hàng và thêm sản phẩm yêu thích!
                        </p>
                        <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">
                            <i class="fas fa-shopping-bag"></i>
                            Mua Sắm Ngay
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>

            <!-- Continue Shopping -->
            <div class="continue-shopping">
                <a href="${pageContext.request.contextPath}/shop">
                    <i class="fas fa-arrow-left"></i>
                    Tiếp tục mua sắm
                </a>
            </div>
        </div>
    </main>

    <script>
        function updateQuantity(productId, newQuantity) {
            if (newQuantity < 1) {
                removeFromCart(productId);
                return;
            }

            fetch('${pageContext.request.contextPath}/cart/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'productId=' + productId + '&quantity=' + newQuantity
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload();
                } else {
                    alert('Có lỗi xảy ra khi cập nhật giỏ hàng');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Có lỗi xảy ra khi cập nhật giỏ hàng');
            });
        }

        function removeFromCart(productId) {
            if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                fetch('${pageContext.request.contextPath}/cart/remove', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'productId=' + productId
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                    } else {
                        alert('Có lỗi xảy ra khi xóa sản phẩm');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi xóa sản phẩm');
                });
            }
        }
    </script>
</body>
</html>
