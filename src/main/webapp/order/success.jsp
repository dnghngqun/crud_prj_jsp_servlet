<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng thành công - Gomsu Shop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .success-container {
            max-width: 600px;
            margin: 2rem auto;
            text-align: center;
            background: white;
            border-radius: 12px;
            padding: 3rem 2rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        .success-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
            color: #28a745;
        }

        .success-title {
            font-size: 1.5rem;
            color: #28a745;
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .order-info {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1.5rem;
            margin: 2rem 0;
            text-align: left;
        }

        .order-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }

        .order-row:last-child {
            margin-bottom: 0;
            font-weight: 600;
            border-top: 1px solid #dee2e6;
            padding-top: 0.5rem;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }

        @media (max-width: 480px) {
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="success-container">
        <div class="success-icon">✅</div>
        <h1 class="success-title">Đặt hàng thành công!</h1>
        <p>Cảm ơn bạn đã đặt hàng tại Gomsu Shop. Chúng tôi sẽ xử lý đơn hàng và liên hệ với bạn sớm nhất.</p>

        <div class="order-info">
            <div class="order-row">
                <span>Mã đơn hàng:</span>
                <span><strong>#${param.orderId}</strong></span>
            </div>
            <div class="order-row">
                <span>Trạng thái:</span>
                <span style="color: #ffc107;">⏳ Chờ xử lý</span>
            </div>
            <div class="order-row">
                <span>Thời gian đặt hàng:</span>
                <span><script>document.write(new Date().toLocaleString('vi-VN'));</script></span>
            </div>
        </div>

        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-primary">
                📋 Xem đơn hàng
            </a>
            <a href="${pageContext.request.contextPath}/shop" class="btn btn-success">
                🛍️ Tiếp tục mua sắm
            </a>
        </div>
    </div>
</div>
</body>
</html>