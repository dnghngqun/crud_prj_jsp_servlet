<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đăng nhập</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
  <div class="header">
    <h1>🔐 Đăng nhập</h1>
    <p>Đăng nhập vào tài khoản của bạn</p>
  </div>

  <div class="form-container" style="max-width: 400px; margin: 0 auto;">
    <c:if test="${not empty error}">
      <div style="background: #ffe6e6; color: #d00; padding: 12px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #ffcccc;">
          ${error}
      </div>
    </c:if>

    <form method="post">
      <input type="hidden" name="redirect" value="${param.redirect}">

      <div class="form-group">
        <label for="username">Email:</label>
        <input type="email" id="username" name="username" class="form-control"
               value="${param.username}" placeholder="Nhập email..." required>
      </div>

      <div class="form-group">
        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password" class="form-control"
               placeholder="Nhập mật khẩu..." required>
      </div>

      <div class="actions">
        <button type="submit" class="btn btn-primary">🔐 Đăng nhập</button>
      </div>
    </form>

    <div style="text-align: center; margin-top: 20px; padding-top: 20px; border-top: 1px solid var(--gray-light);">
      <p>Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a></p>
      <p><a href="${pageContext.request.contextPath}/">← Quay lại trang chủ</a></p>
    </div>

    <div style="background: var(--light); padding: 15px; border-radius: 8px; margin-top: 20px;">
      <strong>Tài khoản demo:</strong><br>
      Username: <code>admin</code> - Password: <code>admin123</code><br>
      Username: <code>user1</code> - Password: <code>user123</code>
    </div>
  </div>
</div>
</body>
</html>