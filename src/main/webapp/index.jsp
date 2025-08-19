<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GomSu Store - Cửa hàng gốm sứ cao cấp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .hero-section {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .hero-content {
            text-align: center;
            max-width: 800px;
            z-index: 2;
            animation: heroEntrance 2s ease-out;
        }

        @keyframes heroEntrance {
            0% {
                opacity: 0;
                transform: translateY(100px) scale(0.8);
                filter: blur(20px);
            }
            100% {
                opacity: 1;
                transform: translateY(0) scale(1);
                filter: blur(0);
            }
        }

        .hero-title {
            font-family: 'Orbitron', monospace;
            font-size: clamp(3rem, 8vw, 6rem);
            font-weight: 900;
            background: linear-gradient(45deg, #fff, var(--primary), var(--secondary), var(--accent));
            background-size: 400% 400%;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: gradientText 4s ease infinite, titleFloat 6s ease-in-out infinite;
            margin-bottom: 1.5rem;
            text-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        @keyframes titleFloat {
            0%, 100% { transform: translateY(0px) rotateZ(0deg); }
            50% { transform: translateY(-15px) rotateZ(1deg); }
        }

        .hero-subtitle {
            font-size: clamp(1.2rem, 3vw, 2rem);
            color: rgba(255, 255, 255, 0.9);
            font-weight: 300;
            margin-bottom: 3rem;
            animation: fadeInUp 1.5s ease-out 0.5s both;
            text-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .hero-cta {
            display: flex;
            gap: 2rem;
            justify-content: center;
            flex-wrap: wrap;
            animation: fadeInUp 1.5s ease-out 1s both;
        }

        .cta-button {
            padding: 1.5rem 3rem;
            font-size: 1.2rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            border: none;
            border-radius: var(--radius-2xl);
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
            backdrop-filter: blur(15px);
            min-width: 200px;
        }

        .cta-primary {
            background: linear-gradient(135deg, var(--primary), var(--primary-light), var(--secondary));
            background-size: 300% 300%;
            color: white;
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.4);
        }

        .cta-secondary {
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.3);
            color: white;
            backdrop-filter: blur(20px);
        }

        .cta-button:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 25px 60px rgba(102, 126, 234, 0.6);
        }

        .cta-primary:hover {
            background-position: 100% 50%;
            animation: liquidFlow 2s ease infinite;
        }

        .cta-secondary:hover {
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.5);
        }

        @keyframes liquidFlow {
            0%, 100% { filter: hue-rotate(0deg); }
            50% { filter: hue-rotate(90deg); }
        }

        /* Floating elements */
        .floating-elements {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
        }

        .floating-element {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            animation: floatAround 15s ease-in-out infinite;
        }

        .floating-element:nth-child(1) {
            width: 100px;
            height: 100px;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-element:nth-child(2) {
            width: 150px;
            height: 150px;
            top: 60%;
            right: 10%;
            animation-delay: 5s;
        }

        .floating-element:nth-child(3) {
            width: 80px;
            height: 80px;
            bottom: 20%;
            left: 20%;
            animation-delay: 10s;
        }

        .floating-element:nth-child(4) {
            width: 120px;
            height: 120px;
            top: 10%;
            right: 30%;
            animation-delay: 2s;
        }

        @keyframes floatAround {
            0%, 100% {
                transform: translateY(0px) translateX(0px) rotate(0deg) scale(1);
                opacity: 0.3;
            }
            25% {
                transform: translateY(-30px) translateX(20px) rotate(90deg) scale(1.1);
                opacity: 0.6;
            }
            50% {
                transform: translateY(-60px) translateX(-10px) rotate(180deg) scale(0.9);
                opacity: 0.8;
            }
            75% {
                transform: translateY(-30px) translateX(-30px) rotate(270deg) scale(1.05);
                opacity: 0.5;
            }
        }

        /* Features Section */
        .features-section {
            padding: 6rem 0;
            position: relative;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 3rem;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: var(--radius-2xl);
            padding: 3rem 2rem;
            text-align: center;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            animation: slideInUp 0.8s ease-out;
        }

        .feature-card:nth-child(1) { animation-delay: 0.2s; }
        .feature-card:nth-child(2) { animation-delay: 0.4s; }
        .feature-card:nth-child(3) { animation-delay: 0.6s; }

        .feature-card:hover {
            transform: translateY(-10px) scale(1.03);
            box-shadow: 0 30px 60px rgba(31, 38, 135, 0.4);
            border-color: rgba(255, 255, 255, 0.3);
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transition: left 0.6s;
        }

        .feature-card:hover::before {
            left: 100%;
        }

        .feature-icon {
            font-size: 4rem;
            margin-bottom: 2rem;
            display: block;
            animation: iconFloat 3s ease-in-out infinite;
        }

        .feature-card:nth-child(2) .feature-icon {
            animation-delay: 1s;
        }

        .feature-card:nth-child(3) .feature-icon {
            animation-delay: 2s;
        }

        @keyframes iconFloat {
            0%, 100% { transform: translateY(0px) rotateZ(0deg); }
            50% { transform: translateY(-10px) rotateZ(5deg); }
        }

        .feature-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: white;
            margin-bottom: 1rem;
            background: linear-gradient(45deg, #fff, rgba(255, 255, 255, 0.8));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .feature-description {
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.1rem;
            line-height: 1.6;
        }

        /* Navigation */
        .main-nav {
            position: fixed;
            top: 2rem;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1000;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: var(--radius-2xl);
            padding: 1rem 2rem;
            animation: slideInDown 1s ease-out 2s both;
        }

        .nav-menu {
            display: flex;
            list-style: none;
            gap: 2rem;
            align-items: center;
            margin: 0;
        }

        .nav-item {
            margin: 0;
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
            padding: 0.75rem 1.5rem;
            border-radius: var(--radius-lg);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.3s;
        }

        .nav-link:hover {
            color: white;
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }

        .nav-link:hover::before {
            left: 100%;
        }

        .logo {
            font-family: 'Orbitron', monospace;
            font-size: 1.5rem;
            font-weight: 900;
            background: linear-gradient(45deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        /* Scroll indicator */
        .scroll-indicator {
            position: absolute;
            bottom: 3rem;
            left: 50%;
            transform: translateX(-50%);
            color: rgba(255, 255, 255, 0.7);
            animation: bounce 2s ease-in-out infinite;
            font-size: 2rem;
            cursor: pointer;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-cta {
                flex-direction: column;
                align-items: center;
            }

            .cta-button {
                width: 100%;
                max-width: 300px;
            }

            .features-grid {
                grid-template-columns: 1fr;
                padding: 0 1rem;
            }

            .main-nav {
                left: 1rem;
                right: 1rem;
                transform: none;
                padding: 1rem;
            }

            .nav-menu {
                flex-wrap: wrap;
                gap: 1rem;
                justify-content: center;
            }
        }

        /* Advanced particle system */
        .particle-system {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .particle {
            position: absolute;
            width: 3px;
            height: 3px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 50%;
            animation: particleMove 10s linear infinite;
        }

        .particle:nth-child(odd) {
            animation-direction: reverse;
        }

        @keyframes particleMove {
            0% {
                transform: translateY(100vh) translateX(0) scale(0);
                opacity: 0;
            }
            10% {
                opacity: 1;
            }
            90% {
                opacity: 1;
            }
            100% {
                transform: translateY(-100px) translateX(100px) scale(1);
                opacity: 0;
            }
        }
    </style>
</head>
<body>
    <!-- Particle System -->
    <div class="particle-system" id="particles"></div>

    <!-- Navigation -->
    <nav class="main-nav">
        <ul class="nav-menu">
            <li class="nav-item">
                <span class="logo">🌟 GoMsu</span>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/shop" class="nav-link">🛍️ Cửa hàng</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/cart" class="nav-link">🛒 Giỏ hàng</a>
            </li>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/orders" class="nav-link">📦 Đơn hàng</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/auth/logout" class="nav-link">🚪 Đăng xuất</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/auth/login" class="nav-link">🔐 Đăng nhập</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="floating-elements">
            <div class="floating-element"></div>
            <div class="floating-element"></div>
            <div class="floating-element"></div>
            <div class="floating-element"></div>
        </div>

        <div class="hero-content">
            <h1 class="hero-title">GoMsu Store</h1>
            <p class="hero-subtitle">
                Chào mừng bạn đến với GomSu - Cửa hàng gốm sứ cao cấp
            </p>
            <div class="hero-cta">
                <a href="${pageContext.request.contextPath}/shop" class="cta-button cta-primary">
                    ✨ Khám phá ngay
                </a>
                <a href="${pageContext.request.contextPath}/auth/register" class="cta-button cta-secondary">
                    🚀 Đăng ký
                </a>
            </div>
        </div>

        <div class="scroll-indicator">
            ⬇️
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section">
        <div class="container">
            <div class="header">
                <h2>✨ Tại sao chọn GoMsu?</h2>
                <p>Trải nghiệm mua sắm đẳng cấp với công nghệ hiện đại</p>
            </div>

            <div class="features-grid">
                <div class="feature-card">
                    <span class="feature-icon">🎨</span>
                    <h3 class="feature-title">Thiết kế hiện đại</h3>
                    <p class="feature-description">
                        Giao diện liquid glass với hiệu ứng blur và animation mượt mà,
                        mang đến trải nghiệm thị giác tuyệt vời
                    </p>
                </div>

                <div class="feature-card">
                    <span class="feature-icon">⚡</span>
                    <h3 class="feature-title">Hiệu suất vượt trội</h3>
                    <p class="feature-description">
                        Tốc độ tải trang nhanh chóng, tương tác mượt mà với
                        công nghệ tối ưu hóa hiện đại
                    </p>
                </div>

                <div class="feature-card">
                    <span class="feature-icon">🔒</span>
                    <h3 class="feature-title">Bảo mật tuyệt đối</h3>
                    <p class="feature-description">
                        Hệ thống bảo mật đa lớp, mã hóa dữ liệu và
                        xác thực người dùng an toàn
                    </p>
                </div>
            </div>
        </div>
    </section>

    <script>
        // Create particle system
        function createParticles() {
            const particleContainer = document.getElementById('particles');
            const particleCount = 50;

            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.className = 'particle';

                // Random starting position
                particle.style.left = Math.random() * 100 + '%';
                particle.style.animationDelay = Math.random() * 10 + 's';
                particle.style.animationDuration = (Math.random() * 10 + 5) + 's';

                particleContainer.appendChild(particle);
            }
        }

        // Smooth scroll for scroll indicator
        document.querySelector('.scroll-indicator').addEventListener('click', function() {
            document.querySelector('.features-section').scrollIntoView({
                behavior: 'smooth'
            });
        });

        // Add ripple effect to CTA buttons
        document.querySelectorAll('.cta-button').forEach(button => {
            button.addEventListener('click', function(e) {
                const ripple = document.createElement('span');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;

                ripple.style.width = ripple.style.height = size + 'px';
                ripple.style.left = x + 'px';
                ripple.style.top = y + 'px';
                ripple.style.position = 'absolute';
                ripple.style.borderRadius = '50%';
                ripple.style.background = 'rgba(255, 255, 255, 0.5)';
                ripple.style.transform = 'scale(0)';
                ripple.style.animation = 'ripple 0.6s linear';
                ripple.style.pointerEvents = 'none';

                this.appendChild(ripple);

                setTimeout(() => ripple.remove(), 600);
            });
        });

        // Enhanced scroll effects
        window.addEventListener('scroll', function() {
            const scrolled = window.pageYOffset;
            const rate = scrolled * -0.5;

            document.querySelectorAll('.floating-element').forEach((element, index) => {
                element.style.transform = `translateY(${rate * (index + 1) * 0.1}px) rotate(${scrolled * 0.1}deg)`;
            });
        });

        // Initialize particles when page loads
        document.addEventListener('DOMContentLoaded', function() {
            createParticles();

            // Animate elements on scroll
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };

            const observer = new IntersectionObserver(function(entries) {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, observerOptions);

            document.querySelectorAll('.feature-card').forEach(card => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(50px)';
                card.style.transition = 'all 0.8s ease-out';
                observer.observe(card);
            });
        });
    </script>
</body>
</html>
