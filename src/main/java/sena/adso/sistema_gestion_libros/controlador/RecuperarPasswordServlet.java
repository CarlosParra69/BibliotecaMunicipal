package sena.adso.sistema_gestion_libros.controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sena.adso.sistema_gestion_libros.dao.UsuarioDAO;
import sena.adso.sistema_gestion_libros.modelo.Usuario;
import sena.adso.sistema_gestion_libros.util.EmailUtil;

/**
 * Servlet que maneja el proceso de recuperación de contraseña
 */
@WebServlet(name = "RecuperarPasswordServlet", urlPatterns = {"/recuperar-password"})
public class RecuperarPasswordServlet extends HttpServlet {

    /**
     * Maneja las solicitudes GET al servlet de recuperación
     * Muestra el formulario de recuperación de contraseña
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/recuperar-password.jsp").forward(request, response);
    }

    /**
     * Maneja las solicitudes POST al servlet de recuperación
     * Procesa el formulario de recuperación de contraseña
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String mensaje = "";
        String tipo = "info"; // Tipo por defecto
        
        // Validar que se haya proporcionado un email
        if (email == null || email.isEmpty()) {
            mensaje = "Por favor, ingrese su dirección de correo electrónico";
            tipo = "danger";
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("tipo", tipo);
            request.getRequestDispatcher("/recuperar-password.jsp").forward(request, response);
            return;
        }
        
        // Buscar el usuario por email
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = usuarioDAO.buscarPorEmail(email);
        
        if (usuario != null) {
            // Generar nueva contraseña temporal
            String nuevaPassword = EmailUtil.generarPasswordTemporal();
            
            // Actualizar la contraseña en la base de datos y marcarla como temporal
            boolean actualizado = usuarioDAO.actualizarPassword(email, nuevaPassword, true);
            
            if (actualizado) {
                // Enviar correo con la nueva contraseña
                boolean enviado = EmailUtil.enviarCorreoRecuperacion(email, nuevaPassword);
                
                if (enviado) {
                    mensaje = "Se ha enviado un correo con su nueva contraseña temporal";
                    tipo = "success";
                    
                    // Log para depuración (solo en desarrollo)
                    System.out.println("Contraseña temporal generada para " + email);
                } else {
                    mensaje = "Error al enviar el correo. Por favor, contacte al administrador";
                    tipo = "danger";
                }
            } else {
                mensaje = "Error al actualizar la contraseña. Por favor, intente nuevamente";
                tipo = "danger";
            }
        }
        
        // Mensaje genérico por seguridad (no revelar si el email existe)
        if (mensaje.isEmpty()) {
            mensaje = "Si su correo está registrado, recibirá instrucciones para recuperar su contraseña";
        }
        
        request.setAttribute("mensaje", mensaje);
        request.setAttribute("tipo", tipo);
        request.getRequestDispatcher("/recuperar-password.jsp").forward(request, response);
    }
}