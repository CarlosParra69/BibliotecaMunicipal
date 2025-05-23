package sena.adso.sistema_gestion_libros.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import sena.adso.sistema_gestion_libros.modelo.Usuario;
import sena.adso.sistema_gestion_libros.util.ConexionBD;

/**
 * Clase DAO para gestionar las operaciones de base de datos relacionadas con usuarios
 */
public class UsuarioDAO {
    
    /**
     * Valida las credenciales de un usuario para el inicio de sesión
     * @param username Nombre de usuario
     * @param password Contraseña
     * @return Objeto Usuario si las credenciales son válidas, null en caso contrario
     */
    public Usuario validarUsuario(String username, String password) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Usuario usuario = null;
        
        try {
            conn = ConexionBD.getConnection();
            String sql = "SELECT * FROM usuarios WHERE username = ? AND password = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setUsername(rs.getString("username"));
                usuario.setPassword(rs.getString("password"));
                usuario.setEmail(rs.getString("email"));
                usuario.setRol(rs.getString("rol"));
                usuario.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                
                // Obtener el estado de password_temporal
                try {
                    usuario.setPasswordTemporal(rs.getBoolean("password_temporal"));
                    System.out.println("Password temporal para " + username + ": " + rs.getBoolean("password_temporal"));
                } catch (SQLException ex) {
                    // La columna no existe, usar valor por defecto (false)
                    System.out.println("Columna password_temporal no encontrada en validarUsuario: " + ex.getMessage());
                }
            }
        } catch (SQLException ex) {
            System.out.println("Error al validar usuario: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) ConexionBD.closeConnection(conn);
            } catch (SQLException ex) {
                System.out.println("Error al cerrar recursos: " + ex.getMessage());
            }
        }
        
        return usuario;
    }
    
    /**
     * Busca un usuario por su dirección de correo electrónico
     * @param email Correo electrónico a buscar
     * @return Objeto Usuario si se encuentra, null en caso contrario
     */
    public Usuario buscarPorEmail(String email) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Usuario usuario = null;
        
        try {
            conn = ConexionBD.getConnection();
            String sql = "SELECT * FROM usuarios WHERE email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setUsername(rs.getString("username"));
                usuario.setPassword(rs.getString("password"));
                usuario.setEmail(rs.getString("email"));
                usuario.setRol(rs.getString("rol"));
                usuario.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                
                // Obtener el estado de password_temporal
                try {
                    usuario.setPasswordTemporal(rs.getBoolean("password_temporal"));
                    System.out.println("Password temporal para " + email + ": " + rs.getBoolean("password_temporal"));
                } catch (SQLException ex) {
                    // La columna no existe, usar valor por defecto (false)
                    System.out.println("Columna password_temporal no encontrada en buscarPorEmail: " + ex.getMessage());
                }
            }
        } catch (SQLException ex) {
            System.out.println("Error al buscar usuario por email: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) ConexionBD.closeConnection(conn);
            } catch (SQLException ex) {
                System.out.println("Error al cerrar recursos: " + ex.getMessage());
            }
        }
        
        return usuario;
    }
    
    /**
     * Actualiza la contraseña de un usuario
     * @param email Correo electrónico del usuario
     * @param nuevaPassword Nueva contraseña
     * @return true si la actualización fue exitosa, false en caso contrario
     */
    public boolean actualizarPassword(String email, String nuevaPassword) {
        return actualizarPassword(email, nuevaPassword, true);
    }
    
    /**
     * Actualiza la contraseña de un usuario y marca si es temporal
     * @param email Correo electrónico del usuario
     * @param nuevaPassword Nueva contraseña
     * @param esTemporal Indica si la contraseña es temporal
     * @return true si la actualización fue exitosa, false en caso contrario
     */
    public boolean actualizarPassword(String email, String nuevaPassword, boolean esTemporal) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean resultado = false;
        
        try {
            conn = ConexionBD.getConnection();
            String sql = "UPDATE usuarios SET password = ?, password_temporal = ? WHERE email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, nuevaPassword);
            stmt.setBoolean(2, esTemporal);
            stmt.setString(3, email);
            
            int filasAfectadas = stmt.executeUpdate();
            resultado = (filasAfectadas > 0);
            
            System.out.println("Actualizada contraseña para " + email + ", es temporal: " + esTemporal + ", resultado: " + resultado);
        } catch (SQLException ex) {
            System.out.println("Error al actualizar contraseña: " + ex.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) ConexionBD.closeConnection(conn);
            } catch (SQLException ex) {
                System.out.println("Error al cerrar recursos: " + ex.getMessage());
            }
        }
        
        return resultado;
    }
    
    /**
     * Registra un nuevo usuario en el sistema
     * @param usuario Objeto Usuario con los datos del nuevo usuario
     * @return true si el registro fue exitoso, false en caso contrario
     */
    public boolean registrarUsuario(Usuario usuario) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean resultado = false;
        
        try {
            conn = ConexionBD.getConnection();
            String sql = "INSERT INTO usuarios (username, password, email, rol, password_temporal) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, usuario.getUsername());
            stmt.setString(2, usuario.getPassword());
            stmt.setString(3, usuario.getEmail());
            stmt.setString(4, usuario.getRol());
            stmt.setBoolean(5, usuario.isPasswordTemporal());
            
            int filasAfectadas = stmt.executeUpdate();
            resultado = (filasAfectadas > 0);
        } catch (SQLException ex) {
            System.out.println("Error al registrar usuario: " + ex.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) ConexionBD.closeConnection(conn);
            } catch (SQLException ex) {
                System.out.println("Error al cerrar recursos: " + ex.getMessage());
            }
        }
        
        return resultado;
    }
    
    /**
     * Verifica si un nombre de usuario ya existe en la base de datos
     * @param username Nombre de usuario a verificar
     * @return true si el usuario existe, false en caso contrario
     */
    public boolean existeUsername(String username) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean existe = false;
        
        try {
            conn = ConexionBD.getConnection();
            String sql = "SELECT COUNT(*) FROM usuarios WHERE username = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                existe = rs.getInt(1) > 0;
            }
        } catch (SQLException ex) {
            System.out.println("Error al verificar existencia de usuario: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) ConexionBD.closeConnection(conn);
            } catch (SQLException ex) {
                System.out.println("Error al cerrar recursos: " + ex.getMessage());
            }
        }
        
        return existe;
    }
}