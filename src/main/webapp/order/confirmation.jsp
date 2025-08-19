<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận đơn hàng - GoMsu Store</title>
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

        .nav-link:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
        }

        .confirmation-container {
            max-width: 900px;
            margin: 120px auto 2rem auto;
            padding: 2rem;
        }

        .success-header {
            text-align: center;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            padding: 3rem 2rem;
            border-radius: var(--radius-xl);
            margin-bottom: 2rem;
            box-shadow: var(--shadow-lg);
            position: relative;
            overflow: hidden;
        }

        .success-icon {
            font-size: 5rem;
            margin-bottom: 1.5rem;
            color: var(--success);
            animation: successPulse 2s ease-in-out infinite;
        }

        .success-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .success-subtitle {
            color: var(--text-secondary);
            font-size: 1.1rem;
        }

        .order-details {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: var(--radius-xl);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
        }

        .order-number {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 1.5rem;
            border-radius: var(--radius-lg);
            text-align: center;
            font-weight: 700;
            font-size: 1.3rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
        }

        .detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .detail-section h4 {
            color: var(--primary);
            margin-bottom: 1rem;
            font-weight: 700;
            font-size: 1.1rem;
            border-bottom: 2px solid var(--glass-border);
            padding-bottom: 0.5rem;
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px dashed var(--glass-border);
        }

        .detail-item:last-child {
            border-bottom: none;
        }

        .detail-label {
            color: var(--text-secondary);
            font-weight: 500;
        }

        .detail-value {
            color: var(--text-primary);
            font-weight: 600;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 2rem;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 2rem;
            border-radius: var(--radius-lg);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 1rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-secondary {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            color: var(--text-primary);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-2px);
        }

        /* Info box */
        .info-box {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            border: 1px solid var(--glass-border);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            margin-top: 2rem;
        }

        .info-box h4 {
            color: var(--primary);
            margin-bottom: 1rem;
            font-weight: 700;
        }

        .info-box ul {
            color: var(--text-secondary);
            line-height: 1.8;
            padding-left: 1rem;
        }

        .info-box li {
            margin-bottom: 0.5rem;
        }

        /* Animations */
        @keyframes successPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .confirmation-container {
                padding: 1rem;
                margin-top: 100px;
            }

            .detail-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .success-title {
                font-size: 2rem;
            }

            .success-icon {
                font-size: 4rem;
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
                <li><a href="${pageContext.request.contextPath}/cart" class="nav-link">
                    <i class="fas fa-shopping-cart"></i> Giỏ Hàng
                </a></li>
            </ul>
        </div>
    </nav>

    <div class="confirmation-container">
        <!-- Success Header -->
        <div class="success-header">
            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <h1 class="success-title">Đặt hàng thành công!</h1>
            <p class="success-subtitle">Cảm ơn bạn đã tin tưởng và mua hàng tại GoMsu Store</p>
        </div>

        <!-- Order Details -->
        <div class="order-details">
            <div class="order-number">
                <i class="fas fa-receipt"></i> Mã đơn hàng: #${order.orderId}
            </div>

            <div class="detail-grid">
                <!-- Customer Information -->
                <div class="detail-section">
                    <h4><i class="fas fa-user"></i> Thông tin khách hàng</h4>
                    <div class="detail-item">
                        <div class="detail-label">Họ tên:</div>
                        <div class="detail-value">${order.customerName}</div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Email:</div>
                        <div class="detail-value">
                            <c:choose>
                                <c:when test="${not empty order.email}">
                                    ${order.email}
                                </c:when>
                                <c:otherwise>
                                    ${sessionScope.user.email}
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Số điện thoại:</div>
                        <div class="detail-value">${order.phoneNumber}</div>
                    </div>
                </div>

                <!-- Order Information -->
                <div class="detail-section">
                    <h4><i class="fas fa-box"></i> Thông tin đơn hàng</h4>
                    <div class="detail-item">
                        <div class="detail-label">Ngày đặt:</div>
                        <div class="detail-value">
                            <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                        </div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Tổng tiền:</div>
                        <div class="detail-value" style="color: var(--primary); font-weight: 700; font-size: 1.1rem;">
                            <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                        </div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Trạng thái:</div>
                        <div class="detail-value">
                            <span style="background: rgba(237, 137, 54, 0.2); color: var(--warning); padding: 0.25rem 0.75rem; border-radius: var(--radius); font-size: 0.9rem;">
                                ${order.status}
                            </span>
                        </div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Thanh toán:</div>
                        <div class="detail-value">
                            <c:choose>
                                <c:when test="${order.paymentMethod == 'on_delivery'}">
                                    Thanh toán khi nhận hàng
                                </c:when>
                                <c:when test="${order.paymentMethod == 'online'}">
                                    Chuyển khoản ngân hàng
                                </c:when>
                                <c:otherwise>
                                    Thanh toán khi nhận hàng
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Shipping Information -->
            <div class="detail-section">
                <h4><i class="fas fa-truck"></i> Thông tin giao hàng</h4>
                <div class="detail-item">
                    <div class="detail-label">Địa chỉ:</div>
                    <div class="detail-value">${order.shippingAddress}</div>
                </div>
                <c:if test="${not empty order.note}">
                    <div class="detail-item">
                        <div class="detail-label">Ghi chú:</div>
                        <div class="detail-value">${order.note}</div>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-primary">
                <i class="fas fa-list"></i> Đơn hàng của tôi
            </a>
            <a href="${pageContext.request.contextPath}/shop" class="btn btn-secondary">
                <i class="fas fa-shopping-bag"></i> Tiếp tục mua sắm
            </a>
            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">
                <i class="fas fa-home"></i> Về trang chủ
            </a>
        </div>

        <!-- Info Box -->
        <div class="info-box">
            <h4><i class="fas fa-info-circle"></i> Thông tin quan trọng</h4>
            <ul>
                <li>✅ Đơn hàng của bạn đã được tiếp nhận và đang được xử lý</li>
                <li>📧 Chúng tôi sẽ gửi email xác nhận và cập nhật trạng thái đơn hàng</li>
                <li>🚚 Thời gian giao hàng dự kiến: 2-3 ngày làm việc</li>
                <li>📞 Liên hệ hotline: 1900-xxxx nếu có thắc mắc</li>
            </ul>
        </div>
    </div>
</body>
</html>
