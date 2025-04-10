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

    public Loan(int id, Libro libro, String nombrePrestatario, String idPrestatario, Date fechaPrestamo, Date fechaLimite) {
        this.id = id;
        this.libro = libro;
        this.nombrePrestatario = nombrePrestatario;
        this.idPrestatario = idPrestatario;
        this.fechaPrestamo = fechaPrestamo;
        this.fechaLimite = fechaLimite;
        this.fechaDevolucion = null;

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

    public void returnLibro(Date fechaDevolucion) {
        this.fechaDevolucion = fechaDevolucion;
        this.libro.setDisponible(true);
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
                "\nFecha del préstamo: " + formatoFecha.format(fechaPrestamo) +
                "\nFecha límite: " + formatoFecha.format(fechaLimite) +
                "\nFecha de devolución: " + (fechaDevolucion != null ? formatoFecha.format(fechaDevolucion) : "No devuelto") +
                "\nEstado: " + (isActivo() ? (estaVencido() ? "Vencido" : "Activo") : "Devuelto");
    }
}
