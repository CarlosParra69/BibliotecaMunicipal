package sena.adso.sistema_gestion_libros.model;

public class LibroReferencia extends Libro{
    private String tipoReferencia;
    private String actualizaciones;

    public LibroReferencia(int fechaPublicacion,String isbn, String titulo, String autor, String tipo, boolean disponible) {
        super(isbn, titulo, autor, "referencia", fechaPublicacion, disponible);
        this.tipoReferencia = tipoReferencia;
        this.actualizaciones = actualizaciones;
    }

    public String getTipoReferencia() {
        return tipoReferencia;
    }

    public void setTipoReferencia(String tipoReferencia) {
        this.tipoReferencia = tipoReferencia;
    }

    public String getActualizaciones() {
        return actualizaciones;
    }

    public void setActualizaciones(String actualizaciones) {
        this.actualizaciones = actualizaciones;
    }
    

    @Override
    public String getDescription() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public String toString() {
        return "LibroReferencia{" + "tipoReferencia=" + tipoReferencia + ", actualizaciones=" + actualizaciones + '}';
    }
    
}
