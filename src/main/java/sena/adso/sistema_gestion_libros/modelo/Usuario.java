package sena.adso.sistema_gestion_libros.modelo;

import java.sql.Timestamp;

/**
 * Clase que representa un usuario del sistema
 */
public class Usuario {
    private int id;
    private String username;
    private String password;
    private String email;
    private String rol;
    private Timestamp fechaRegistro;
    private boolean passwordTemporal = false; // Indica si la contraseña es temporal y debe ser cambiada
    
    // Constructores
    public Usuario() {
    }
    
    public Usuario(int id, String username, String password, String email, String rol) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.rol = rol;
        this.passwordTemporal = false;
    }
    
    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }
    
    public boolean isPasswordTemporal() {
        return passwordTemporal;
    }
    
    public void setPasswordTemporal(boolean passwordTemporal) {
        this.passwordTemporal = passwordTemporal;
    }
    
    @Override
    public String toString() {
        return "Usuario{" + "id=" + id + ", username=" + username + ", email=" + email + ", rol=" + rol + ", passwordTemporal=" + passwordTemporal + "}";
    }
}