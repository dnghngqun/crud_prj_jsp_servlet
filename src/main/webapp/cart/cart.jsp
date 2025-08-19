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
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .nav-link:hover,
        .nav-link.active {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
        }

        .user-menu {
            position: relative;
        }

        .dropdown {
            position: relative;
        }

        .dropdown-menu {
            position: absolute;
            top: 100%;
            right: 0;
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border: 1px solid var(--glass-border);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-lg);
            padding: 0.5rem;
            min-width: 200px;
            opacity: 0;
            visibility: hidden;
            transform: translateY(-10px);
            transition: all 0.3s ease;
        }

        .dropdown:hover .dropdown-menu {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .dropdown-item {
            display: block;
            padding: 0.75rem 1rem;
            color: var(--text-primary);
            text-decoration: none;
            border-radius: var(--radius);
            transition: background 0.2s ease;
        }

        .dropdown-item:hover {
            background: rgba(255, 255, 255, 0.1);
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
        }

        .cart-item {
            display: grid;
            grid-template-columns: 120px 1fr auto;
            gap: 1.5rem;
            padding: 2rem;
            border-bottom: 1px solid var(--glass-border);
            align-items: center;
            transition: all 0.3s ease;
        }

        .cart-item:hover {
            background: rgba(102, 126, 234, 0.1);
            transform: translateX(5px);
        }

        .cart-item:last-child {
            border-bottom: none;
        }

        .item-image {
            width: 120px;
            height: 120px;
            border-radius: var(--radius-lg);
            overflow: hidden;
            box-shadow: var(--shadow-md);
            position: relative;
        }

        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .cart-item:hover .item-image img {
            transform: scale(1.05);
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
            transition: all 0.3s ease;
            margin-top: 0.5rem;
        }

        .remove-btn:hover {
            background: #e53e3e;
            transform: scale(1.1);
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
            transition: all 0.3s ease;
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
            transition: all 0.3s ease;
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

        /* Coupon section styles */
        .coupon-section {
            margin: 1.5rem 0;
            display: flex;
            gap: 0.5rem;
        }

        .coupon-input {
            flex: 1;
            padding: 0.75rem;
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            border-radius: var(--radius);
            color: var(--text-primary);
            font-size: 0.9rem;
        }

        .coupon-input::placeholder {
            color: var(--text-muted);
        }

        .coupon-btn {
            padding: 0.75rem 1rem;
            background: var(--accent);
            color: white;
            border: none;
            border-radius: var(--radius);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .coupon-btn:hover {
            background: #45b7aa;
            transform: translateY(-1px);
        }

        /* Checkout actions */
        .checkout-actions {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .btn-checkout {
            width: 100%;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: var(--radius-lg);
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-checkout:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-continue {
            width: 100%;
            background: transparent;
            color: var(--text-secondary);
            border: 1px solid var(--glass-border);
            padding: 0.75rem 1.5rem;
            border-radius: var(--radius-lg);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            text-decoration: none;
        }

        .btn-continue:hover {
            background: var(--glass-bg);
            color: var(--text-primary);
            transform: translateY(-1px);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .navbar-container {
                padding: 0 1rem;
            }

            .navbar-nav {
                gap: 1rem;
            }

            .main-content {
                padding: 1rem;
                margin-top: 80px;
            }

            .cart-content {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .cart-item {
                grid-template-columns: 80px 1fr;
                gap: 1rem;
                padding: 1.5rem;
            }

            .item-image {
                width: 80px;
                height: 80px;
            }

            .item-actions {
                grid-column: 1 / -1;
                flex-direction: row;
                justify-content: space-between;
                margin-top: 1rem;
            }

            .cart-title {
                font-size: 2rem;
            }
        }

        /* Notification */
        .notification {
            position: fixed;
            top: 100px;
            right: 20px;
            background: var(--success);
            color: white;
            padding: 1rem 1.5rem;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            transform: translateX(400px);
            transition: transform 0.3s ease;
            z-index: 1001;
        }

        .notification.show {
            transform: translateX(0);
        }

        .notification.error {
            background: var(--danger);
        }
    </style>
</head>
<body>
    <!-- Fixed Navbar -->
    <nav class="navbar" id="navbar">
        <div class="navbar-container">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">
                <i class="fas fa-store"></i>
                GoMsu Store
            </a>

            <ul class="navbar-nav" id="navbarNav">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/" class="nav-link">
                        <i class="fas fa-home"></i> Trang Chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/shop" class="nav-link">
                        <i class="fas fa-shopping-bag"></i> Cửa Hàng
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/cart" class="nav-link active">
                        <i class="fas fa-shopping-cart"></i> Giỏ Hàng
                    </a>
                </li>
            </ul>

            <div class="user-menu">
                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <div class="dropdown">
                            <a href="#" class="nav-link">
                                <i class="fas fa-user"></i> ${sessionScope.user.username}
                            </a>
                            <div class="dropdown-menu">
                                <a href="${pageContext.request.contextPath}/profile" class="dropdown-item">Hồ Sơ</a>
                                <a href="${pageContext.request.contextPath}/orders" class="dropdown-item">Đơn Hàng</a>
                                <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">Đăng Xuất</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">
                            <i class="fas fa-sign-in-alt"></i> Đăng Nhập
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container">
            <div class="cart-header">
                <h1 class="cart-title">
                    <i class="fas fa-shopping-cart"></i>
                    Giỏ Hàng Của Bạn
                </h1>
                <p class="cart-subtitle">
                    <c:choose>
                        <c:when test="${fn:length(cartItems) > 0}">
                            Bạn có ${fn:length(cartItems)} sản phẩm trong giỏ hàng
                        </c:when>
                        <c:otherwise>
                            Giỏ hàng của bạn đang trống
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>

            <c:choose>
                <c:when test="${fn:length(cartItems) > 0}">
                    <div class="cart-content">
                        <div class="cart-items">
                            <c:forEach var="item" items="${cartItems}">
                                <div class="cart-item" data-id="${item.id}">
                                    <div class="item-image">
                                        <img src="${not empty item.product.imageUrl ? item.product.imageUrl : '/images/no-image.jpg'}"
                                             alt="${item.product.name}" loading="lazy">
                                    </div>

                                    <div class="item-details">
                                        <h3 class="item-name">${item.product.name}</h3>
                                        <p class="item-category">${item.product.categoryName}</p>
                                        <div class="item-price">
                                            <c:choose>
                                                <c:when test="${item.product.discount != null && item.product.discount > 0}">
                                                    <span class="current-price">
                                                        <fmt:formatNumber value="${item.product.price * (1 - item.product.discount/100)}" type="currency" currencyCode="VND"/>
                                                    </span>
                                                    <span class="original-price">
                                                        <fmt:formatNumber value="${item.product.price}" type="currency" currencyCode="VND"/>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="current-price">
                                                        <fmt:formatNumber value="${item.product.price}" type="currency" currencyCode="VND"/>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>

                                    <div class="item-actions">
                                        <div class="quantity-controls">
                                            <button class="qty-btn" onclick="updateQuantity(${item.id}, ${item.quantity - 1})"
                                                    ${item.quantity <= 1 ? 'disabled' : ''} type="button">
                                                <i class="fas fa-minus"></i>
                                            </button>
                                            <input type="number" class="qty-input" value="${item.quantity}"
                                                   min="1" max="99" onchange="updateQuantity(${item.id}, this.value)">
                                            <button class="qty-btn" onclick="updateQuantity(${item.id}, ${item.quantity + 1})" type="button">
                                                <i class="fas fa-plus"></i>
                                            </button>
                                        </div>

                                        <div class="item-total">
                                            <c:set var="itemPrice" value="${item.product.discount != null && item.product.discount > 0 ?
                                                item.product.price * (1 - item.product.discount/100) : item.product.price}" />
                                            <fmt:formatNumber value="${itemPrice * item.quantity}" type="currency" currencyCode="VND"/>
                                        </div>

                                        <button class="remove-btn" onclick="removeItem(${item.id})"
                                                title="Xóa sản phẩm" type="button">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="cart-summary">
                            <div class="summary-card">
                                <h3 class="summary-title">Tóm Tắt Đơn Hàng</h3>

                                <div class="summary-row">
                                    <span>Tạm tính (${fn:length(cartItems)} sản phẩm):</span>
                                    <span id="subtotal">
                                        <fmt:formatNumber value="${cartTotal}" type="currency" currencyCode="VND"/>
                                    </span>
                                </div>

                                <div class="summary-row">
                                    <span>Phí vận chuyển:</span>
                                    <span class="shipping-fee">Miễn phí</span>
                                </div>

                                <div class="summary-row discount-row" style="display: none;">
                                    <span>Giảm giá:</span>
                                    <span class="discount-amount">-0₫</span>
                                </div>

                                <hr>

                                <div class="summary-row total-row">
                                    <span>Tổng cộng:</span>
                                    <span class="total-amount" id="totalAmount">
                                        <fmt:formatNumber value="${cartTotal}" type="currency" currencyCode="VND"/>
                                    </span>
                                </div>

                                <div class="coupon-section">
                                    <input type="text" class="coupon-input" placeholder="Nhập mã giảm giá" id="couponInput">
                                    <button class="coupon-btn" onclick="applyCoupon()">Áp dụng</button>
                                </div>

                                <div class="checkout-actions">
                                    <button class="btn-checkout" onclick="proceedToCheckout()">
                                        <i class="fas fa-credit-card"></i>
                                        Tiến Hành Thanh Toán
                                    </button>
                                    <a href="${pageContext.request.contextPath}/shop" class="btn-continue">
                                        <i class="fas fa-arrow-left"></i>
                                        Tiếp Tục Mua Sắm
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-cart">
                        <div class="empty-cart-icon">
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                        <h2 class="empty-cart-title">Giỏ hàng của bạn đang trống</h2>
                        <p class="empty-cart-message">Hãy khám phá các sản phẩm tuyệt vời của chúng tôi!</p>
                        <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">
                            <i class="fas fa-shopping-bag"></i>
                            Bắt Đầu Mua Sắm
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        // Fixed navbar on scroll
        window.addEventListener('scroll', function() {
            const navbar = document.getElementById('navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });

        // Update quantity function
        function updateQuantity(itemId, newQuantity) {
            if (newQuantity < 1) {
                removeItem(itemId);
                return;
            }

            if (newQuantity > 99) {
                showNotification('Số lượng không được vượt quá 99', 'error');
                return;
            }

            fetch('${pageContext.request.contextPath}/cart/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'itemId=' + itemId + '&quantity=' + newQuantity
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload();
                } else {
                    showNotification(data.message || 'Có lỗi xảy ra!', 'error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showNotification('Có lỗi xảy ra khi cập nhật!', 'error');
            });
        }

        // Remove item function
        function removeItem(itemId) {
            if (!confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                return;
            }

            fetch('${pageContext.request.contextPath}/cart/remove', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'itemId=' + itemId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload();
                } else {
                    showNotification(data.message || 'Có lỗi xảy ra!', 'error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showNotification('Có lỗi xảy ra khi xóa sản phẩm!', 'error');
            });
        }

        // Apply coupon function
        function applyCoupon() {
            const couponCode = document.getElementById('couponInput').value.trim();
            if (!couponCode) {
                showNotification('Vui lòng nhập mã giảm giá!', 'error');
                return;
            }

            // Simulate coupon application
            showNotification('Tính năng mã giảm giá đang được phát triển!', 'info');
        }

        // Proceed to checkout function
        function proceedToCheckout() {
            <c:choose>
                <c:when test="${sessionScope.user != null}">
                    window.location.href = '${pageContext.request.contextPath}/checkout';
                </c:when>
                <c:otherwise>
                    if (confirm('Bạn cần đăng nhập để thanh toán. Chuyển đến trang đăng nhập?')) {
                        window.location.href = '${pageContext.request.contextPath}/login?redirect=checkout';
                    }
                </c:otherwise>
            </c:choose>
        }

        // Notification function
        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.className = 'notification notification-' + type;
            notification.innerHTML = '<i class="fas fa-info-circle"></i>' + message;

            document.body.appendChild(notification);

            setTimeout(() => {
                notification.classList.add('show');
            }, 100);

            setTimeout(() => {
                notification.classList.remove('show');
                setTimeout(() => notification.remove(), 300);
            }, 3000);
        }

        // Add ripple effect to buttons
        document.querySelectorAll('.btn-checkout, .btn-continue').forEach(btn => {
            btn.addEventListener('click', function(e) {
                const ripple = document.createElement('span');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;

                ripple.style.width = ripple.style.height = size + 'px';
                ripple.style.left = x + 'px';
                ripple.style.top = y + 'px';
                ripple.classList.add('ripple');

                this.appendChild(ripple);

                setTimeout(() => {
                    ripple.remove();
                }, 400);
            });
        });
    </script>

    <style>
        .notification {
            position: fixed;
            top: 100px;
            right: 20px;
            background: var(--success);
            color: white;
            padding: 1rem 1.5rem;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            transform: translateX(400px);
            transition: transform 0.3s ease;
            z-index: 1001;
        }

        .notification.show {
            transform: translateX(0);
        }

        .notification.error {
            background: var(--danger);
        }
    </style>
</body>
</html>

