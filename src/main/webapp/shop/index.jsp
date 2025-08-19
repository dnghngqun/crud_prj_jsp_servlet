<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa Hàng - GoMsu Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- Fixed Navbar -->
    <nav class="navbar" id="navbar">
        <div class="navbar-container">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">
                <i class="fas fa-store"></i>
                GoMsu Store
            </a>

            <ul class="navbar-nav" id="navbarNav">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/" class="nav-link">
                        <i class="fas fa-home"></i> Trang Chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/shop" class="nav-link active">
                        <i class="fas fa-shopping-bag"></i> Cửa Hàng
                    </a>
                </li>
                <li class="nav-item dropdown">
                    <a href="#" class="nav-link">
                        <i class="fas fa-th-large"></i> Danh Mục
                        <i class="fas fa-chevron-down"></i>
                    </a>
                    <div class="dropdown-menu">
                        <a href="${pageContext.request.contextPath}/shop" class="dropdown-item">Tất Cả Sản Phẩm</a>
                        <c:forEach var="category" items="${categories}">
                            <a href="${pageContext.request.contextPath}/shop?categoryId=${category.categoryId}"
                               class="dropdown-item">${category.name}</a>
                        </c:forEach>
                    </div>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/orders" class="nav-link">
                        <i class="fas fa-box"></i> Đơn Hàng
                    </a>
                </li>
            </ul>

            <div class="user-menu">
                <a href="${pageContext.request.contextPath}/cart" class="cart-icon">
                    <i class="fas fa-shopping-cart"></i>
                    <span class="cart-count">0</span>
                </a>

                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <div class="dropdown">
                            <a href="#" class="nav-link">
                                <i class="fas fa-user"></i> ${sessionScope.user.username}
                            </a>
                            <div class="dropdown-menu">
                                <a href="${pageContext.request.contextPath}/profile" class="dropdown-item">Hồ Sơ</a>
                                <a href="${pageContext.request.contextPath}/orders" class="dropdown-item">Đơn Hàng</a>
                                <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">Đăng Xuất</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">
                            <i class="fas fa-sign-in-alt"></i> Đăng Nhập
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="mobile-toggle" id="mobileToggle">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container">
            <!-- Shop Header -->
            <div class="shop-header">
                <h1 class="shop-title">Cửa Hàng GoMsu</h1>
                <p class="shop-subtitle">
                    Khám phá bộ sưu tập đa dạng với hàng ngàn sản phẩm chất lượng cao
                </p>
            </div>

            <!-- Shop Controls -->
            <div class="shop-controls">
                <div class="search-box">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" class="search-input" placeholder="Tìm kiếm sản phẩm..."
                           value="${searchQuery}" id="searchInput">
                </div>

                <div class="category-filter">
                    <select class="category-select" id="categorySelect">
                        <option value="">Tất cả danh mục</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryId}"
                                    ${selectedCategoryId == category.categoryId ? 'selected' : ''}>
                                ${category.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="sort-options">
                    <button class="sort-btn active" data-sort="default">Mặc định</button>
                    <button class="sort-btn" data-sort="price-low">Giá thấp</button>
                    <button class="sort-btn" data-sort="price-high">Giá cao</button>
                    <button class="sort-btn" data-sort="name">Tên A-Z</button>
                </div>
            </div>

            <!-- Products Grid -->
            <div class="products-grid" id="productsGrid">
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach var="product" items="${products}">
                            <div class="product-card" data-name="${product.name}" data-price="${product.price}">
                                <div class="product-image">
                                    <img src="${not empty product.imageUrl ? product.imageUrl : '/images/no-image.jpg'}"
                                         alt="${product.name}" loading="lazy">
                                    <c:if test="${product.discount != null && product.discount > 0}">
                                        <div class="product-badge sale">
                                            -<fmt:formatNumber value="${product.discount}" type="number" maxFractionDigits="0"/>%
                                        </div>
                                    </c:if>
                                </div>

                                <div class="product-info">
                                    <div class="product-category">${product.categoryName}</div>
                                    <h3 class="product-name">${product.name}</h3>
                                    <p class="product-description">${product.description}</p>

                                    <div class="stock-status ${product.stock > 10 ? 'in-stock' : product.stock > 0 ? 'low-stock' : 'out-of-stock'}">
                                        <i class="fas fa-box"></i>
                                        <c:choose>
                                            <c:when test="${product.stock > 10}">Còn hàng</c:when>
                                            <c:when test="${product.stock > 0}">Sắp hết hàng (${product.stock} sản phẩm)</c:when>
                                            <c:otherwise>Hết hàng</c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="product-price">
                                        <c:choose>
                                            <c:when test="${product.discount != null && product.discount > 0}">
                                                <span class="current-price">
                                                    <fmt:formatNumber value="${product.price * (1 - product.discount/100)}" type="currency" currencyCode="VND"/>
                                                </span>
                                                <span class="original-price">
                                                    <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND"/>
                                                </span>
                                                <span class="discount-percent">
                                                    -<fmt:formatNumber value="${product.discount}" type="number" maxFractionDigits="0"/>%
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="current-price">
                                                    <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND"/>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="product-actions">
                                        <c:choose>
                                            <c:when test="${product.stock > 0}">
                                                <button class="btn-add-cart" onclick="addToCart(${product.id})">
                                                    <i class="fas fa-cart-plus"></i>
                                                    Thêm vào giỏ
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn-add-cart" disabled style="opacity: 0.5; cursor: not-allowed;">
                                                    <i class="fas fa-times"></i>
                                                    Hết hàng
                                                </button>
                                            </c:otherwise>
                                        </c:choose>

                                        <button class="btn-quick-view" onclick="quickView(${product.id})">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-state-icon">
                                <i class="fas fa-search"></i>
                            </div>
                            <h3 class="empty-state-title">Không tìm thấy sản phẩm</h3>
                            <p class="empty-state-message">
                                <c:choose>
                                    <c:when test="${not empty searchQuery}">
                                        Không có sản phẩm nào phù hợp với từ khóa "<strong>${searchQuery}</strong>"
                                    </c:when>
                                    <c:otherwise>
                                        Không có sản phẩm nào trong danh mục này
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">
                                <i class="fas fa-refresh"></i>
                                Xem tất cả sản phẩm
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Notification Container -->
    <div id="notificationContainer"></div>

    <script>
        // Fixed navbar on scroll
        window.addEventListener('scroll', function() {
            const navbar = document.getElementById('navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });

        // Mobile menu toggle
        document.getElementById('mobileToggle').addEventListener('click', function() {
            const navbarNav = document.getElementById('navbarNav');
            navbarNav.classList.toggle('active');
        });

        // Search functionality
        let searchTimeout;
        document.getElementById('searchInput').addEventListener('input', function() {
            clearTimeout(searchTimeout);
            const searchQuery = this.value.trim();

            searchTimeout = setTimeout(() => {
                if (searchQuery.length >= 2 || searchQuery.length === 0) {
                    performSearch(searchQuery);
                }
            }, 500);
        });

        // Category filter
        document.getElementById('categorySelect').addEventListener('change', function() {
            const categoryId = this.value;
            const searchQuery = document.getElementById('searchInput').value.trim();

            let url = '${pageContext.request.contextPath}/shop';
            const params = new URLSearchParams();

            if (categoryId) params.append('categoryId', categoryId);
            if (searchQuery) params.append('search', searchQuery);

            if (params.toString()) {
                url += '?' + params.toString();
            }

            window.location.href = url;
        });

        // Sort functionality
        document.querySelectorAll('.sort-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.sort-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');

                const sortType = this.getAttribute('data-sort');
                sortProducts(sortType);
            });
        });

        function performSearch(query) {
            const categoryId = document.getElementById('categorySelect').value;

            let url = '${pageContext.request.contextPath}/shop';
            const params = new URLSearchParams();

            if (query) params.append('search', query);
            if (categoryId) params.append('categoryId', categoryId);

            if (params.toString()) {
                url += '?' + params.toString();
            }

            window.location.href = url;
        }

        function sortProducts(type) {
            const grid = document.getElementById('productsGrid');
            const products = Array.from(grid.children);

            products.sort((a, b) => {
                switch(type) {
                    case 'price-low':
                        return parseFloat(a.dataset.price) - parseFloat(b.dataset.price);
                    case 'price-high':
                        return parseFloat(b.dataset.price) - parseFloat(a.dataset.price);
                    case 'name':
                        return a.dataset.name.localeCompare(b.dataset.name);
                    default:
                        return 0;
                }
            });

            products.forEach(product => grid.appendChild(product));
        }

        function addToCart(productId) {
            fetch('${pageContext.request.contextPath}/cart/add', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'productId=' + productId + '&quantity=1'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showNotification('Đã thêm sản phẩm vào giỏ hàng!', 'success');
                    updateCartCount();
                } else {
                    showNotification(data.message || 'Có lỗi xảy ra!', 'error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showNotification('Có lỗi xảy ra khi thêm sản phẩm!', 'error');
            });
        }

        function quickView(productId) {
            window.location.href = '${pageContext.request.contextPath}/product/detail?id=' + productId;
        }

        function updateCartCount() {
            fetch('${pageContext.request.contextPath}/cart/count')
            .then(response => response.json())
            .then(data => {
                document.querySelector('.cart-count').textContent = data.count || 0;
            });
        }

        function showNotification(message, type) {
            const container = document.getElementById('notificationContainer');
            const notification = document.createElement('div');
            notification.className = 'notification notification-' + type;

            const icon = type === 'success' ? 'check-circle' : 'exclamation-circle';
            notification.innerHTML = '<i class="fas fa-' + icon + '"></i>' + message;

            container.appendChild(notification);

            setTimeout(() => {
                notification.classList.add('show');
            }, 100);

            setTimeout(() => {
                notification.classList.remove('show');
                setTimeout(() => notification.remove(), 300);
            }, 3000);
        }

        // Load cart count on page load
        document.addEventListener('DOMContentLoaded', updateCartCount);
    </script>
</body>
</html>
