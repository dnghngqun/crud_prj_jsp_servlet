<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách đơn hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <div class="header">
        <h1>📋 Danh sách đơn hàng</h1>
        <p>Quản lý tất cả các đơn hàng trong hệ thống</p>
    </div>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/shop" class="btn btn-success">🛍️ Tiếp tục mua sắm</a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">🏠 Trang chủ</a>
    </div>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="empty-cart">
                <div class="empty-cart-icon">📋</div>
                <h2>Bạn chưa có đơn hàng nào</h2>
                <p>Hãy mua sắm và đặt đơn hàng đầu tiên của bạn</p>
                <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">Mua sắm ngay</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-container">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Mã đơn hàng</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${orders}" var="order">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.createdAt}</td>
                            <td>${order.totalPrice} VNĐ</td>
                            <td>
                                <span class="status-badge status-${order.status.toLowerCase()}">
                                    <c:choose>
                                        <c:when test="${order.status == 'pending'}">Chờ xử lý</c:when>
                                        <c:when test="${order.status == 'delivered'}">Đã giao hàng</c:when>
                                        <c:when test="${order.status == 'success'}">Thành công</c:when>
                                        <c:when test="${order.status == 'completed'}">Thành công</c:when>
                                        <c:when test="${order.status == 'cancel'}">Đã hủy</c:when>
                                        <c:when test="${order.status == 'error'}">Lỗi</c:when>
                                        <c:otherwise>${order.status}</c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                            <td>
                                <div class="table-actions">
                                    <a href="${pageContext.request.contextPath}/orders/detail?id=${order.orderId}"
                                       class="btn btn-primary btn-sm" style="color: white">
                                        👁️ Chi tiết
                                    </a>
                                    <c:if test="${order.status == 'PENDING'}">
                                        <a href="${pageContext.request.contextPath}/orders/cancel?id=${order.orderId}"
                                           class="btn btn-danger btn-sm" style="color: white"
                                           onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')">
                                            ❌ Hủy đơn
                                        </a>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<style>
    .status-badge {
        display: inline-block;
        padding: 4px 8px;
        border-radius: var(--radius-sm);
        font-size: 0.8125rem;
        font-weight: 500;
    }

    .status-pending {
        background-color: #FFF3CD;
        color: #856404;
        border: 1px solid #FFEEBA;
    }

    .status-processing {
        background-color: #CCE5FF;
        color: #004085;
        border: 1px solid #B8DAFF;
    }

    .status-shipped {
        background-color: #D4EDDA;
        color: #155724;
        border: 1px solid #C3E6CB;
    }

    .status-delivered {
        background-color: #D1E7DD;
        color: #0F5132;
        border: 1px solid #BADBCC;
    }

    .status-cancelled {
        background-color: #F8D7DA;
        color: #721C24;
        border: 1px solid #F5C6CB;
    }
</style>
</body>
</html>