package sena.adso.sistema_gestion_libros.controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sena.adso.sistema_gestion_libros.dao.UsuarioDAO;
import sena.adso.sistema_gestion_libros.modelo.Usuario;

/**
 * Servlet que maneja el proceso de inicio de sesión
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    /**
     * Maneja las solicitudes GET al servlet de login
     * Redirige a la página de inicio si ya hay una sesión activa
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Si ya hay una sesión activa, redirigir según el rol
        if (session != null && session.getAttribute("usuario") != null) {
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            redirigirSegunRol(usuario, request, response);
        } else {
            // Si no hay sesión, mostrar la página de login
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    /**
     * Maneja las solicitudes POST al servlet de login
     * Procesa el formulario de inicio de sesión
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String mensaje;
        
        // Validar que se hayan proporcionado credenciales
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            mensaje = "Por favor, ingrese usuario y contraseña";
            request.setAttribute("mensaje", mensaje);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        // Intentar autenticar al usuario
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = usuarioDAO.validarUsuario(username, password);
        
        if (usuario != null) {
            // Autenticación exitosa, crear sesión
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);
            session.setMaxInactiveInterval(30 * 60); // 30 minutos de inactividad
            
            // Redirigir según el rol del usuario
            redirigirSegunRol(usuario, request, response);
        } else {
            // Autenticación fallida
            mensaje = "Usuario o contraseña incorrectos";
            request.setAttribute("mensaje", mensaje);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
    
    /**
     * Redirige al usuario a la página correspondiente según su rol
     */
    private void redirigirSegunRol(Usuario usuario, HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        // Si el usuario tiene una contraseña temporal, redirigir al cambio obligatorio
        if (usuario.isPasswordTemporal()) {
            response.sendRedirect(request.getContextPath() + "/cambiar-password");
            return;
        }
        
        // Redirigir según el rol
        if ("Bibliotecario".equals(usuario.getRol())) {
            // Redirigir al bibliotecario al CRUD de lectores
            response.sendRedirect(request.getContextPath() + "/bibliotecario/lectores");
        } else if ("Lector".equals(usuario.getRol())) {
            // Redirigir al lector a la vista de solo lectura
            response.sendRedirect(request.getContextPath() + "/lector/lectores");
        } else {
            // Rol no reconocido, cerrar sesión por seguridad
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
}