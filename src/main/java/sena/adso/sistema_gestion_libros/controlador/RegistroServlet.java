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
 * Servlet que maneja el proceso de registro de usuarios
 */
@WebServlet(name = "RegistroServlet", urlPatterns = {"/registro"})
public class RegistroServlet extends HttpServlet {

    /**
     * Maneja las solicitudes GET al servlet de registro
     * Muestra el formulario de registro
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/registro.jsp").forward(request, response);
    }

    /**
     * Maneja las solicitudes POST al servlet de registro
     * Procesa el formulario de registro de usuario
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String rol = request.getParameter("rol");
        String mensaje = "";
        String tipo = "danger"; // Valor por defecto
        
        // Validar campos obligatorios
        if (username == null || username.isEmpty() || 
            email == null || email.isEmpty() || 
            rol == null || rol.isEmpty()) {
            mensaje = "Por favor, complete todos los campos del formulario";
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("tipo", tipo);
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
            return;
        }
        
        // Validar rol
        if (!"Bibliotecario".equals(rol) && !"Lector".equals(rol)) {
            mensaje = "El rol seleccionado no es válido";
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("tipo", tipo);
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
            return;
        }
        
        // Verificar disponibilidad de username
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        if (usuarioDAO.existeUsername(username)) {
            mensaje = "El nombre de usuario ya está en uso";
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("tipo", tipo);
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
            return;
        }
        
        // Verificar disponibilidad de email
        if (usuarioDAO.buscarPorEmail(email) != null) {
            mensaje = "El correo electrónico ya está registrado";
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("tipo", tipo);
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
            return;
        }
        
        // Generar contraseña temporal segura
        String password = EmailUtil.generarPasswordTemporal();
        
        // Crear y configurar nuevo usuario
        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setUsername(username);
        nuevoUsuario.setPassword(password);
        nuevoUsuario.setEmail(email);
        nuevoUsuario.setRol(rol);
        nuevoUsuario.setPasswordTemporal(true); // Marcar como contraseña temporal
        
        // Registrar usuario
        if (usuarioDAO.registrarUsuario(nuevoUsuario)) {
            // Enviar credenciales por correo
            if (EmailUtil.enviarCredencialesRegistro(email, username, password, rol)) {
                mensaje = "Registro exitoso. Se han enviado las credenciales a su correo";
                tipo = "success";
            } else {
                mensaje = "Registro exitoso, pero no se pudo enviar el correo con las credenciales";
                tipo = "warning";
            }
        } else {
            mensaje = "Error al registrar el usuario. Por favor, intente nuevamente";
        }
        
        request.setAttribute("mensaje", mensaje);
        request.setAttribute("tipo", tipo);
        request.getRequestDispatcher("/registro.jsp").forward(request, response);
    }
}