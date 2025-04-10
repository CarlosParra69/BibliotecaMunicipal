package sena.adso.sistema_gestion_libros.model;

public class LibroNoFiccion extends Libro {

    private String tema; // ciencia, historia, etc.
    private String nivelAcademico; // básico, medio, superior

    public LibroNoFiccion(String isbn, String titulo, String autor, int añoPublicacion, String tema, String nivelAcademico) {
        super(isbn, titulo, autor, "noficcion", añoPublicacion);
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
    public String getDescripcion() {
        return getTitulo() + " es un libro de no ficción sobre " + tema +
               ", orientado a un nivel académico " + nivelAcademico + ".";
    }

    @Override
    public String toString() {
        return super.toString() + ", Tema: " + tema +
               ", Nivel académico: " + nivelAcademico;
    }
}
