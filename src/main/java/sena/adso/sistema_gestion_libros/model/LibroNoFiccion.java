package sena.adso.sistema_gestion_libros.model;

public class LibroNoFiccion extends Libro{
    
    private String tema; //ciencia, historia, otro
    private String nivelAcademico; // basico, medio, superior

    public LibroNoFiccion(int fechaPublicacion,String isbn, String titulo, String autor, String tipo, boolean disponible) {
        super(isbn, titulo, autor, "noFiccion", fechaPublicacion, disponible);
        this.tema = tema;
        this.nivelAcademico = nivelAcademico;
    }

    public String getTema() {
        return tema;
    }

    public void setTema(String tema) {
        this.tema = tema;
    }

    public String getNivelAcademico() {
        return nivelAcademico;
    }

    public void setNivelAcademico(String nivelAcademico) {
        this.nivelAcademico = nivelAcademico;
    }
    
    

    @Override
    public String getDescription() {
        return getTipo()+ "Libro de género de no ficción, su tema es: " + tema + "y su nivel academico es: " + nivelAcademico;
    }

    @Override
    public String toString() {
        return "LibroNoFiccion{" + "tema=" + tema + ", nivelAcademico=" + nivelAcademico + '}';
    }

   


    
    
    
}
