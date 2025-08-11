<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Thanh toán</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
</head>
<body>
<div class="container">
  <div class="header">
    <h1>💳 Thanh toán</h1>
    <p>Hoàn tất đơn hàng của bạn</p>
  </div>

  <c:if test="${not empty error}">
    <div class="alert alert-danger">
        ${error}
    </div>
  </c:if>

  <div class="cart-container">
    <div class="cart-items">
      <h3 style="padding: 20px;">Thông tin đơn hàng</h3>
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
            <div>Số lượng: ${item.quantity}</div>
          </div>
          <div class="item-total">
            <div class="total-label">Thành tiền:</div>
            <div class="total-value">${item.total} VNĐ</div>
          </div>
        </div>
      </c:forEach>
    </div>

    <div class="cart-summary">
      <h3>Thông tin thanh toán</h3>
      <form method="post" action="${pageContext.request.contextPath}/checkout">
        <div class="form-group">
          <label for="paymentMethod">Phương thức thanh toán:</label>
          <select id="paymentMethod" name="paymentMethod" class="form-control" required>
            <option value="">-- Chọn phương thức --</option>
            <option value="cod">Thanh toán khi nhận hàng (COD)</option>
            <option value="transfer">Chuyển khoản ngân hàng</option>
            <option value="card">Thẻ tín dụng/ghi nợ</option>
          </select>
        </div>

        <div class="summary-row total">
          <div class="summary-label">Tổng cộng:</div>
          <div class="summary-value">${total} VNĐ</div>
        </div>
        <button type="submit" class="btn btn-success checkout-btn">Xác nhận thanh toán</button>
        <a href="${pageContext.request.contextPath}/cart" class="btn btn-secondary" style="margin-top: 10px; width: 100%;">Quay lại giỏ hàng</a>
      </form>
    </div>
  </div>
</div>
</body>
</html>