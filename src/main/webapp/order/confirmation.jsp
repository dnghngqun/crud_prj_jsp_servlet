<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận đơn hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <div class="header">
        <h1>✅ Đặt hàng thành công</h1>
        <p>Cảm ơn bạn đã đặt hàng tại Gomsu Shop</p>
    </div>

    <div class="detail-card">
        <div style="text-align: center; margin-bottom: 30px;">
            <div style="font-size: 60px; color: var(--success); margin-bottom: 20px;">✅</div>
            <h2 style="margin-bottom: 10px; color: var(--success);">Đơn hàng đã được xác nhận!</h2>
            <p>Mã đơn hàng: <strong>${order.orderId}</strong></p>
        </div>

        <div class="detail-item">
            <div class="detail-label">📅 Ngày đặt hàng:</div>
            <div class="detail-value">${order.createdAt}</div>
        </div>

        <div class="detail-item">
            <div class="detail-label">👤 Tên khách hàng:</div>
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
            <div class="detail-value">${order.totalPrice} VNĐ</div>
        </div>

        <div class="detail-item">
            <div class="detail-label">💳 Phương thức thanh toán:</div>
            <div class="detail-value">${order.paymentMethod}</div>
        </div>

        <div class="detail-item">
            <div class="detail-label">🚚 Trạng thái:</div>
            <div class="detail-value">Đang xử lý</div>
        </div>
    </div>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/orders" class="btn btn-primary">📋 Xem đơn hàng của tôi</a>
        <a href="${pageContext.request.contextPath}/shop" class="btn btn-success">🛍️ Tiếp tục mua sắm</a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">🏠 Về trang chủ</a>
    </div>
</div>
</body>
</html>