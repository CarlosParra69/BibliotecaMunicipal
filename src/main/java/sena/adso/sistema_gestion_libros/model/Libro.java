package sena.adso.sistema_gestion_libros.model;

public abstract class Libro {
    
    private String isbn;
    private String titulo;
    private String autor;
    private String tipo;
    private int fechaPublicacion;
    private boolean disponible;

    public Libro(String isbn, String titulo, String autor, String tipo, int fechaPublicacion, boolean disponible) {
        this.isbn = isbn;
        this.titulo = titulo;
        this.autor = autor;
        this.tipo = tipo;
        this.fechaPublicacion = fechaPublicacion;
        this.disponible = disponible;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getAutor() {
        return autor;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public int getFechaPublicacion() {
        return fechaPublicacion;
    }

    public void setFechaPublicacion(int fechaPublicacion) {
        this.fechaPublicacion = fechaPublicacion;
    }

    public boolean isDisponible() {
        return disponible;
    }

    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }
    
    public abstract String getDescription();

    @Override
    public String toString() {
        return "ISBN: " + isbn + ", TITULO, " + titulo + ", AUTOR: " + autor + 
                ", TIPO: " + tipo + ", FECHA PUBLICACION: " + fechaPublicacion + ", DISPONIBLE: " + (disponible ? "YES" : "NO");
    }
    
    

}