package sena.adso.sistema_gestion_libros.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Loan {
    private int id;
    private Libro libro;
    private String nombrePrestatario;
    private String idPrestatario;
    private Date fechaPrestamo;
    private Date fechaLimite;
    private Date fechaDevolucion;
    private String estadoDevolucion;
    private String observaciones;

    public Loan(int id, Libro libro, String nombrePrestatario, String idPrestatario, Date fechaPrestamo, Date fechaLimite) {
        this.id = id;
        this.libro = libro;
        this.nombrePrestatario = nombrePrestatario;
        this.idPrestatario = idPrestatario;
        this.fechaPrestamo = fechaPrestamo;
        this.fechaLimite = fechaLimite;
        this.fechaDevolucion = null;
        this.estadoDevolucion = null;
        this.observaciones = "";

        libro.setDisponible(false);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Libro getLibro() {
        return libro;
    }

    public void setLibro(Libro libro) {
        this.libro = libro;
    }

    public String getNombrePrestatario() {
        return nombrePrestatario;
    }

    public void setNombrePrestatario(String nombrePrestatario) {
        this.nombrePrestatario = nombrePrestatario;
    }

    public String getIdPrestatario() {
        return idPrestatario;
    }

    public void setIdPrestatario(String idPrestatario) {
        this.idPrestatario = idPrestatario;
    }

    public Date getFechaPrestamo() {
        return fechaPrestamo;
    }

    public void setFechaPrestamo(Date fechaPrestamo) {
        this.fechaPrestamo = fechaPrestamo;
    }

    public Date getFechaLimite() {
        return fechaLimite;
    }

    public void setFechaLimite(Date fechaLimite) {
        this.fechaLimite = fechaLimite;
    }

    public Date getFechaDevolucion() {
        return fechaDevolucion;
    }

    public void setFechaDevolucion(Date fechaDevolucion) {
        this.fechaDevolucion = fechaDevolucion;
    }

    public String getEstadoDevolucion() {
        return estadoDevolucion;
    }

    public void setEstadoDevolucion(String estadoDevolucion) {
        this.estadoDevolucion = estadoDevolucion;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public void returnLibro(Date fechaDevolucion, String estadoDevolucion, String observaciones) {
        this.fechaDevolucion = fechaDevolucion;
        this.estadoDevolucion = estadoDevolucion;
        this.observaciones = observaciones;
        this.libro.setDisponible(true);
        
        if ("perdido".equalsIgnoreCase(estadoDevolucion)) {
            this.libro.setDisponible(false);
        }
    }

    public void returnLibro(Date fechaDevolucion) {
        returnLibro(fechaDevolucion, "bueno", "");
    }

    public boolean isActivo() {
        return fechaDevolucion == null;
    }

    public boolean estaVencido() {
        if (!isActivo()) {
            return false;
        }
        Date hoy = new Date();
        return hoy.after(fechaLimite);
    }

    @Override
    public String toString() {
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        return "Préstamo ID: " + id +
                "\nLibro: " + libro.getTitulo() +
                "\nPrestatario: " + nombrePrestatario + " (" + idPrestatario + ")" +
                "\nFecha del prestamo: " + formatoFecha.format(fechaPrestamo) +
                "\nFecha limite: " + formatoFecha.format(fechaLimite) +
                "\nFecha de devolucion: " + (fechaDevolucion != null ? formatoFecha.format(fechaDevolucion) : "No devuelto") +
                "\nEstado: " + (isActivo() ? (estaVencido() ? "Vencido" : "Activo") : "Devuelto");
    }
}
