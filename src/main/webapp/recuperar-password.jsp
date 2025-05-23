<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recuperar Contraseña - Sistema de Gestión de Libros</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Poppins:wght@300;400;600&display=swap');
        
        :root {
            --primary-color: #5e35b1;
            --secondary-color: #3949ab;
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
        
        .recovery-container {
            position: relative;
            z-index: 2;
            width: 380px;
            padding: 2.5rem;
            background: var(--glass-color);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 16px;
            border: var(--glass-border);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            color: var(--text-color);
            animation: fadeIn 0.8s ease-in-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .recovery-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .recovery-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            margin-bottom: 0.5rem;
            background: linear-gradient(to right, #fff, #e0e0e0);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .recovery-header p {
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        .alert {
            margin-bottom: 1.5rem;
            border-radius: 8px;
            padding: 12px 15px;
            font-size: 0.9rem;
        }
        
        .alert-success {
            background-color: rgba(25, 135, 84, 0.8);
            border: 1px solid rgba(25, 135, 84, 0.9);
        }
        
        .alert-danger {
            background-color: rgba(220, 53, 69, 0.8);
            border: 1px solid rgba(220, 53, 69, 0.9);
        }
        
        .recovery-form .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }
        
        .recovery-form .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        .recovery-form .form-group input {
            width: 100%;
            padding: 12px 15px;
            background: rgba(255, 255, 255, 0.1);
            border: var(--glass-border);
            border-radius: 8px;
            color: var(--text-color);
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .recovery-form .form-group input:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.4);
        }
        
        .recovery-form .form-group input::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }
        
        .btn-recovery {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 0.5rem;
        }
        
        .btn-recovery:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }
        
        .recovery-footer {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.85rem;
        }
        
        .recovery-footer a {
            color: var(--text-color);
            text-decoration: none;
            opacity: 0.8;
            transition: opacity 0.3s;
        }
        
        .recovery-footer a:hover {
            opacity: 1;
            text-decoration: underline;
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
    
    <div class="recovery-container">
        <div class="recovery-header">
            <h1>Recuperar Contraseña</h1>
            <p>Ingresa tu correo electrónico para recibir instrucciones</p>
        </div>
        
        <c:if test="${not empty mensaje}">
            <div class="alert alert-${tipo != null ? tipo : 'success'}">
                ${mensaje}
            </div>
        </c:if>
        
        <form class="recovery-form" action="${pageContext.request.contextPath}/recuperar-password" method="post">
            <div class="form-group">
                <label for="email">Correo Electrónico</label>
                <input type="email" id="email" name="email" placeholder="Ingrese su correo electrónico" required>
            </div>
            
            <button type="submit" class="btn-recovery">
                <i class="fas fa-paper-plane"></i> Enviar Instrucciones
            </button>
        </form>
        
        <div class="recovery-footer">
            <p><a href="${pageContext.request.contextPath}/login"><i class="fas fa-arrow-left"></i> Volver al inicio de sesión</a></p>
        </div>
    </div>

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
    
    <!-- Font Awesome para los iconos -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>