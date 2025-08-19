<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - GoMsu Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .auth-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .auth-card {
            width: 100%;
            max-width: 450px;
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(30px);
            -webkit-backdrop-filter: blur(30px);
            border: 1px solid rgba(255, 255, 255, 0.25);
            border-radius: var(--radius-2xl);
            padding: 3rem;
            box-shadow: 0 25px 50px rgba(31, 38, 135, 0.4);
            position: relative;
            overflow: hidden;
            animation: morphIn 1.2s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .auth-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: linear-gradient(90deg, transparent, var(--primary), var(--secondary), transparent);
            animation: borderFlow 3s linear infinite;
        }

        .auth-card::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: conic-gradient(from 0deg, transparent, rgba(102, 126, 234, 0.1), transparent);
            animation: rotate 15s linear infinite;
            pointer-events: none;
        }

        @keyframes morphIn {
            0% {
                opacity: 0;
                transform: scale(0.8) rotateY(20deg);
                filter: blur(10px);
            }
            100% {
                opacity: 1;
                transform: scale(1) rotateY(0deg);
                filter: blur(0px);
            }
        }

        @keyframes borderFlow {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }

        .auth-header {
            text-align: center;
            margin-bottom: 2.5rem;
            position: relative;
            z-index: 1;
        }

        .auth-logo {
            font-family: 'Orbitron', monospace;
            font-size: 2.5rem;
            font-weight: 900;
            background: linear-gradient(45deg, #fff, var(--primary), var(--secondary));
            background-size: 200% 200%;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: gradientText 3s ease infinite;
            margin-bottom: 0.5rem;
            display: block;
        }

        .auth-subtitle {
            color: rgba(255, 255, 255, 0.8);
            font-size: 1rem;
            font-weight: 300;
        }

        .form-floating {
            position: relative;
            margin-bottom: 2rem;
            animation: slideInLeft 0.8s ease-out;
        }

        .form-floating:nth-child(2) { animation-delay: 0.2s; }
        .form-floating:nth-child(3) { animation-delay: 0.4s; }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .form-control-glass {
            width: 100%;
            padding: 1.25rem 1.5rem;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: var(--radius-lg);
            font-size: 1rem;
            color: white;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            z-index: 1;
        }

        .form-control-glass:focus {
            outline: none;
            border-color: var(--primary);
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.3),
                        0 8px 25px rgba(102, 126, 234, 0.2);
            transform: translateY(-2px) scale(1.02);
        }

        .form-control-glass::placeholder {
            color: rgba(255, 255, 255, 0.6);
            transition: all 0.3s ease;
        }

        .form-control-glass:focus::placeholder {
            color: rgba(255, 255, 255, 0.4);
            transform: translateY(-2px);
        }

        .floating-label {
            position: absolute;
            left: 1.5rem;
            top: 1.25rem;
            color: rgba(255, 255, 255, 0.6);
            font-size: 1rem;
            pointer-events: none;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: rgba(0, 0, 0, 0.1);
            padding: 0 0.5rem;
            border-radius: 4px;
            backdrop-filter: blur(5px);
        }

        .form-control-glass:focus + .floating-label,
        .form-control-glass:not(:placeholder-shown) + .floating-label {
            top: -0.5rem;
            left: 1rem;
            font-size: 0.85rem;
            color: var(--primary);
            background: rgba(102, 126, 234, 0.2);
        }

        .btn-liquid {
            width: 100%;
            padding: 1.25rem;
            background: linear-gradient(135deg, var(--primary), var(--primary-light), var(--secondary));
            background-size: 300% 300%;
            border: none;
            border-radius: var(--radius-lg);
            color: white;
            font-size: 1.1rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            margin-top: 1rem;
            animation: slideInUp 0.8s ease-out 0.6s both;
        }

        .btn-liquid::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.6s;
        }

        .btn-liquid:hover {
            background-position: 100% 50%;
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.4);
            animation: liquidPulse 2s ease infinite;
        }

        .btn-liquid:hover::before {
            left: 100%;
        }

        .btn-liquid:active {
            transform: translateY(-1px) scale(0.98);
        }

        @keyframes liquidPulse {
            0%, 100% { box-shadow: 0 15px 40px rgba(102, 126, 234, 0.4); }
            50% { box-shadow: 0 20px 50px rgba(102, 126, 234, 0.6); }
        }

        .auth-footer {
            text-align: center;
            margin-top: 2rem;
            position: relative;
            z-index: 1;
            animation: fadeIn 1s ease-out 0.8s both;
        }

        .auth-link {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
        }

        .auth-link::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            transition: width 0.3s ease;
        }

        .auth-link:hover {
            color: white;
            transform: translateY(-1px);
        }

        .auth-link:hover::after {
            width: 100%;
        }

        .alert-glass {
            background: rgba(255, 107, 107, 0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 107, 107, 0.3);
            border-radius: var(--radius-lg);
            padding: 1rem 1.5rem;
            color: white;
            margin-bottom: 1.5rem;
            animation: shakeIn 0.6s ease-out;
        }

        @keyframes shakeIn {
            0% { transform: translateX(-100px); opacity: 0; }
            60% { transform: translateX(10px); }
            80% { transform: translateX(-5px); }
            100% { transform: translateX(0); opacity: 1; }
        }

        /* Particle background */
        .particles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 0;
        }

        .particle {
            position: absolute;
            width: 4px;
            height: 4px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 50%;
            animation: particleFloat 6s ease-in-out infinite;
        }

        .particle:nth-child(1) { top: 20%; left: 20%; animation-delay: 0s; }
        .particle:nth-child(2) { top: 80%; left: 80%; animation-delay: 2s; }
        .particle:nth-child(3) { top: 60%; left: 10%; animation-delay: 4s; }
        .particle:nth-child(4) { top: 30%; left: 90%; animation-delay: 1s; }
        .particle:nth-child(5) { top: 70%; left: 50%; animation-delay: 3s; }

        @keyframes particleFloat {
            0%, 100% {
                transform: translateY(0px) scale(1);
                opacity: 0.6;
            }
            50% {
                transform: translateY(-20px) scale(1.2);
                opacity: 1;
            }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .auth-container {
                padding: 1rem;
            }

            .auth-card {
                padding: 2rem;
            }

            .auth-logo {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <div class="particles">
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
            </div>

            <div class="auth-header">
                <span class="auth-logo">🌟 GoMsu</span>
                <p class="auth-subtitle">Chào mừng bạn quay trở lại</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert-glass">
                    <strong>❌ Lỗi:</strong> ${error}
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/auth/login">
                <div class="form-floating">
                    <input type="email" class="form-control-glass" id="email" name="email"
                           placeholder=" " required>
                    <label for="email" class="floating-label">📧 Email</label>
                </div>

                <div class="form-floating">
                    <input type="password" class="form-control-glass" id="password" name="password"
                           placeholder=" " required>
                    <label for="password" class="floating-label">🔒 Mật khẩu</label>
                </div>

                <button type="submit" class="btn-liquid">
                    ✨ Đăng nhập
                </button>
            </form>

            <div class="auth-footer">
                <p style="color: rgba(255, 255, 255, 0.7); margin-bottom: 1rem;">
                    Chưa có tài khoản?
                </p>
                <a href="${pageContext.request.contextPath}/auth/register" class="auth-link">
                    🚀 Đăng ký ngay
                </a>
            </div>
        </div>
    </div>

    <script>
        // Add interactive ripple effect
        document.querySelector('.btn-liquid').addEventListener('click', function(e) {
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
            ripple.style.background = 'rgba(255, 255, 255, 0.6)';
            ripple.style.transform = 'scale(0)';
            ripple.style.animation = 'ripple 0.6s linear';
            ripple.style.pointerEvents = 'none';

            this.appendChild(ripple);

            setTimeout(() => ripple.remove(), 600);
        });

        // Add CSS for ripple animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(2);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);

        // Enhanced form validation with smooth animations
        const inputs = document.querySelectorAll('.form-control-glass');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.02)';
            });

            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });
    </script>
</body>
</html>
