<%@ page import="org.example.crud_prj_ex.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  Product p = (Product) request.getAttribute("product");
  boolean edit = p != null;
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><%= edit ? "Sửa" : "Thêm" %> sản phẩm</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
  <div class="header">
    <h1><%= edit ? "✏️ Sửa sản phẩm" : "➕ Thêm sản phẩm mới" %></h1>
    <p><%= edit ? "Cập nhật thông tin sản phẩm" : "Tạo sản phẩm mới" %></p>
  </div>

  <div class="form-container">
    <form method="post" enctype="multipart/form-data">
      <% if (edit) { %>
      <input type="hidden" name="id" value="<%= p.getId() %>"/>
      <% } %>

      <div class="form-group">
        <label for="name">Tên sản phẩm:</label>
        <input type="text" id="name" name="name" class="form-control"
               value="<%= edit ? p.getName() : "" %>"
               placeholder="Nhập tên sản phẩm..." required/>
      </div>

      <div class="form-group">
        <label for="description">Mô tả:</label>
        <textarea id="description" name="description" class="form-control" rows="4"
                  placeholder="Nhập mô tả sản phẩm..."><%= edit && p.getDescription() != null ? p.getDescription() : "" %></textarea>
      </div>

      <div class="form-group">
        <label for="categoryId">Danh mục:</label>
        <select id="categoryId" name="categoryId" class="form-control">
          <option value="">-- Chọn danh mục --</option>
          <c:forEach items="${categories}" var="c">
            <option value="${c.id}" ${edit && p.categoryId == c.id ? 'selected' : ''}>${c.name}</option>
          </c:forEach>
        </select>
      </div>

      <div class="form-group">
        <label for="price">Giá:</label>
        <input type="number" id="price" name="price" class="form-control" step="0.01" min="0"
               value="<%= edit ? p.getPrice() : "" %>"
               placeholder="Nhập giá sản phẩm..." required/>
      </div>

      <div class="form-group">
        <label for="discount">Giảm giá (để trống nếu không có):</label>
        <input type="number" id="discount" name="discount" class="form-control" step="0.01" min="0"
               value="<%= edit && p.getDiscount() != null ? p.getDiscount() : "" %>"
               placeholder="Nhập số tiền giảm giá..."/>
      </div>

      <div class="form-group">
        <label for="stock">Số lượng tồn kho:</label>
        <input type="number" id="stock" name="stock" class="form-control" min="0"
               value="<%= edit ? p.getStock() : "0" %>"
               placeholder="Nhập số lượng tồn kho..." required/>
      </div>

      <div class="form-group">
        <label for="imageUrl">URL Hình ảnh:</label>
        <input type="text" id="imageUrl" name="imageUrl" class="form-control"
               value="<%= edit && p.getImageUrl() != null ? p.getImageUrl() : "" %>"
               placeholder="Nhập URL hình ảnh sản phẩm..."/>
        <small style="color: #666;">Nhập đường dẫn hình ảnh (URL) của sản phẩm</small>
      </div>

      <div class="actions">
        <button type="submit" class="btn btn-success">
          <%= edit ? "💾 Cập nhật" : "➕ Thêm mới" %>
        </button>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">↩️ Quay lại</a>
      </div>
    </form>
  </div>
</div>
</body>
</html>