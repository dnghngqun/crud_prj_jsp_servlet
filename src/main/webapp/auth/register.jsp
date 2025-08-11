<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <div class="header">
        <h1>📝 Đăng ký</h1>
        <p>Tạo tài khoản mới</p>
    </div>

    <div class="form-container" style="max-width: 400px; margin: 0 auto;">
        <c:if test="${not empty error}">
            <div style="background: #ffe6e6; color: #d00; padding: 12px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #ffcccc;">
                    ${error}
            </div>
        </c:if>

        <form method="post">
            <div class="form-group">
                <label for="fullName">Họ và tên:</label>
                <input type="text" id="fullName" name="fullName" class="form-control"
                       value="${param.fullName}" placeholder="Nhập họ và tên..." required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" class="form-control"
                       value="${param.email}" placeholder="Nhập email..." required>
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu:</label>
                <input type="password" id="password" name="password" class="form-control"
                       placeholder="Nhập mật khẩu..." required>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Xác nhận mật khẩu:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control"
                       placeholder="Nhập lại mật khẩu..." required>
            </div>

            <div class="actions">
                <button type="submit" class="btn btn-success">📝 Đăng ký</button>
            </div>
        </form>

        <div style="text-align: center; margin-top: 20px; padding-top: 20px; border-top: 1px solid var(--gray-light);">
            <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập ngay</a></p>
            <p><a href="${pageContext.request.contextPath}/">← Quay lại trang chủ</a></p>
        </div>
    </div>
</div>
</body>
</html>