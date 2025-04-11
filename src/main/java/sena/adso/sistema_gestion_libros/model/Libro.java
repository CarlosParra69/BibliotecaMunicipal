package sena.adso.sistema_gestion_libros.model;

public abstract class Libro {
    private String isbn;
    private String titulo;
    private String autor;
    private String tipo;
    private String añoPublicacion;
    private boolean disponible;

    public Libro(String isbn, String titulo, String autor, String tipo, String añoPublicacion) {
        this.isbn = isbn;
        this.titulo = titulo;
        this.autor = autor;
        this.tipo = tipo;
        // Validamos que el año no sea nulo ni vacío
        if (añoPublicacion != null && !añoPublicacion.trim().isEmpty()) {
            this.añoPublicacion = añoPublicacion.trim();
        } else {
            this.añoPublicacion = "Sin información";
        }
        this.disponible = true; // Por defecto, el libro está disponible
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

    public String getAñoPublicacion() {
        return añoPublicacion;
    }

    public void setAñoPublicacion(String añoPublicacion) {
        // Validamos que el año no sea nulo ni vacío
        if (añoPublicacion != null && !añoPublicacion.trim().isEmpty()) {
            this.añoPublicacion = añoPublicacion.trim();
        } else {
            this.añoPublicacion = "Sin información";
        }
    }

    public boolean isDisponible() {
        return disponible;
    }

    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }

    // Método abstracto para que cada tipo de libro lo implemente a su manera
    public abstract String getDescripcion();

    @Override
    public String toString() {
        return "ISBN: " + isbn + ", Título: " + titulo + ", Autor: " + autor +
               ", Tipo: " + tipo + ", Año de Publicación: " + añoPublicacion +
               ", Disponible: " + (disponible ? "Sí" : "No");
    }
}
