<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn Hàng Của Tôi - GoMsu Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #667eea;
            --primary-dark: #5a67d8;
            --primary-light: #7c89f0;
            --secondary: #f093fb;
            --accent: #4ecdc4;
            --success: #48bb78;
            --warning: #ed8936;
            --danger: #f56565;
            --info: #3182ce;

            --bg-primary: #0a0e27;
            --bg-secondary: #111827;
            --bg-card: rgba(255, 255, 255, 0.05);
            --bg-glass: rgba(255, 255, 255, 0.08);
            --bg-hover: rgba(255, 255, 255, 0.12);

            --text-primary: #ffffff;
            --text-secondary: #e2e8f0;
            --text-muted: #94a3b8;
            --text-light: #cbd5e1;

            --border-color: rgba(255, 255, 255, 0.15);
            --border-light: rgba(255, 255, 255, 0.1);

            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.3);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.4);
            --shadow-lg: 0 10px 40px rgba(0, 0, 0, 0.5);
            --shadow-xl: 0 20px 60px rgba(0, 0, 0, 0.6);

            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-lg: 16px;
            --radius-xl: 24px;
            --radius-2xl: 32px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, var(--bg-primary) 0%, var(--bg-secondary) 100%);
            min-height: 100vh;
            color: var(--text-primary);
            line-height: 1.6;
        }

        /* Animated background */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background:
                radial-gradient(circle at 20% 50%, rgba(102, 126, 234, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(240, 147, 251, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 40% 80%, rgba(78, 205, 196, 0.1) 0%, transparent 50%);
            pointer-events: none;
            z-index: -1;
        }

        .navbar {
            background: rgba(17, 24, 39, 0.95);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border-color);
            padding: 1rem 0;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .navbar-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand {
            font-size: 1.75rem;
            font-weight: 800;
            color: var(--primary);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            transition: all 0.3s ease;
        }

        .navbar-brand:hover {
            color: var(--primary-light);
            transform: translateY(-1px);
        }

        .navbar-nav {
            display: flex;
            list-style: none;
            gap: 2rem;
        }

        .nav-link {
            color: var(--text-secondary);
            text-decoration: none;
            font-weight: 500;
            padding: 0.75rem 1.25rem;
            border-radius: var(--radius-lg);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            position: relative;
            overflow: hidden;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transition: left 0.5s ease;
        }

        .nav-link:hover::before {
            left: 100%;
        }

        .nav-link:hover, .nav-link.active {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .main-content {
            margin-top: 100px;
            padding: 3rem 2rem;
            min-height: calc(100vh - 100px);
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .page-header {
            text-align: center;
            margin-bottom: 4rem;
            position: relative;
        }

        .page-title {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 50%, var(--accent) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            position: relative;
            line-height: 1.2;
        }

        .page-subtitle {
            font-size: 1.25rem;
            color: var(--text-light);
            font-weight: 400;
            max-width: 600px;
            margin: 0 auto;
        }

        .orders-grid {
            display: grid;
            gap: 2rem;
        }

        .order-card {
            background: var(--bg-glass);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-2xl);
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
        }

        .order-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--secondary), var(--accent));
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .order-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-xl);
            border-color: var(--primary);
        }

        .order-card:hover::before {
            opacity: 1;
        }

        .order-header {
            padding: 2rem;
            background: linear-gradient(135deg, var(--bg-card) 0%, rgba(255, 255, 255, 0.02) 100%);
            border-bottom: 1px solid var(--border-light);
        }

        .order-header-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .order-id {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .order-id i {
            padding: 0.5rem;
            background: rgba(102, 126, 234, 0.2);
            border-radius: var(--radius-md);
        }

        .order-status {
            padding: 0.75rem 1.5rem;
            border-radius: var(--radius-xl);
            font-weight: 600;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            position: relative;
            overflow: hidden;
        }

        .order-status::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .order-status:hover::before {
            left: 100%;
        }

        .status-pending {
            background: linear-gradient(135deg, rgba(237, 137, 54, 0.2), rgba(237, 137, 54, 0.1));
            color: var(--warning);
            border: 1px solid rgba(237, 137, 54, 0.3);
        }

        .status-confirmed {
            background: linear-gradient(135deg, rgba(72, 187, 120, 0.2), rgba(72, 187, 120, 0.1));
            color: var(--success);
            border: 1px solid rgba(72, 187, 120, 0.3);
        }

        .status-cancelled {
            background: linear-gradient(135deg, rgba(245, 101, 101, 0.2), rgba(245, 101, 101, 0.1));
            color: var(--danger);
            border: 1px solid rgba(245, 101, 101, 0.3);
        }

        .order-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .order-info-card {
            background: rgba(255, 255, 255, 0.03);
            padding: 1.5rem;
            border-radius: var(--radius-lg);
            border: 1px solid var(--border-light);
            transition: all 0.3s ease;
        }

        .order-info-card:hover {
            background: rgba(255, 255, 255, 0.06);
            transform: translateY(-2px);
        }

        .info-label {
            color: var(--text-muted);
            font-size: 0.875rem;
            font-weight: 500;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            color: var(--text-primary);
            font-weight: 600;
            font-size: 1.1rem;
        }

        .info-total {
            color: var(--primary);
            font-size: 1.5rem;
            font-weight: 800;
        }

        .products-section {
            padding: 0;
        }

        .products-header {
            padding: 2rem;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(240, 147, 251, 0.1));
            border-bottom: 1px solid var(--border-light);
            display: flex;
            align-items: center;
            gap: 1rem;
            color: var(--text-primary);
            font-weight: 600;
            font-size: 1.1rem;
        }

        .products-header i {
            padding: 0.75rem;
            background: var(--primary);
            color: white;
            border-radius: var(--radius-md);
            font-size: 1.25rem;
        }

        .products-list {
            padding: 1rem;
        }

        .product-item {
            display: grid;
            grid-template-columns: 100px 1fr auto auto auto;
            gap: 1.5rem;
            padding: 1.5rem;
            border-radius: var(--radius-lg);
            margin-bottom: 1rem;
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid var(--border-light);
            align-items: center;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .product-item:hover {
            background: var(--bg-hover);
            transform: translateX(8px);
            border-color: var(--primary);
        }

        .product-item:last-child {
            margin-bottom: 0;
        }

        .product-image {
            width: 100px;
            height: 100px;
            border-radius: var(--radius-lg);
            overflow: hidden;
            position: relative;
            box-shadow: var(--shadow-md);
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .product-item:hover .product-image img {
            transform: scale(1.05);
        }

        .product-info {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .product-name {
            font-weight: 700;
            color: var(--text-primary);
            font-size: 1.2rem;
            line-height: 1.3;
        }

        .product-category {
            color: var(--text-muted);
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 500;
        }

        .product-category i {
            color: var(--accent);
        }

        .product-quantity {
            text-align: center;
            padding: 0.75rem 1rem;
            background: linear-gradient(135deg, rgba(78, 205, 196, 0.2), rgba(78, 205, 196, 0.1));
            color: var(--accent);
            border-radius: var(--radius-lg);
            font-weight: 700;
            font-size: 1rem;
            border: 1px solid rgba(78, 205, 196, 0.3);
            min-width: 80px;
        }

        .product-price {
            text-align: center;
            color: var(--text-secondary);
            font-weight: 600;
            font-size: 1.1rem;
        }

        .product-total {
            text-align: center;
            color: var(--primary);
            font-weight: 800;
            font-size: 1.25rem;
        }

        .order-footer {
            padding: 2rem;
            background: linear-gradient(135deg, var(--bg-card), rgba(255, 255, 255, 0.02));
            border-top: 1px solid var(--border-light);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .order-total-display {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .order-actions {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.875rem 2rem;
            border-radius: var(--radius-lg);
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.6s ease, height 0.6s ease;
        }

        .btn:hover::before {
            width: 300px;
            height: 300px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            box-shadow: var(--shadow-md);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-lg);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--border-color);
            color: var(--text-primary);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: var(--primary);
            transform: translateY(-2px);
        }

        .empty-state {
            text-align: center;
            padding: 6rem 2rem;
            background: var(--bg-glass);
            border-radius: var(--radius-2xl);
            border: 1px solid var(--border-color);
            backdrop-filter: blur(20px);
        }

        .empty-icon {
            font-size: 5rem;
            color: var(--text-muted);
            margin-bottom: 2rem;
            opacity: 0.6;
        }

        .empty-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: var(--text-primary);
        }

        .empty-message {
            color: var(--text-light);
            margin-bottom: 3rem;
            font-size: 1.1rem;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .order-info-grid {
                grid-template-columns: 1fr;
            }

            .product-item {
                grid-template-columns: 80px 1fr;
                gap: 1rem;
            }

            .product-quantity, .product-price, .product-total {
                grid-column: 1 / -1;
                display: flex;
                justify-content: space-between;
                margin-top: 1rem;
                padding: 1rem;
                background: rgba(255, 255, 255, 0.05);
                border-radius: var(--radius-md);
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 2rem 1rem;
            }

            .page-title {
                font-size: 2.5rem;
            }

            .navbar-nav {
                display: none;
            }

            .order-header-top {
                flex-direction: column;
                align-items: stretch;
            }

            .order-footer {
                flex-direction: column;
                text-align: center;
            }

            .product-image {
                width: 80px;
                height: 80px;
            }
        }

        /* Loading Animation */
        @keyframes shimmer {
            0% { background-position: -200px 0; }
            100% { background-position: calc(200px + 100%) 0; }
        }

        .loading {
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            background-size: 200px 100%;
            animation: shimmer 1.5s infinite;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="navbar-container">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">
                <i class="fas fa-gem"></i>
                GoMsu Store
            </a>
            <ul class="navbar-nav">
                <li><a href="${pageContext.request.contextPath}/" class="nav-link">
                    <i class="fas fa-home"></i> Trang Chủ
                </a></li>
                <li><a href="${pageContext.request.contextPath}/shop" class="nav-link">
                    <i class="fas fa-shopping-bag"></i> Cửa Hàng
                </a></li>
                <li><a href="${pageContext.request.contextPath}/orders" class="nav-link active">
                    <i class="fas fa-receipt"></i> Đơn Hàng
                </a></li>
                <li><a href="${pageContext.request.contextPath}/cart" class="nav-link">
                    <i class="fas fa-shopping-cart"></i> Giỏ Hàng
                </a></li>
                <c:if test="${not empty sessionScope.user}">
                    <li><a href="${pageContext.request.contextPath}/logout" class="nav-link">
                        <i class="fas fa-sign-out-alt"></i> Đăng xuất
                    </a></li>
                </c:if>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-shopping-bag"></i>
                    Đơn Hàng Của Tôi
                </h1>
                <p class="page-subtitle">
                    <c:choose>
                        <c:when test="${fn:length(orders) > 0}">
                            Quản lý và theo dõi ${fn:length(orders)} đơn hàng của bạn
                        </c:when>
                        <c:otherwise>
                            Theo dõi lịch sử mua hàng và trạng thái đơn hàng
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>

            <!-- Orders List -->
            <c:choose>
                <c:when test="${not empty orders}">
                    <div class="orders-grid">
                        <c:forEach var="order" items="${orders}">
                            <div class="order-card">
                                <!-- Order Header -->
                                <div class="order-header">
                                    <div class="order-header-top">
                                        <div class="order-id">
                                            <i class="fas fa-receipt"></i>
                                            Đơn hàng #${order.orderId}
                                        </div>
                                        <div class="order-status ${order.status == 'pending' ? 'status-pending' : order.status == 'confirmed' ? 'status-confirmed' : 'status-cancelled'}">
                                            <c:choose>
                                                <c:when test="${order.status == 'pending'}">
                                                    <i class="fas fa-clock"></i> Đang xử lý
                                                </c:when>
                                                <c:when test="${order.status == 'confirmed'}">
                                                    <i class="fas fa-check-circle"></i> Đã xác nhận
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-times-circle"></i> Đã hủy
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>

                                    <div class="order-info-grid">
                                        <div class="order-info-card">
                                            <div class="info-label">
                                                <i class="fas fa-calendar-alt"></i>
                                                Ngày đặt hàng
                                            </div>
                                            <div class="info-value">
                                                <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy"/>
                                                <br>
                                                <small style="color: var(--text-muted);">
                                                    <fmt:formatDate value="${order.createdAt}" pattern="HH:mm"/>
                                                </small>
                                            </div>
                                        </div>

                                        <div class="order-info-card">
                                            <div class="info-label">
                                                <i class="fas fa-map-marker-alt"></i>
                                                Địa chỉ giao hàng
                                            </div>
                                            <div class="info-value">
                                                ${fn:length(order.shippingAddress) > 60 ?
                                                  fn:substring(order.shippingAddress, 0, 60).concat('...') :
                                                  order.shippingAddress}
                                            </div>
                                        </div>

                                        <div class="order-info-card">
                                            <div class="info-label">
                                                <i class="fas fa-money-bill-wave"></i>
                                                Tổng giá trị
                                            </div>
                                            <div class="info-value info-total">
                                                <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Products Section -->
                                <div class="products-section">
                                    <div class="products-header">
                                        <i class="fas fa-box-open"></i>
                                        <span>Sản phẩm đã mua</span>
                                        <span style="margin-left: auto; background: rgba(255,255,255,0.1); padding: 0.25rem 0.75rem; border-radius: 20px; font-size: 0.85rem;">
                                            ${fn:length(order.orderItems)} sản phẩm
                                        </span>
                                    </div>

                                    <div class="products-list">
                                        <c:choose>
                                            <c:when test="${not empty order.orderItems}">
                                                <c:forEach var="item" items="${order.orderItems}">
                                                    <div class="product-item">
                                                        <div class="product-image">
                                                            <img src="${item.product.imageUrl}"
                                                                 alt="${item.product.name}"
                                                                 onerror="this.src='${pageContext.request.contextPath}/images/no-image.png'">
                                                        </div>

                                                        <div class="product-info">
                                                            <div class="product-name">${item.product.name}</div>
                                                            <c:if test="${not empty item.product.categoryName}">
                                                                <div class="product-category">
                                                                    <i class="fas fa-tag"></i>
                                                                    ${item.product.categoryName}
                                                                </div>
                                                            </c:if>
                                                        </div>

                                                        <div class="product-quantity">
                                                            <i class="fas fa-times"></i> ${item.quantity}
                                                        </div>

                                                        <div class="product-price">
                                                            <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                        </div>

                                                        <div class="product-total">
                                                            <fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div style="padding: 3rem; text-align: center; color: var(--text-muted);">
                                                    <i class="fas fa-inbox" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.5;"></i>
                                                    <p>Không có sản phẩm nào trong đơn hàng này</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <!-- Order Footer -->
                                <div class="order-footer">
                                    <div class="order-total-display">
                                        <i class="fas fa-calculator"></i>
                                        Tổng cộng: <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                    </div>

                                    <div class="order-actions">
                                        <a href="${pageContext.request.contextPath}/order/confirmation?id=${order.orderId}" class="btn btn-primary">
                                            <i class="fas fa-eye"></i>
                                            Xem chi tiết
                                        </a>
                                        <c:if test="${order.status == 'pending'}">
                                            <button class="btn btn-secondary" onclick="cancelOrder(${order.orderId})">
                                                <i class="fas fa-ban"></i>
                                                Hủy đơn hàng
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                        <h2 class="empty-title">Chưa có đơn hàng nào</h2>
                        <p class="empty-message">
                            Bạn chưa thực hiện đơn hàng nào. Hãy khám phá cửa hàng và tìm những sản phẩm yêu thích của bạn!
                        </p>
                        <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">
                            <i class="fas fa-shopping-bag"></i>
                            Khám phá cửa hàng
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <script>
        function cancelOrder(orderId) {
            if (confirm('Bạn có chắc chắn muốn hủy đơn hàng này không?')) {
                // Show loading state
                const btn = event.target;
                const originalText = btn.innerHTML;
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang hủy...';
                btn.disabled = true;

                fetch('${pageContext.request.contextPath}/orders/cancel', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'orderId=' + orderId
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Show success message
                        btn.innerHTML = '<i class="fas fa-check"></i> Đã hủy';
                        btn.style.background = 'var(--success)';

                        // Reload page after short delay
                        setTimeout(() => {
                            location.reload();
                        }, 1500);
                    } else {
                        alert('Có lỗi xảy ra khi hủy đơn hàng. Vui lòng thử lại.');
                        btn.innerHTML = originalText;
                        btn.disabled = false;
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi hủy đơn hàng. Vui lòng thử lại.');
                    btn.innerHTML = originalText;
                    btn.disabled = false;
                });
            }
        }

        // Add smooth scroll behavior
        document.documentElement.style.scrollBehavior = 'smooth';

        // Add loading animation to page
        window.addEventListener('load', function() {
            document.body.style.opacity = '0';
            setTimeout(() => {
                document.body.style.transition = 'opacity 0.5s ease';
                document.body.style.opacity = '1';
            }, 100);
        });
    </script>
</body>
</html>
