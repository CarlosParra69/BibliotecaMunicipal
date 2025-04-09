package sena.adso.sistema_gestion_libros.model;

public class LibroFiccion extends Libro{
    
    private String genero; 
    private boolean esSerie;

    public LibroFiccion(String isbn, String titulo, String autor, String tipo, int fechaPublicacion, boolean disponible) {
        super(isbn, titulo, autor, tipo, fechaPublicacion, disponible);
    }

   

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public boolean isEsSerie() {
        return esSerie;
    }

    public void setEsSerie(boolean esSerie) {
        this.esSerie = esSerie;
    }
    
    
    
    @Override
    public String getDescription() {
       return getTitulo()+ "Libro de género de ficción (fantasía, etc.)";
    }
 
    @Override
    public String toString() {
        return super.toString() + "Forma parte de una serie: "+ esSerie + (esSerie ? "Yes" : "No");
    }


    
    
      
}
