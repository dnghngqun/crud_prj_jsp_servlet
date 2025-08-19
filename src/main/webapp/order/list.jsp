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
                    <a href="${pageContext.request.contextPath}/orders" class="nav-link active">
                        <i class="fas fa-box"></i> Đơn Hàng
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/cart" class="nav-link">
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
            <!-- Orders Header -->
            <div class="orders-header">
                <h1 class="orders-title">
                    <i class="fas fa-box"></i>
                    Đơn Hàng Của Tôi
                </h1>
                <p class="orders-subtitle">
                    <c:choose>
                        <c:when test="${fn:length(orders) > 0}">
                            Bạn có ${fn:length(orders)} đơn hàng
                        </c:when>
                        <c:otherwise>
                            Bạn chưa có đơn hàng nào
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>

            <!-- Order Status Filter -->
            <div class="order-filters">
                <div class="filter-tabs">
                    <button class="filter-tab ${empty param.status ? 'active' : ''}" data-status="">
                        <i class="fas fa-list"></i>
                        Tất cả
                    </button>
                    <button class="filter-tab ${param.status == 'pending' ? 'active' : ''}" data-status="pending">
                        <i class="fas fa-clock"></i>
                        Chờ xử lý
                    </button>
                    <button class="filter-tab ${param.status == 'processing' ? 'active' : ''}" data-status="processing">
                        <i class="fas fa-cog"></i>
                        Đang xử lý
                    </button>
                    <button class="filter-tab ${param.status == 'shipped' ? 'active' : ''}" data-status="shipped">
                        <i class="fas fa-truck"></i>
                        Đang giao
                    </button>
                    <button class="filter-tab ${param.status == 'delivered' ? 'active' : ''}" data-status="delivered">
                        <i class="fas fa-check-circle"></i>
                        Đã giao
                    </button>
                    <button class="filter-tab ${param.status == 'cancelled' ? 'active' : ''}" data-status="cancelled">
                        <i class="fas fa-times-circle"></i>
                        Đã hủy
                    </button>
                </div>
            </div>

            <!-- Orders List -->
            <c:choose>
                <c:when test="${fn:length(orders) > 0}">
                    <div class="orders-list">
                        <c:forEach var="order" items="${orders}">
                            <div class="order-card" data-order-id="${order.orderId}">
                                <div class="order-header">
                                    <div class="order-info">
                                        <div class="order-id">
                                            <i class="fas fa-receipt"></i>
                                            Đơn hàng #${order.orderId}
                                        </div>
                                        <div class="order-date">
                                            <i class="fas fa-calendar"></i>
                                            <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                        </div>
                                    </div>
                                    <div class="order-status">
                                        <span class="status-badge status-${order.status}">
                                            <c:choose>
                                                <c:when test="${order.status == 'pending'}">
                                                    <i class="fas fa-clock"></i> Chờ xử lý
                                                </c:when>
                                                <c:when test="${order.status == 'processing'}">
                                                    <i class="fas fa-cog"></i> Đang xử lý
                                                </c:when>
                                                <c:when test="${order.status == 'shipped'}">
                                                    <i class="fas fa-truck"></i> Đang giao
                                                </c:when>
                                                <c:when test="${order.status == 'delivered'}">
                                                    <i class="fas fa-check-circle"></i> Đã giao
                                                </c:when>
                                                <c:when test="${order.status == 'cancelled'}">
                                                    <i class="fas fa-times-circle"></i> Đã hủy
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-question-circle"></i> ${order.status}
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>

                                <div class="order-content">
                                    <div class="order-items">
                                        <c:forEach var="item" items="${order.orderItems}" varStatus="status">
                                            <c:if test="${status.index < 3}">
                                                <div class="order-item">
                                                    <div class="item-image">
                                                        <img src="${not empty item.product.imageUrl ? item.product.imageUrl : '/images/no-image.jpg'}"
                                                             alt="${item.product.name}" loading="lazy">
                                                    </div>
                                                    <div class="item-details">
                                                        <h4 class="item-name">${item.product.name}</h4>
                                                        <p class="item-category">${item.product.categoryName}</p>
                                                        <div class="item-quantity">Số lượng: ${item.quantity}</div>
                                                        <div class="item-price">
                                                            <fmt:formatNumber value="${item.price}" type="currency" currencyCode="VND"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>

                                        <c:if test="${fn:length(order.orderItems) > 3}">
                                            <div class="more-items">
                                                <i class="fas fa-ellipsis-h"></i>
                                                và ${fn:length(order.orderItems) - 3} sản phẩm khác
                                            </div>
                                        </c:if>
                                    </div>

                                    <div class="order-summary">
                                        <div class="delivery-info">
                                            <div class="delivery-address">
                                                <i class="fas fa-map-marker-alt"></i>
                                                <div>
                                                    <strong>${order.customerName}</strong><br>
                                                    ${order.phoneNumber}<br>
                                                    ${order.shippingAddress}
                                                </div>
                                            </div>
                                        </div>

                                        <div class="order-total">
                                            <div class="total-label">Tổng tiền:</div>
                                            <div class="total-amount">
                                                <fmt:formatNumber value="${order.totalPrice}" type="currency" currencyCode="VND"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="order-actions">
                                    <a href="${pageContext.request.contextPath}/orders/detail?id=${order.orderId}"
                                       class="btn btn-secondary">
                                        <i class="fas fa-eye"></i>
                                        Xem chi tiết
                                    </a>

                                    <c:if test="${order.status == 'pending'}">
                                        <button class="btn btn-danger" onclick="cancelOrder(${order.orderId})">
                                            <i class="fas fa-times"></i>
                                            Hủy đơn
                                        </button>
                                    </c:if>

                                    <c:if test="${order.status == 'delivered'}">
                                        <a href="${pageContext.request.contextPath}/orders/reorder?id=${order.orderId}"
                                           class="btn btn-primary">
                                            <i class="fas fa-redo"></i>
                                            Mua lại
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <c:if test="${currentPage > 1}">
                                <a href="?page=${currentPage - 1}${not empty param.status ? '&status=' : ''}${param.status}"
                                   class="pagination-btn">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <a href="?page=${i}${not empty param.status ? '&status=' : ''}${param.status}"
                                   class="pagination-btn ${currentPage == i ? 'active' : ''}">${i}</a>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <a href="?page=${currentPage + 1}${not empty param.status ? '&status=' : ''}${param.status}"
                                   class="pagination-btn">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </c:if>
                        </div>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div class="empty-orders">
                        <div class="empty-orders-icon">
                            <i class="fas fa-box-open"></i>
                        </div>
                        <h2 class="empty-orders-title">Chưa có đơn hàng nào</h2>
                        <p class="empty-orders-message">
                            <c:choose>
                                <c:when test="${sessionScope.user != null}">
                                    Hãy khám phá các sản phẩm tuyệt vời và đặt hàng ngay!
                                </c:when>
                                <c:otherwise>
                                    Hãy đăng nhập để xem đơn hàng của bạn
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <div class="empty-orders-actions">
                            <c:choose>
                                <c:when test="${sessionScope.user != null}">
                                    <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">
                                        <i class="fas fa-shopping-bag"></i>
                                        Bắt Đầu Mua Sắm
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">
                                        <i class="fas fa-sign-in-alt"></i>
                                        Đăng Nhập
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
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

        // Filter tabs functionality
        document.querySelectorAll('.filter-tab').forEach(tab => {
            tab.addEventListener('click', function() {
                const status = this.getAttribute('data-status');
                const url = new URL(window.location);

                if (status) {
                    url.searchParams.set('status', status);
                } else {
                    url.searchParams.delete('status');
                }
                url.searchParams.delete('page'); // Reset to first page

                window.location.href = url.toString();
            });
        });

        // Cancel order function
        function cancelOrder(orderId) {
            if (!confirm('Bạn có chắc muốn hủy đơn hàng này?')) {
                return;
            }

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
                    showNotification('Đơn hàng đã được hủy thành công!', 'success');
                    setTimeout(() => location.reload(), 1500);
                } else {
                    showNotification(data.message || 'Có lỗi xảy ra!', 'error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showNotification('Có lỗi xảy ra khi hủy đơn hàng!', 'error');
            });
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
    </script>

    <style>
        /* Orders Page Styles */
        .orders-header {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 2px solid var(--glass-border);
            border-radius: 32px;
            padding: 3rem 2rem;
            margin-bottom: 3rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .orders-title {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, var(--primary), var(--secondary), var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .orders-subtitle {
            color: var(--text-secondary);
            font-size: 1.2rem;
            line-height: 1.6;
        }

        /* Filter Tabs */
        .order-filters {
            margin-bottom: 2rem;
        }

        .filter-tabs {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
            justify-content: center;
        }

        .filter-tab {
            padding: 0.75rem 1.5rem;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 2px solid var(--glass-border);
            border-radius: 12px;
            color: var(--text-secondary);
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.9rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .filter-tab:hover {
            background: rgba(255, 255, 255, 0.15);
            border-color: var(--primary);
            transform: translateY(-2px);
        }

        .filter-tab.active {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            border-color: var(--primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }

        /* Order Cards */
        .orders-list {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        .order-card {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border: 2px solid var(--glass-border);
            border-radius: 24px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            border-color: var(--primary);
        }

        .order-header {
            padding: 1.5rem 2rem;
            border-bottom: 1px solid var(--glass-border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(255, 255, 255, 0.05);
        }

        .order-info {
            display: flex;
            gap: 2rem;
            align-items: center;
        }

        .order-id {
            font-weight: 700;
            font-size: 1.1rem;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .order-date {
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Status Badges */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background: linear-gradient(135deg, #ffc107, #ffb300);
            color: #000;
            box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);
        }

        .status-processing {
            background: linear-gradient(135deg, #17a2b8, #138496);
            color: white;
            box-shadow: 0 4px 15px rgba(23, 162, 184, 0.3);
        }

        .status-shipped {
            background: linear-gradient(135deg, #6f42c1, #5a32a3);
            color: white;
            box-shadow: 0 4px 15px rgba(111, 66, 193, 0.3);
        }

        .status-delivered {
            background: linear-gradient(135deg, #28a745, #218838);
            color: white;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }

        .status-cancelled {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
        }

        /* Order Content */
        .order-content {
            padding: 2rem;
            display: grid;
            grid-template-columns: 1fr 300px;
            gap: 2rem;
        }

        .order-items {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .order-item {
            display: flex;
            gap: 1rem;
            padding: 1rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            border: 1px solid var(--glass-border);
        }

        .item-image {
            width: 80px;
            height: 80px;
            border-radius: 8px;
            overflow: hidden;
            flex-shrink: 0;
        }

        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .item-details {
            flex: 1;
        }

        .item-name {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }

        .item-category {
            color: var(--text-muted);
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .item-quantity {
            color: var(--text-secondary);
            font-size: 0.9rem;
            margin-bottom: 0.25rem;
        }

        .item-price {
            font-weight: 700;
            color: var(--primary);
            font-size: 1.1rem;
        }

        .more-items {
            text-align: center;
            padding: 1rem;
            color: var(--text-muted);
            font-style: italic;
            border: 2px dashed var(--glass-border);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        /* Order Summary */
        .order-summary {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .delivery-info {
            padding: 1.5rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            border: 1px solid var(--glass-border);
        }

        .delivery-address {
            display: flex;
            gap: 1rem;
            align-items: flex-start;
        }

        .delivery-address i {
            color: var(--primary);
            margin-top: 0.25rem;
            font-size: 1.1rem;
        }

        .order-total {
            padding: 1.5rem;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            border-radius: 16px;
            text-align: center;
            color: white;
        }

        .total-label {
            font-size: 1rem;
            margin-bottom: 0.5rem;
            opacity: 0.9;
        }

        .total-amount {
            font-size: 1.75rem;
            font-weight: 800;
        }

        /* Order Actions */
        .order-actions {
            padding: 1.5rem 2rem;
            border-top: 1px solid var(--glass-border);
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            background: rgba(255, 255, 255, 0.05);
        }

        /* Empty State */
        .empty-orders {
            text-align: center;
            padding: 5rem 3rem;
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border-radius: 32px;
            border: 2px solid var(--glass-border);
        }

        .empty-orders-icon {
            font-size: 5rem;
            color: var(--text-muted);
            margin-bottom: 2rem;
            opacity: 0.7;
        }

        .empty-orders-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: var(--text-primary);
        }

        .empty-orders-message {
            color: var(--text-secondary);
            margin-bottom: 3rem;
            font-size: 1.1rem;
            line-height: 1.5;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .order-content {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .order-header {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }

            .order-info {
                flex-direction: column;
                gap: 0.5rem;
            }

            .order-actions {
                flex-direction: column;
            }

            .filter-tabs {
                justify-content: flex-start;
                overflow-x: auto;
                padding-bottom: 0.5rem;
            }

            .orders-title {
                font-size: 2rem;
            }

            .orders-header {
                padding: 2rem 1.5rem;
            }
        }

        /* Notification styles */
        .notification {
            position: fixed;
            top: 100px;
            right: 20px;
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border: 1px solid var(--glass-border);
            border-radius: 16px;
            padding: 1.25rem 1.75rem;
            color: var(--text-primary);
            transform: translateX(400px);
            transition: all 0.4s ease;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
            z-index: 10000;
        }

        .notification.show {
            transform: translateX(0);
        }

        .notification-success {
            border-left: 4px solid var(--success);
        }

        .notification-error {
            border-left: 4px solid var(--danger);
        }
    </style>
</body>
</html>
