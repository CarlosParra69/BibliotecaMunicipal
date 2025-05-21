package sena.adso.sistema_gestion_libros.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Clase utilitaria para gestionar la conexión a la base de datos MySQL
 * para el Sistema de Gestión de Libros
 */
public class ConexionBD {
    // Parámetros de conexión actualizados para biblioteca_db
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/biblioteca_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";
    
    /**
     * Establece y retorna una conexión a la base de datos
     * @return Objeto Connection con la conexión establecida
     * @throws SQLException si ocurre un error al conectar
     */
    public static Connection getConnection() throws SQLException {
        try {
            // Registrar el driver de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        } catch (ClassNotFoundException ex) {
            throw new SQLException("Error al cargar el driver de MySQL", ex);
        }
    }
    
    /**
     * Cierra una conexión a la base de datos
     * @param conn Conexión a cerrar
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                System.err.println("[ERROR] Al cerrar la conexión: " + ex.getMessage());
                ex.printStackTrace();
            }
        }
    }
    
    /**
     * Método para verificar la conexión con la base de datos
     * @return true si la conexión es exitosa, false si hay error
     */
    public static boolean verificarConexion() {
        try (Connection conn = getConnection()) {
            return conn.isValid(2); // Verifica si la conexión es válida dentro de 2 segundos
        } catch (SQLException ex) {
            System.err.println("[ERROR] No se pudo establecer conexión: " + ex.getMessage());
            return false;
        }
    }
}