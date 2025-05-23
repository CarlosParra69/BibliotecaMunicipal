package sena.adso.sistema_gestion_libros.modelo;

import java.sql.Timestamp;

/**
 * Clase que representa un lector en el sistema de biblioteca
 */
public class Lector {
    private int id;
    private String cedula;
    private String nombre;
    private String direccion;
    private String email;
    private Timestamp fechaRegistro;
    
    // Constructores
    public Lector() {
    }
    
    public Lector(int id, String cedula, String nombre, String direccion, String email) {
        this.id = id;
        this.cedula = cedula;
        this.nombre = nombre;
        this.direccion = direccion;
        this.email = email;
    }
    
    public Lector(String cedula, String nombre, String direccion, String email) {
        this.cedula = cedula;
        this.nombre = nombre;
        this.direccion = direccion;
        this.email = email;
    }
    
    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCedula() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }
    
    @Override
    public String toString() {
        return "Lector{" + "id=" + id + ", cedula=" + cedula + ", nombre=" + nombre + ", email=" + email + "}";
    }
}