package sena.adso.sistema_gestion_libros.filtro;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sena.adso.sistema_gestion_libros.modelo.Usuario;

/**
 * Filtro de seguridad para controlar el acceso a las páginas protegidas
 * según el rol del usuario autenticado (Bibliotecario o Lector)
 */
@WebFilter(filterName = "SeguridadFiltro", urlPatterns = {"/bibliotecario/*", "/lector/*"})
public class SeguridadFiltro implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No se requiere inicialización especial
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String requestURI = httpRequest.getRequestURI();
        
        // Verificar si el usuario está autenticado
        boolean isLoggedIn = (session != null && session.getAttribute("usuario") != null);
        boolean isBibliotecarioArea = requestURI.contains("/bibliotecario/");
        boolean isLectorArea = requestURI.contains("/lector/");
        
        if (isLoggedIn) {
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            String rol = usuario.getRol();
            
            // Verificar acceso según el rol
            if (isBibliotecarioArea && !"Bibliotecario".equals(rol)) {
                // Redirigir a la página de acceso denegado si un Lector intenta acceder al área de Bibliotecario
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/acceso-denegado.jsp");
                return;
            } else if (isLectorArea && !"Lector".equals(rol) && !"Bibliotecario".equals(rol)) {
                // Los bibliotecarios también pueden acceder al área de lectores
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/acceso-denegado.jsp");
                return;
            }
            
            // Verificar si debe cambiar contraseña temporal
            if (usuario.isPasswordTemporal() && !requestURI.contains("/cambiar-contraseña")) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/cambiar-contraseña.jsp");
                return;
            }
            
            // Si pasa las verificaciones, continuar con la cadena de filtros
            chain.doFilter(request, response);
        } else {
            // Si no está autenticado, redirigir al login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
        }
    }

    @Override
    public void destroy() {
        // No se requiere limpieza especial
    }
}