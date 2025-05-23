<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso Denegado - Biblioteca Municipal</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Poppins:wght@300;400;600&display=swap');
        
        :root {
            --primary-color: #5e35b1;
            --secondary-color: #3949ab;
            --error-color: #ff4444;
            --glass-color: rgba(255, 255, 255, 0.15);
            --glass-border: 1px solid rgba(255, 255, 255, 0.2);
            --text-color: #fff;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            height: 100vh;
            background: url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
        }
        
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 1;
        }
        
        .error-container {
            position: relative;
            z-index: 2;
            width: 500px;
            padding: 2.5rem;
            background: var(--glass-color);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 16px;
            border: var(--glass-border);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            color: var(--text-color);
            text-align: center;
            animation: fadeIn 0.8s ease-in-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .error-icon {
            font-size: 5rem;
            color: var(--error-color);
            margin-bottom: 1.5rem;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
        
        .error-title {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            margin-bottom: 1rem;
            color: var(--error-color);
        }
        
        .error-message {
            font-size: 1.1rem;
            margin-bottom: 2rem;
            opacity: 0.9;
            line-height: 1.6;
        }
        
        .btn-back {
            padding: 12px 30px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin: 0.5rem;
        }
        
        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }
        
        /* Efectos de partículas decorativas */
        .particle {
            position: absolute;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 50%;
            z-index: 1;
            animation: float 15s ease-in-out infinite alternate;
        }
        
        @keyframes float {
            0% { transform: translate(0, 0); }
            50% { transform: translate(20px, 20px); }
            100% { transform: translate(0, 0); }
        }
    </style>
</head>
<body>
    <!-- Partículas decorativas -->
    <div id="particles"></div>
    
    <div class="error-container">
        <div class="error-icon">
            <i class="fas fa-ban"></i>
        </div>
        <h1 class="error-title">Acceso Denegado</h1>
        <p class="error-message">
            No tienes los permisos necesarios para acceder a esta página.<br>
            Por favor, contacta al administrador si crees que esto es un error.
        </p>
        
        <c:if test="${not empty sessionScope.usuario}">
            <c:choose>
                <c:when test="${sessionScope.usuario.rol eq 'Bibliotecario'}">
                    <a href="${pageContext.request.contextPath}/bibliotecario/lectores" class="btn-back">
                        <i class="fas fa-home"></i> Volver al Panel
                    </a>
                </c:when>
                <c:when test="${sessionScope.usuario.rol eq 'Lector'}">
                    <a href="${pageContext.request.contextPath}/lector/lectores" class="btn-back">
                        <i class="fas fa-home"></i> Volver al Panel
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn-back">
                        <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
                    </a>
                </c:otherwise>
            </c:choose>
        </c:if>
        
        <c:if test="${empty sessionScope.usuario}">
            <a href="${pageContext.request.contextPath}/login" class="btn-back">
                <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
            </a>
        </c:if>
    </div>

    <!-- Font Awesome -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
    
    <script>
        // Crear partículas decorativas
        document.addEventListener('DOMContentLoaded', function() {
            const particlesContainer = document.getElementById('particles');
            const particleCount = 15;
            
            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.classList.add('particle');
                
                // Tamaño aleatorio entre 2px y 6px
                const size = Math.random() * 4 + 2;
                particle.style.width = `${size}px`;
                particle.style.height = `${size}px`;
                
                // Posición aleatoria en la pantalla
                particle.style.left = `${Math.random() * 100}vw`;
                particle.style.top = `${Math.random() * 100}vh`;
                
                // Opacidad aleatoria
                particle.style.opacity = Math.random() * 0.6 + 0.2;
                
                // Duración de animación aleatoria
                const duration = Math.random() * 20 + 10;
                particle.style.animationDuration = `${duration}s`;
                
                particlesContainer.appendChild(particle);
            }
        });
    </script>
</body>
</html>s