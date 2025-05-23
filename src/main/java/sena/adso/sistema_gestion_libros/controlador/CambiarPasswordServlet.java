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
 * Servlet que maneja el proceso de cambio de contraseña
 * Se utiliza tanto para el cambio obligatorio de contraseñas temporales
 * como para el cambio voluntario de contraseña
 */
@WebServlet(name = "CambiarPasswordServlet", urlPatterns = {"/cambiar-password"})
public class CambiarPasswordServlet extends HttpServlet {

    /**
     * Maneja las solicitudes GET al servlet de cambio de contraseña
     * Muestra el formulario de cambio de contraseña
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Verificar si hay una sesión activa
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Obtener el usuario de la sesión
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        // Pasar datos a la vista
        request.setAttribute("username", usuario.getUsername());
        request.setAttribute("passwordTemporal", usuario.isPasswordTemporal());
        
        // Mostrar formulario de cambio de contraseña
        request.getRequestDispatcher("/WEB-INF/cambiar-password.jsp").forward(request, response);
    }

    /**
     * Maneja las solicitudes POST al servlet de cambio de contraseña
     * Procesa el formulario de cambio de contraseña
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Verificar si hay una sesión activa
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Obtener el usuario de la sesión
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        // Recuperar parámetros del formulario
        String passwordActual = request.getParameter("passwordActual");
        String passwordNuevo = request.getParameter("passwordNuevo");
        String passwordConfirmar = request.getParameter("passwordConfirmar");
        
        String mensaje = "";
        String tipo = "";
        
        // Validar campos
        boolean camposValidos = true;
        
        // La contraseña actual solo es obligatoria si NO es una contraseña temporal
        if (!usuario.isPasswordTemporal() && (passwordActual == null || passwordActual.isEmpty())) {
            camposValidos = false;
        }
        
        // La nueva contraseña y la confirmación siempre son obligatorias
        if (passwordNuevo == null || passwordNuevo.isEmpty() ||
            passwordConfirmar == null || passwordConfirmar.isEmpty()) {
            camposValidos = false;
        }
        
        if (!camposValidos) {
            mensaje = "Todos los campos obligatorios deben ser completados";
            tipo = "danger";
            
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("tipo", tipo);
            request.setAttribute("username", usuario.getUsername());
            request.setAttribute("passwordTemporal", usuario.isPasswordTemporal());
            request.getRequestDispatcher("/WEB-INF/cambiar-password.jsp").forward(request, response);
            return;
        }
        
        // Verificar que la contraseña actual sea correcta solo si no es una contraseña temporal
        if (!usuario.isPasswordTemporal() && passwordActual != null && !passwordActual.equals(usuario.getPassword())) {
            mensaje = "La contraseña actual es incorrecta";
            tipo = "danger";
            
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("tipo", tipo);
            request.setAttribute("username", usuario.getUsername());
            request.setAttribute("passwordTemporal", usuario.isPasswordTemporal());
            request.getRequestDispatcher("/WEB-INF/cambiar-password.jsp").forward(request, response);
            return;
        }
        
        // Verificar que las nuevas contraseñas coincidan
        if (!passwordNuevo.equals(passwordConfirmar)) {
            mensaje = "Las nuevas contraseñas no coinciden";
            tipo = "danger";
            
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("tipo", tipo);
            request.setAttribute("username", usuario.getUsername());
            request.setAttribute("passwordTemporal", usuario.isPasswordTemporal());
            request.getRequestDispatcher("/WEB-INF/cambiar-password.jsp").forward(request, response);
            return;
        }
        
        // Verificar longitud mínima de la contraseña
        if (passwordNuevo.length() < 6) {
            mensaje = "La contraseña debe tener al menos 6 caracteres";
            tipo = "danger";
            
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("tipo", tipo);
            request.setAttribute("username", usuario.getUsername());
            request.setAttribute("passwordTemporal", usuario.isPasswordTemporal());
            request.getRequestDispatcher("/WEB-INF/cambiar-password.jsp").forward(request, response);
            return;
        }
        
        // Actualizar la contraseña en la base de datos
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        boolean actualizado = usuarioDAO.actualizarPassword(usuario.getEmail(), passwordNuevo, false);
        
        if (actualizado) {
            // Actualizar el usuario en la sesión
            usuario.setPassword(passwordNuevo);
            usuario.setPasswordTemporal(false);
            session.setAttribute("usuario", usuario);
            
            // Redirigir según el rol (ya no es contraseña temporal)
            String rol = usuario.getRol();
            String destino = "/login";
            
            if ("Bibliotecario".equals(rol)) {
                destino = "/bibliotecario/lectores";
            } else if ("Lector".equals(rol)) {
                destino = "/lector/lectores";
            }
            
            response.sendRedirect(request.getContextPath() + destino);
        } else {
            mensaje = "Error al actualizar la contraseña. Por favor, intente nuevamente";
            tipo = "danger";
            
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("tipo", tipo);
            request.setAttribute("username", usuario.getUsername());
            request.setAttribute("passwordTemporal", usuario.isPasswordTemporal());
            request.getRequestDispatcher("/WEB-INF/cambiar-password.jsp").forward(request, response);
        }
    }
}