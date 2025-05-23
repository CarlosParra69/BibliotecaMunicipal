package sena.adso.sistema_gestion_libros.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import sena.adso.sistema_gestion_libros.modelo.Lector;
import sena.adso.sistema_gestion_libros.util.ConexionBD;

/**
 * Clase DAO para gestionar las operaciones CRUD de lectores en la base de datos
 */
public class LectorDAO {
    
    /**
     * Obtiene todos los lectores registrados en la base de datos
     * @return Lista de objetos Lector
     */
    public List<Lector> listarTodos() {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<Lector> listaLectores = new ArrayList<>();
        
        try {
            conn = ConexionBD.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM lectores ORDER BY nombre");
            
            while (rs.next()) {
                Lector lector = new Lector();
                lector.setId(rs.getInt("id"));
                lector.setCedula(rs.getString("cedula"));
                lector.setNombre(rs.getString("nombre"));
                lector.setDireccion(rs.getString("direccion"));
                lector.setEmail(rs.getString("email"));
                lector.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                
                listaLectores.add(lector);
            }
        } catch (SQLException ex) {
            System.out.println("Error al listar lectores: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) ConexionBD.closeConnection(conn);
            } catch (SQLException ex) {
                System.out.println("Error al cerrar recursos: " + ex.getMessage());
            }
        }
        
        return listaLectores;
    }
    
    /**
     * Busca un lector por su ID
     * @param id ID del lector a buscar
     * @return Objeto Lector si se encuentra, null en caso contrario
     */
    public Lector buscarPorId(int id) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Lector lector = null;
        
        try {
            conn = ConexionBD.getConnection();
            String sql = "SELECT * FROM lectores WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                lector = new Lector();
                lector.setId(rs.getInt("id"));
                lector.setCedula(rs.getString("cedula"));
                lector.setNombre(rs.getString("nombre"));
                lector.setDireccion(rs.getString("direccion"));
                lector.setEmail(rs.getString("email"));
                lector.setFechaRegistro(rs.getTimestamp("fecha_registro"));
            }
        } catch (SQLException ex) {
            System.out.println("Error al buscar lector por ID: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) ConexionBD.closeConnection(conn);
            } catch (SQLException ex) {
                System.out.println("Error al cerrar recursos: " + ex.getMessage());
            }
        }
        
        return lector;
    }
    
    /**
     * Inserta un nuevo lector en la base de datos
     * @param lector Objeto Lector con los datos a insertar
     * @return true si la inserción fue exitosa, false en caso contrario
     */
    public boolean insertar(Lector lector) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean resultado = false;
        
        try {
            conn = ConexionBD.getConnection();
            String sql = "INSERT INTO lectores (cedula, nombre, direccion, email) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, lector.getCedula());
            stmt.setString(2, lector.getNombre());
            stmt.setString(3, lector.getDireccion());
            stmt.setString(4, lector.getEmail());
            
            int filasAfectadas = stmt.executeUpdate();
            resultado = (filasAfectadas > 0);
        } catch (SQLException ex) {
            System.out.println("Error al insertar lector: " + ex.getMessage());
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
     * Actualiza los datos de un lector existente
     * @param lector Objeto Lector con los datos actualizados
     * @return true si la actualización fue exitosa, false en caso contrario
     */
    public boolean actualizar(Lector lector) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean resultado = false;
        
        try {
            conn = ConexionBD.getConnection();
            String sql = "UPDATE lectores SET cedula = ?, nombre = ?, direccion = ?, email = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, lector.getCedula());
            stmt.setString(2, lector.getNombre());
            stmt.setString(3, lector.getDireccion());
            stmt.setString(4, lector.getEmail());
            stmt.setInt(5, lector.getId());
            
            int filasAfectadas = stmt.executeUpdate();
            resultado = (filasAfectadas > 0);
        } catch (SQLException ex) {
            System.out.println("Error al actualizar lector: " + ex.getMessage());
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
     * Elimina un lector de la base de datos
     * @param id ID del lector a eliminar
     * @return true si la eliminación fue exitosa, false en caso contrario
     */
    public boolean eliminar(int id) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean resultado = false;
        
        try {
            conn = ConexionBD.getConnection();
            String sql = "DELETE FROM lectores WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            
            int filasAfectadas = stmt.executeUpdate();
            resultado = (filasAfectadas > 0);
        } catch (SQLException ex) {
            System.out.println("Error al eliminar lector: " + ex.getMessage());
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
     * Verifica si ya existe un lector con la cédula especificada
     * @param cedula Cédula a verificar
     * @return true si ya existe, false en caso contrario
     */
    public boolean existeCedula(String cedula) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean existe = false;
        
        try {
            conn = ConexionBD.getConnection();
            String sql = "SELECT COUNT(*) FROM lectores WHERE cedula = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, cedula);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                existe = (rs.getInt(1) > 0);
            }
        } catch (SQLException ex) {
            System.out.println("Error al verificar cédula: " + ex.getMessage());
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
    
    /**
     * Verifica si ya existe un lector con el email especificado
     * @param email Email a verificar
     * @return true si ya existe, false en caso contrario
     */
    public boolean existeEmail(String email) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean existe = false;
        
        try {
            conn = ConexionBD.getConnection();
            String sql = "SELECT COUNT(*) FROM lectores WHERE email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                existe = (rs.getInt(1) > 0);
            }
        } catch (SQLException ex) {
            System.out.println("Error al verificar email: " + ex.getMessage());
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