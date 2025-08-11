<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chi tiết đơn hàng</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
      <div class="detail-value">${order.orderId}</div>
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
      <div class="detail-label">🏠 Địa chỉ:</div>
      <div class="detail-value">${order.shippingAddress}</div>
    </div>

    <div class="detail-item">
      <div class="detail-label">💰 Tổng tiền:</div>
      <div class="detail-value">${order.totalPrice} VNĐ</div>
    </div>

    <div class="detail-item">
      <div class="detail-label">📊 Trạng thái:</div>
      <div class="detail-value">
        <c:choose>
          <c:when test="${order.status == 'pending'}">Chờ xử lý</c:when>
          <c:when test="${order.status == 'delivered'}">Đã giao hàng</c:when>
          <c:when test="${order.status == 'completed'}">Thành công</c:when>
          <c:when test="${order.status == 'success'}">Thành công</c:when>
          <c:when test="${order.status == 'cancel'}">Đã hủy</c:when>
          <c:when test="${order.status == 'error'}">Lỗi</c:when>
          <c:otherwise>${order.status}</c:otherwise>
        </c:choose>
      </div>
    </div>

    <div class="detail-item">
      <div class="detail-label">📅 Ngày đặt hàng:</div>
      <div class="detail-value">${order.createdAt}</div>
    </div>
  </div>

  <h2 style="margin: var(--spacing-xl) 0 var(--spacing-md) 0;">Danh sách sản phẩm</h2>
  <div class="table-container">
    <table class="table">
      <thead>
      <tr>
        <th>Sản phẩm</th>
        <th>Đơn giá</th>
        <th>Số lượng</th>
        <th>Thành tiền</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach items="${orderItems}" var="item">
        <tr>
          <td>${item.productName}</td>
          <td>${item.price} VNĐ</td>
          <td>${item.quantity}</td>
          <td>${item.total} VNĐ</td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>

  <div class="actions">
    <c:if test="${order.status == 'pending'}">
      <a href="${pageContext.request.contextPath}/orders/update-status?id=${order.orderId}&status=delivered"
         class="btn btn-warning" style="color: #fff">✅ Xác nhận đơn hàng</a>
      <a href="${pageContext.request.contextPath}/orders/update-status?id=${order.orderId}&status=cancel"
         class="btn btn-danger" style="color: #fff"
         onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')">❌ Hủy đơn hàng</a>
    </c:if>

    <c:if test="${order.status == 'delivered'}">
      <a href="${pageContext.request.contextPath}/orders/update-status?id=${order.orderId}&status=success"
         class="btn btn-primary" style="color: #fff">🚚 Xác nhận đã giao hàng</a>
    </c:if>
      <a href="${pageContext.request.contextPath}/orders/update-status?id=${order.orderId}&status=completed"
         class="btn btn-success" style="color: #fff">✓ Xác nhận hoàn thành</a>
    </c:if>

    <a href="${pageContext.request.contextPath}/orders" class="btn btn-secondary">↩️ Quay lại danh sách</a>
  </div>
</div>
</body>
</html>