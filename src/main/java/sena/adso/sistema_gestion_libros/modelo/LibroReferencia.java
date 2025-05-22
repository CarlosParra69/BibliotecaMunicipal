package sena.adso.sistema_gestion_libros.modelo;

public class LibroReferencia extends Libro {
    private String tipoReferencia; // enciclopedia, diccionario, manual, etc.
    private String actualizaciones; // última edición, revisiones, año, etc.

    public LibroReferencia(String isbn, String titulo, String autor, int añoPublicacion, String tipoReferencia, String actualizaciones) {
        super(isbn, titulo, autor, "Referencia", añoPublicacion);
        this.tipoReferencia = tipoReferencia != null ? tipoReferencia : "Enciclopedia";
        this.actualizaciones = actualizaciones != null ? actualizaciones : "";
    }

    public String getTipoReferencia() {
        return tipoReferencia;
    }

    public void setTipoReferencia(String tipoReferencia) {
        this.tipoReferencia = tipoReferencia != null ? tipoReferencia : "Enciclopedia";
    }

    public String getActualizaciones() {
        return actualizaciones;
    }

    public void setActualizaciones(String actualizaciones) {
        this.actualizaciones = actualizaciones != null ? actualizaciones : "";
    }

    @Override
    public String getDescripcion() {
        return getTitulo() + " es un libro de referencia del tipo " + tipoReferencia +
               ". Últimas actualizaciones: " + (actualizaciones.isEmpty() ? "Sin actualizaciones" : actualizaciones) + ".";
    }

    @Override
    public String toString() {
        return super.toString() + ", Tipo de referencia: " + tipoReferencia +
               ", Actualizaciones: " + (actualizaciones.isEmpty() ? "Sin actualizaciones" : actualizaciones);
    }
}
