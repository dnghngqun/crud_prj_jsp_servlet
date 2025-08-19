<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng - GoMsu Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* Animated background */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><radialGradient id="g"><stop offset="20%" stop-color="%23ffffff" stop-opacity="0.1"/><stop offset="50%" stop-color="%23ffffff" stop-opacity="0.05"/><stop offset="100%" stop-color="%23ffffff" stop-opacity="0"/></radialGradient></defs><circle cx="20" cy="20" r="20" fill="url(%23g)"><animateTransform attributeName="transform" type="translate" values="0,0;80,80;0,0" dur="8s" repeatCount="indefinite"/></circle><circle cx="80" cy="20" r="15" fill="url(%23g)"><animateTransform attributeName="transform" type="translate" values="0,0;-80,80;0,0" dur="10s" repeatCount="indefinite"/></circle></svg>');
            animation: backgroundMove 20s ease-in-out infinite;
            pointer-events: none;
            z-index: -1;
        }

        @keyframes backgroundMove {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            position: relative;
            z-index: 1;
        }

        /* Glass morphism header */
        .header {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 25px;
            padding: 3rem 2rem;
            text-align: center;
            margin-bottom: 2rem;
            box-shadow: 0 25px 45px rgba(0, 0, 0, 0.1);
            animation: slideInDown 0.8s ease-out;
            position: relative;
            overflow: hidden;
        }
        .header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            animation: shimmer 3s linear infinite;
            pointer-events: none;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-100px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header h1 {
            font-size: 3rem;
            font-weight: 800;
            color: white;
            margin-bottom: 0.5rem;
            text-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            animation: textGlow 2s ease-in-out infinite alternate;
        }

        @keyframes textGlow {
            from { text-shadow: 0 4px 8px rgba(0, 0, 0, 0.3), 0 0 20px rgba(255, 255, 255, 0.5); }
            to { text-shadow: 0 4px 8px rgba(0, 0, 0, 0.3), 0 0 30px rgba(255, 255, 255, 0.8); }
        }

        .header p {
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 300;
        }

        /* Glass morphism cards */
        .detail-card, .products-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            animation: slideInUp 0.8s ease-out;
            animation-delay: 0.2s;
            animation-fill-mode: both;
            position: relative;
            overflow: hidden;
        }

        .products-card {
            animation-delay: 0.4s;
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.2rem 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
        }

        .detail-item:hover {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            padding-left: 1rem;
            padding-right: 1rem;
        }

        .detail-item:last-child {
            border-bottom: none;
        }

        .detail-label {
            font-weight: 600;
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .detail-value {
            font-weight: 500;
            color: white;
            font-size: 1.1rem;
            text-align: right;
        }

        /* Status badge with animation */
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            animation: pulse 2s infinite;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .status-pending {
            background: linear-gradient(45deg, #ffa726, #ff9800);
            color: white;
            box-shadow: 0 4px 15px rgba(255, 152, 0, 0.4);
        }

        .status-delivered {
            background: linear-gradient(45deg, #42a5f5, #2196f3);
            color: white;
            box-shadow: 0 4px 15px rgba(33, 150, 243, 0.4);
        }

        .status-success, .status-completed {
            background: linear-gradient(45deg, #66bb6a, #4caf50);
            color: white;
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.4);
        }

        .status-cancel, .status-error {
            background: linear-gradient(45deg, #ef5350, #f44336);
            color: white;
            box-shadow: 0 4px 15px rgba(244, 67, 54, 0.4);
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        /* Beautiful table */
        .table-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            font-weight: 600;
            padding: 1.5rem 1rem;
            text-align: left;
            font-size: 1.1rem;
        }

        .table td {
            padding: 1.2rem 1rem;
            color: rgba(255, 255, 255, 0.9);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
        }

        .table tr:hover td {
            background: rgba(255, 255, 255, 0.05);
            color: white;
        }

        /* Floating action buttons */
        .actions {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            flex-wrap: wrap;
            justify-content: center;
            animation: slideInUp 0.8s ease-out;
            animation-delay: 0.6s;
            animation-fill-mode: both;
        }

        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            min-width: 180px;
            justify-content: center;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.3);
        }

        .btn-primary {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
        }

        .btn-warning {
            background: linear-gradient(45deg, #ffa726, #ff9800);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(45deg, #ef5350, #f44336);
            color: white;
        }

        .btn-success {
            background: linear-gradient(45deg, #66bb6a, #4caf50);
            color: white;
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        /* Section headers */
        .section-header {
            color: white;
            font-size: 2rem;
            font-weight: 700;
            margin: 3rem 0 1.5rem 0;
            text-align: center;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
            animation: fadeIn 1s ease-out;
            animation-delay: 0.3s;
            animation-fill-mode: both;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .header h1 {
                font-size: 2rem;
            }

            .detail-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }

            .detail-value {
                text-align: left;
            }

            .actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            .table {
                font-size: 0.9rem;
            }

            .table th,
            .table td {
                padding: 1rem 0.5rem;
            }
        }

        /* Loading animation for page entrance */
        .container > * {
            opacity: 0;
            animation: slideInFromLeft 0.8s ease-out forwards;
        }

        .container > *:nth-child(1) { animation-delay: 0.1s; }
        .container > *:nth-child(2) { animation-delay: 0.2s; }
        .container > *:nth-child(3) { animation-delay: 0.3s; }
        .container > *:nth-child(4) { animation-delay: 0.4s; }

        @keyframes slideInFromLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📋 Chi tiết đơn hàng</h1>
            <p>Thông tin chi tiết đơn hàng #${order.orderId}</p>
        </div>

        <div class="detail-card">
            <div class="detail-item">
                <div class="detail-label">🆔 Mã đơn hàng:</div>
                <div class="detail-value">#${order.orderId}</div>
            </div>

            <div class="detail-item">
                <div class="detail-label">👤 Khách hàng:</div>
                <div class="detail-value">${order.customerName}</div>
            </div>

            <div class="detail-item">
                <div class="detail-label">📱 Số điện thoại:</div>
                <div class="detail-value">${order.phoneNumber}</div>
            </div>

            <div class="detail-item">
                <div class="detail-label">🏠 Địa chỉ giao hàng:</div>
                <div class="detail-value">${order.shippingAddress}</div>
            </div>

            <div class="detail-item">
                <div class="detail-label">💰 Tổng tiền:</div>
                <div class="detail-value">
                    <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                </div>
            </div>

            <div class="detail-item">
                <div class="detail-label">📊 Trạng thái:</div>
                <div class="detail-value">
                    <span class="status-badge status-${order.status}">
                        <c:choose>
                            <c:when test="${order.status == 'pending'}">⏳ Chờ xử lý</c:when>
                            <c:when test="${order.status == 'delivered'}">🚚 Đã giao hàng</c:when>
                            <c:when test="${order.status == 'completed'}">✅ Hoàn thành</c:when>
                            <c:when test="${order.status == 'success'}">✅ Thành công</c:when>
                            <c:when test="${order.status == 'cancel'}">❌ Đã hủy</c:when>
                            <c:when test="${order.status == 'error'}">⚠️ Lỗi</c:when>
                            <c:otherwise>📝 ${order.status}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>

            <div class="detail-item">
                <div class="detail-label">📅 Ngày đặt hàng:</div>
                <div class="detail-value">
                    <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                </div>
            </div>

            <c:if test="${not empty order.note}">
                <div class="detail-item">
                    <div class="detail-label">📝 Ghi chú:</div>
                    <div class="detail-value">${order.note}</div>
                </div>
            </c:if>
        </div>

        <h2 class="section-header">🛍️ Danh sách sản phẩm</h2>

        <div class="products-card">
            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>🎁 Sản phẩm</th>
                            <th>💵 Đơn giá</th>
                            <th>🔢 Số lượng</th>
                            <th>💰 Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orderItems}" var="item">
                            <tr>
                                <td style="font-weight: 600;">${item.productName}</td>
                                <td>
                                    <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                </td>
                                <td style="text-align: center; font-weight: 600;">${item.quantity}</td>
                                <td style="font-weight: 700; color: #66bb6a;">
                                    <fmt:formatNumber value="${item.total}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="actions">
            <c:if test="${order.status == 'pending'}">
                <a href="${pageContext.request.contextPath}/orders/update-status?id=${order.orderId}&status=delivered"
                   class="btn btn-warning">✅ Xác nhận đơn hàng</a>
                <a href="${pageContext.request.contextPath}/orders/update-status?id=${order.orderId}&status=cancel"
                   class="btn btn-danger"
                   onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')">❌ Hủy đơn hàng</a>
            </c:if>

            <c:if test="${order.status == 'delivered'}">
                <a href="${pageContext.request.contextPath}/orders/update-status?id=${order.orderId}&status=success"
                   class="btn btn-primary">🚚 Xác nhận đã giao hàng</a>
            </c:if>

            <c:if test="${order.status == 'success' || order.status == 'delivered'}">
                <a href="${pageContext.request.contextPath}/orders/update-status?id=${order.orderId}&status=completed"
                   class="btn btn-success">✓ Xác nhận hoàn thành</a>
            </c:if>

            <a href="${pageContext.request.contextPath}/orders" class="btn btn-secondary">↩️ Quay lại danh sách</a>
        </div>
    </div>

    <script>
        // Add interactive hover effects
        document.querySelectorAll('.detail-item').forEach(item => {
            item.addEventListener('mouseenter', function() {
                this.style.transform = 'translateX(5px)';
            });

            item.addEventListener('mouseleave', function() {
                this.style.transform = 'translateX(0)';
            });
        });

        // Add click animation to buttons
        document.querySelectorAll('.btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                let ripple = document.createElement('span');
                ripple.style.position = 'absolute';
                ripple.style.borderRadius = '50%';
                ripple.style.background = 'rgba(255, 255, 255, 0.6)';
                ripple.style.transform = 'scale(0)';
                ripple.style.animation = 'ripple 0.6s linear';
                ripple.style.left = (e.offsetX - 10) + 'px';
                ripple.style.top = (e.offsetY - 10) + 'px';
                ripple.style.width = ripple.style.height = '20px';

                this.appendChild(ripple);

                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });

        // Add CSS for ripple animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>
  <title>Chi tiết đơn hàng</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
