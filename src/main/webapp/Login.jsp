<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso - Biblioteca Municipal</title>
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
        
        .login-container {
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
        
        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .login-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            margin-bottom: 0.5rem;
            background: linear-gradient(to right, #fff, #e0e0e0);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .login-header p {
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        .login-form .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }
        
        .login-form .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        .login-form .form-group input {
            width: 100%;
            padding: 12px 15px;
            background: rgba(255, 255, 255, 0.1);
            border: var(--glass-border);
            border-radius: 8px;
            color: var(--text-color);
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .login-form .form-group input:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.4);
        }
        
        .login-form .form-group input::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }
        
        .btn-login {
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
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }
        
        .login-footer {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.85rem;
        }
        
        .login-footer a {
            color: var(--text-color);
            text-decoration: none;
            opacity: 0.8;
            transition: opacity 0.3s;
        }
        
        .login-footer a:hover {
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
        
        /* Efecto de carga simulada */
        .loading {
            display: none;
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 3;
            border-radius: 16px;
            justify-content: center;
            align-items: center;
        }
        
        .spinner {
            width: 40px;
            height: 40px;
            border: 4px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <!-- Partículas decorativas -->
    <div id="particles"></div>
    
    <div class="login-container">
        <!-- Efecto de carga -->
        <div class="loading" id="loading">
            <div class="spinner"></div>
        </div>
        
        <div class="login-header">
            <h1>Biblioteca Municipal</h1>
            <p>Sistema de Gestión de Préstamos</p>
        </div>
        
        <form class="login-form" id="loginForm">
            <div class="form-group">
                <label for="email">Correo Electrónico</label>
                <input type="email" id="email" placeholder="bibliotecario@municipal.com" required>
            </div>
            
            <div class="form-group">
                <label for="password">Contraseña</label>
                <input type="password" id="password" placeholder="????????" required>
            </div>
            
            <button type="submit" class="btn-login">Iniciar Sesión</button>
        </form>
        
        <div class="login-footer">
            <p>¿No tienes una cuenta? <a href="#">Contacta al administrador</a></p>
            <p><a href="#">¿Olvidaste tu contraseña?</a></p>
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
            
            // Simular envío de formulario
            const loginForm = document.getElementById('loginForm');
            const loading = document.getElementById('loading');
            
            loginForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Mostrar efecto de carga
                loading.style.display = 'flex';
                
                // Simular retraso de red
                setTimeout(() => {
                    loading.style.display = 'none';
                    
                    // Aquí normalmente iría la lógica de autenticación
                    alert('Formulario enviado (simulación)');
                }, 2000);
            });
        });
    </script>
</body>
</html>