package sena.adso.sistema_gestion_libros.controlador;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sena.adso.sistema_gestion_libros.dao.LectorDAO;
import sena.adso.sistema_gestion_libros.modelo.Lector;
import sena.adso.sistema_gestion_libros.modelo.Usuario;

/**
 * Servlet que maneja las operaciones CRUD para lectores
 * Implementa diferentes comportamientos según el rol del usuario
 */
@WebServlet(name = "LectorServlet", urlPatterns = {"/bibliotecario/lectores", "/lector/lectores"})
public class LectorServlet extends HttpServlet {

    private LectorDAO lectorDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        lectorDAO = new LectorDAO();
    }

    /**
     * Maneja las solicitudes GET al servlet de lectores
     * Muestra la lista de lectores según el rol del usuario
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String accion = request.getParameter("accion");
        
        if (accion == null) {
            accion = "listar";
        }
        
        switch (accion) {
            case "nuevo":
                if ("Bibliotecario".equals(usuario.getRol())) {
                    mostrarFormulario(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/acceso-denegado.jsp");
                }
                break;
            case "editar":
                if ("Bibliotecario".equals(usuario.getRol())) {
                    cargarLector(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/acceso-denegado.jsp");
                }
                break;
            case "eliminar":
                if ("Bibliotecario".equals(usuario.getRol())) {
                    eliminarLector(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/acceso-denegado.jsp");
                }
                break;
            default:
                listarLectores(request, response, usuario.getRol());
                break;
        }
    }

    /**
     * Maneja las solicitudes POST al servlet de lectores
     * Procesa los formularios de creación y edición de lectores
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        // Solo los bibliotecarios pueden crear o editar lectores
        if (!"Bibliotecario".equals(usuario.getRol())) {
            response.sendRedirect(request.getContextPath() + "/acceso-denegado.jsp");
            return;
        }
        
        String accion = request.getParameter("accion");
        
        if ("guardar".equals(accion)) {
            guardarLector(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/bibliotecario/lectores");
        }
    }
    
    /**
     * Muestra la lista de lectores
     */
    private void listarLectores(HttpServletRequest request, HttpServletResponse response, String rol) 
            throws ServletException, IOException {
        List<Lector> lectores = lectorDAO.listarTodos();
        request.setAttribute("lectores", lectores);
        request.setAttribute("rol", rol);
        
        String vista = "Bibliotecario".equals(rol) ? "/WEB-INF/bibliotecario/lectores.jsp" : "/WEB-INF/lector/lectores.jsp";
        request.getRequestDispatcher(vista).forward(request, response);
    }
    
    /**
     * Muestra el formulario para crear un nuevo lector
     */
    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/bibliotecario/formulario-lector.jsp").forward(request, response);
    }
    
    /**
     * Carga los datos de un lector para edición
     */
    private void cargarLector(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Lector lector = lectorDAO.buscarPorId(id);
            
            if (lector != null) {
                request.setAttribute("lector", lector);
                request.getRequestDispatcher("/WEB-INF/bibliotecario/formulario-lector.jsp").forward(request, response);
            } else {
                request.setAttribute("mensaje", "Lector no encontrado");
                request.setAttribute("tipo", "danger");
                listarLectores(request, response, "Bibliotecario");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("mensaje", "ID de lector inválido");
            request.setAttribute("tipo", "danger");
            listarLectores(request, response, "Bibliotecario");
        }
    }
    
    /**
     * Guarda o actualiza un lector
     */
    private void guardarLector(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String cedula = request.getParameter("cedula");
        String nombre = request.getParameter("nombre");
        String direccion = request.getParameter("direccion");
        String email = request.getParameter("email");
        
        // Validar campos obligatorios
        if (cedula == null || cedula.isEmpty() || nombre == null || nombre.isEmpty() ||
                direccion == null || direccion.isEmpty() || email == null || email.isEmpty()) {
            request.setAttribute("mensaje", "Todos los campos son obligatorios");
            request.setAttribute("tipo", "danger");
            request.getRequestDispatcher("/WEB-INF/bibliotecario/formulario-lector.jsp").forward(request, response);
            return;
        }
        
        Lector lector = new Lector();
        lector.setCedula(cedula);
        lector.setNombre(nombre);
        lector.setDireccion(direccion);
        lector.setEmail(email);
        
        boolean resultado;
        String mensaje;
        
        // Determinar si es inserción o actualización
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                lector.setId(id);
                resultado = lectorDAO.actualizar(lector);
                mensaje = resultado ? "Lector actualizado correctamente" : "Error al actualizar el lector";
            } catch (NumberFormatException e) {
                resultado = false;
                mensaje = "ID de lector inválido";
            }
        } else {
            // Verificar si ya existe la cédula o el email
            if (lectorDAO.existeCedula(cedula)) {
                request.setAttribute("mensaje", "Ya existe un lector con esa cédula");
                request.setAttribute("tipo", "danger");
                request.getRequestDispatcher("/WEB-INF/bibliotecario/formulario-lector.jsp").forward(request, response);
                return;
            }
            
            if (lectorDAO.existeEmail(email)) {
                request.setAttribute("mensaje", "Ya existe un lector con ese email");
                request.setAttribute("tipo", "danger");
                request.getRequestDispatcher("/WEB-INF/bibliotecario/formulario-lector.jsp").forward(request, response);
                return;
            }
            
            resultado = lectorDAO.insertar(lector);
            mensaje = resultado ? "Lector registrado correctamente" : "Error al registrar el lector";
        }
        
        request.setAttribute("mensaje", mensaje);
        request.setAttribute("tipo", resultado ? "success" : "danger");
        listarLectores(request, response, "Bibliotecario");
    }
    
    /**
     * Elimina un lector
     */
    private void eliminarLector(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean resultado = lectorDAO.eliminar(id);
            
            request.setAttribute("mensaje", resultado ? "Lector eliminado correctamente" : "Error al eliminar el lector");
            request.setAttribute("tipo", resultado ? "success" : "danger");
        } catch (NumberFormatException e) {
            request.setAttribute("mensaje", "ID de lector inválido");
            request.setAttribute("tipo", "danger");
        }
        
        listarLectores(request, response, "Bibliotecario");
    }
}