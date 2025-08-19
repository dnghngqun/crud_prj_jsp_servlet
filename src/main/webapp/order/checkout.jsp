<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - GoMsu Store</title>
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

        .header {
            text-align: center;
            margin: 120px 0 3rem 0;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            padding: 2rem;
            border-radius: var(--radius-xl);
            border: 1px solid var(--glass-border);
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
            margin-top: 120px;
            margin-bottom: 3rem;
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .header p {
            color: var(--text-secondary);
            font-size: 1.1rem;
        }

        .checkout-container {
            display: grid;
            grid-template-columns: 1fr 450px;
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem 2rem 2rem;
        }

        .checkout-form {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--radius-xl);
            border: 1px solid var(--glass-border);
            padding: 2rem;
            box-shadow: var(--shadow-md);
        }

        .order-summary {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--radius-xl);
            border: 1px solid var(--glass-border);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            height: fit-content;
            position: sticky;
            top: 120px;
        }

        .form-section {
            margin-bottom: 2rem;
            padding-bottom: 2rem;
            border-bottom: 1px solid var(--glass-border);
        }

        .form-section:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }

        .form-section h3 {
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            font-size: 1.3rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--text-secondary);
            font-weight: 500;
            font-size: 0.9rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            border-radius: var(--radius);
            color: var(--text-primary);
            font-size: 1rem;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            background: rgba(255, 255, 255, 0.15);
        }

        .form-control::placeholder {
            color: var(--text-muted);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 80px;
        }

        .order-summary h3 {
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            font-size: 1.3rem;
            font-weight: 700;
            text-align: center;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--primary);
        }

        .order-items {
            max-height: 400px;
            overflow-y: auto;
            margin-bottom: 1.5rem;
        }

        .order-items::-webkit-scrollbar {
            width: 6px;
        }

        .order-items::-webkit-scrollbar-track {
            background: var(--glass-bg);
            border-radius: 3px;
        }

        .order-items::-webkit-scrollbar-thumb {
            background: var(--primary);
            border-radius: 3px;
        }

        .order-item {
            display: flex;
            align-items: flex-start;
            padding: 1.5rem 0;
            border-bottom: 1px solid var(--glass-border);
            gap: 1rem;
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .item-image {
            width: 80px;
            height: 80px;
            border-radius: var(--radius-md);
            overflow: hidden;
            flex-shrink: 0;
            box-shadow: var(--shadow-sm);
        }

        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.2s ease;
        }

        .item-image:hover img {
            transform: scale(1.05);
        }

        .item-info {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .item-name {
            font-weight: 600;
            color: var(--text-primary);
            font-size: 1rem;
            line-height: 1.3;
        }

        .item-category {
            color: var(--text-muted);
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .item-price {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .current-price {
            color: var(--primary);
            font-weight: 600;
            font-size: 0.95rem;
        }

        .original-price {
            color: var(--text-muted);
            text-decoration: line-through;
            font-size: 0.85rem;
        }

        .item-quantity {
            color: var(--primary);
            font-weight: 600;
            background: rgba(102, 126, 234, 0.2);
            padding: 0.2rem 0.5rem;
            border-radius: var(--radius-sm);
            font-size: 0.85rem;
        }

        .item-total {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
            border-top: 1px dashed var(--glass-border);
            margin-top: 0.5rem;
        }

        .total-label {
            color: var(--text-muted);
            font-size: 0.85rem;
            font-weight: 500;
        }

        .total-value {
            color: var(--text-primary);
            font-weight: 700;
            font-size: 1rem;
        }

        .total-section {
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 2px solid var(--glass-border);
        }

        .total-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
            padding: 0.5rem 0;
        }

        .total-row:last-child {
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--glass-border);
            font-size: 1.2rem;
            font-weight: 700;
        }

        .total-row span:first-child {
            color: var(--text-secondary);
        }

        .total-row span:last-child {
            color: var(--text-primary);
            font-weight: 600;
        }

        .total-row:last-child span {
            color: var(--primary);
            font-weight: 700;
        }

        .payment-methods {
            display: grid;
            gap: 1rem;
            margin-top: 1rem;
        }

        .payment-option {
            display: flex;
            align-items: center;
            padding: 1rem;
            border: 2px solid var(--glass-border);
            border-radius: var(--radius-lg);
            cursor: pointer;
            transition: all 0.3s ease;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
        }

        .payment-option:hover {
            border-color: var(--primary);
            background: rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }

        .payment-option.selected {
            border-color: var(--primary);
            background: rgba(102, 126, 234, 0.2);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .payment-option input[type="radio"] {
            margin-right: 1rem;
            width: 20px;
            height: 20px;
            accent-color: var(--primary);
        }

        .payment-option div {
            flex: 1;
        }

        .payment-option div div:first-child {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }

        .payment-option div div:last-child {
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        .submit-btn {
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
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .alert {
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            border-radius: var(--radius-lg);
            font-weight: 500;
            border: 1px solid;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .alert-danger {
            background: rgba(245, 101, 101, 0.1);
            color: var(--danger);
            border-color: rgba(245, 101, 101, 0.3);
        }

        .alert-success {
            background: rgba(72, 187, 120, 0.1);
            color: var(--success);
            border-color: rgba(72, 187, 120, 0.3);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .checkout-container {
                grid-template-columns: 1fr;
                gap: 1rem;
                padding: 0 1rem 1rem 1rem;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .header {
                margin-top: 100px;
                padding: 1.5rem;
            }

            .header h1 {
                font-size: 2rem;
            }

            .order-summary {
                position: static;
                top: auto;
            }
        }

        /* Loading animation */
        .loading {
            position: relative;
            pointer-events: none;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
            border: 2px solid transparent;
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>💳 Thanh toán</h1>
        <p>Hoàn tất đơn hàng của bạn</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            ${error}
        </div>
    </c:if>

    <div class="checkout-container">
        <!-- Checkout Form -->
        <div class="checkout-form">
            <form method="post" action="${pageContext.request.contextPath}/checkout">
                <!-- Customer Information -->
                <div class="form-section">
                    <h3>📋 Thông tin khách hàng</h3>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="customerName">Họ và tên *</label>
                            <input type="text" class="form-control" id="customerName" name="customerName"
                                   value="${sessionScope.user.fullName}" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="phoneNumber">Số điện thoại *</label>
                            <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber"
                                   value="${sessionScope.user.phoneNumber}" required>
                        </div>
                    </div>
                </div>

                <!-- Shipping Information -->
                <div class="form-section">
                    <h3>🚚 Thông tin giao hàng</h3>
                    <div class="form-group">
                        <label class="form-label" for="shippingAddress">Địa chỉ giao hàng *</label>
                        <textarea class="form-control" id="shippingAddress" name="shippingAddress"
                                  rows="3" required placeholder="Nhập địa chỉ chi tiết..."></textarea>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="note">Ghi chú</label>
                        <textarea class="form-control" id="note" name="note"
                                  rows="2" placeholder="Ghi chú đặc biệt cho đơn hàng..."></textarea>
                    </div>
                </div>

                <!-- Payment Method -->
                <div class="form-section">
                    <h3>💳 Phương thức thanh toán</h3>
                    <div class="payment-methods">
                        <label class="payment-option">
                            <input type="radio" name="paymentMethod" value="on_delivery" checked>
                            <div>
                                <div style="font-weight: 600;">💵 Thanh toán khi nhận hàng</div>
                                <div style="color: var(--gray); font-size: 0.9rem;">Thanh toán bằng tiền mặt khi nhận hàng</div>
                            </div>
                        </label>
                        <label class="payment-option">
                            <input type="radio" name="paymentMethod" value="online">
                            <div>
                                <div style="font-weight: 600;">🏦 Chuyển khoản ngân hàng</div>
                                <div style="color: var(--gray); font-size: 0.9rem;">Thanh toán qua chuyển khoản</div>
                            </div>
                        </label>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary submit-btn">
                    <i class="fas fa-shopping-cart"></i> Đặt hàng ngay
                </button>
            </form>
        </div>

        <!-- Order Summary -->
        <div class="order-summary">
            <h3>📦 Đơn hàng của bạn</h3>

            <div class="order-items">
                <c:forEach items="${cartItems}" var="item">
                    <div class="order-item">
                        <div class="item-image">
                            <c:choose>
                                <c:when test="${not empty item.product.imageUrl}">
                                    <img src="${item.product.imageUrl}" alt="${item.product.name}">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/images/default-product.jpg" alt="Default">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="item-info">
                            <div class="item-name">${item.product.name}</div>
                            <div class="item-category">${item.product.categoryName}</div>
                            <div class="item-price">
                                <c:choose>
                                    <c:when test="${item.product.discount != null && item.product.discount > 0}">
                                        <span class="current-price">
                                            <fmt:formatNumber value="${item.product.price * (1 - item.product.discount/100)}"
                                                            type="currency" currencySymbol="₫" groupingUsed="true"/>
                                        </span>
                                        <span class="original-price">
                                            <fmt:formatNumber value="${item.product.price}"
                                                            type="currency" currencySymbol="₫" groupingUsed="true"/>
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="current-price">
                                            <fmt:formatNumber value="${item.product.price}"
                                                            type="currency" currencySymbol="₫" groupingUsed="true"/>
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                                <span class="item-quantity">x${item.quantity}</span>
                            </div>
                            <div class="item-total">
                                <c:set var="itemPrice" value="${item.product.discount != null && item.product.discount > 0 ?
                                    item.product.price * (1 - item.product.discount/100) : item.product.price}" />
                                <span class="total-label">Thành tiền:</span>
                                <span class="total-value">
                                    <fmt:formatNumber value="${itemPrice * item.quantity}"
                                                    type="currency" currencySymbol="₫" groupingUsed="true"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="total-section">
                <div class="total-row">
                    <span>Tạm tính:</span>
                    <span><fmt:formatNumber value="${total}" type="currency" currencySymbol="₫" groupingUsed="true"/></span>
                </div>
                <div class="total-row">
                    <span>Phí vận chuyển:</span>
                    <span>Miễn phí</span>
                </div>
                <div class="total-row total-final">
                    <span>Tổng cộng:</span>
                    <span><fmt:formatNumber value="${total}" type="currency" currencySymbol="₫" groupingUsed="true"/></span>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Payment method selection
        document.querySelectorAll('.payment-option').forEach(option => {
            option.addEventListener('click', function() {
                document.querySelectorAll('.payment-option').forEach(opt => opt.classList.remove('selected'));
                this.classList.add('selected');
            });
        });

        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const requiredFields = this.querySelectorAll('[required]');
            let isValid = true;

            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    field.style.borderColor = 'var(--danger)';
                    isValid = false;
                } else {
                    field.style.borderColor = 'var(--glass-border)';
                }
            });

            if (!isValid) {
                e.preventDefault();
                alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
            }
        });
    </script>
</body>
</html>
