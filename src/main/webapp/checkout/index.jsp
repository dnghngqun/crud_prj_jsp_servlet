<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - Gomsu Shop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout.css">
</head>
<body>
<div class="container">
    <div class="header">
        <h1>💳 Thanh toán</h1>
        <p>Xác nhận thông tin và hoàn tất đặt hàng</p>

        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/shop">🛍️ Mua sắm</a>
            <span>→</span>
            <a href="${pageContext.request.contextPath}/cart">🛒 Giỏ hàng</a>
            <span>→</span>
            <span class="current">💳 Thanh toán</span>
        </div>
    </div>

    <c:if test="${param.error == 'address'}">
        <div class="alert alert-error">
            ⚠️ Vui lòng chọn hoặc nhập đầy đủ thông tin địa chỉ giao hàng!
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/order/create" method="post" class="checkout-form">
        <div class="checkout-container">
            <div class="checkout-main">
                <!-- Address Section -->
                <div class="form-section">
                    <h3>📍 Thông tin giao hàng</h3>

                    <c:if test="${not empty addresses}">
                        <div class="address-options">
                            <h4>Địa chỉ đã lưu:</h4>
                            <div class="address-grid">
                                <c:forEach items="${addresses}" var="addr">
                                    <label class="address-card">
                                        <input type="radio" name="addressBookId" value="${addr.id}">
                                        <div class="address-content">
                                            <div class="address-name">${addr.fullName}</div>
                                            <div class="address-phone">📞 ${addr.phoneNumber}</div>
                                            <div class="address-detail">📍 ${addr.address}</div>
                                        </div>
                                        <div class="address-check">✓</div>
                                    </label>
                                </c:forEach>
                            </div>
                            <div class="divider">
                                <span>Hoặc</span>
                            </div>
                        </div>
                    </c:if>

                    <div class="new-address-section">
                        <h4>Nhập địa chỉ mới:</h4>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="newFullName">Họ và tên *</label>
                                <input type="text" id="newFullName" name="newFullName" class="form-control"
                                       placeholder="Nhập họ và tên người nhận">
                            </div>
                            <div class="form-group">
                                <label for="newPhoneNumber">Số điện thoại *</label>
                                <input type="tel" id="newPhoneNumber" name="newPhoneNumber" class="form-control"
                                       placeholder="Nhập số điện thoại">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="newAddress">Địa chỉ chi tiết *</label>
                            <textarea id="newAddress" name="newAddress" class="form-control" rows="3"
                                      placeholder="Nhập địa chỉ chi tiết (số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố)"></textarea>
                        </div>
                        <div class="form-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="saveAddress" value="true">
                                <span class="checkmark"></span>
                                💾 Lưu vào sổ địa chỉ để sử dụng cho lần sau
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Note Section -->
                <div class="form-section">
                    <h3>📝 Ghi chú đơn hàng</h3>
                    <div class="form-group">
                        <textarea name="note" class="form-control" rows="3"
                                  placeholder="Ghi chú cho người bán về đơn hàng (không bắt buộc)"></textarea>
                    </div>
                </div>
            </div>

            <div class="order-summary">
                <h3>📋 Đơn hàng của bạn</h3>

                <div class="order-items">
                    <c:forEach items="${cartItems}" var="item">
                        <div class="order-item">
                            <div class="item-image">
                                <c:choose>
                                    <c:when test="${not empty item.imageUrl}">
                                        <img src="${item.imageUrl}" alt="${item.productName}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-image">📦</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="item-details">
                                <div class="item-name">${item.productName}</div>
                                <div class="item-quantity">Số lượng: ${item.quantity}</div>
                                <div class="item-price">${item.price} VNĐ</div>
                            </div>
                            <div class="item-total">${item.total} VNĐ</div>
                        </div>
                    </c:forEach>
                </div>

                <div class="order-total">
                    <div class="total-row">
                        <span>Tạm tính:</span>
                        <span>${cartTotal} VNĐ</span>
                    </div>
                    <div class="total-row">
                        <span>Phí vận chuyển:</span>
                        <span class="free">Miễn phí</span>
                    </div>
                    <div class="total-row final">
                        <span>Tổng cộng:</span>
                        <span>${cartTotal} VNĐ</span>
                    </div>
                </div>

                <button type="submit" class="place-order-btn">
                    🛒 Đặt hàng ngay
                    <small>Bạn sẽ được chuyển đến trang xác nhận</small>
                </button>

                <div class="security-note">
                    <div class="security-icon">🔒</div>
                    <div class="security-text">
                        <strong>Thanh toán an toàn</strong><br>
                        Thông tin của bạn được bảo mật tuyệt đối
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const addressRadios = document.querySelectorAll('input[name="addressBookId"]');
        const newAddressInputs = document.querySelectorAll('.new-address-section input, .new-address-section textarea');

        // Handle address selection
        addressRadios.forEach(radio => {
            radio.addEventListener('change', function() {
                if (this.checked) {
                    // Clear new address inputs when selecting saved address
                    newAddressInputs.forEach(input => {
                        input.value = '';
                    });
                }
            });
        });

        // Handle new address input
        newAddressInputs.forEach(input => {
            input.addEventListener('input', function() {
                if (this.value.trim() !== '') {
                    // Uncheck saved addresses when typing new address
                    addressRadios.forEach(radio => {
                        radio.checked = false;
                    });
                }
            });
        });

        // Form validation
        document.querySelector('.checkout-form').addEventListener('submit', function(e) {
            const hasSelectedAddress = Array.from(addressRadios).some(radio => radio.checked);
            const hasNewAddress = document.getElementById('newFullName').value.trim() !== '' &&
                document.getElementById('newPhoneNumber').value.trim() !== '' &&
                document.getElementById('newAddress').value.trim() !== '';

            if (!hasSelectedAddress && !hasNewAddress) {
                e.preventDefault();
                alert('Vui lòng chọn địa chỉ đã lưu hoặc nhập địa chỉ mới!');
                return false;
            }
        });
    });
</script>
</body>
</html>