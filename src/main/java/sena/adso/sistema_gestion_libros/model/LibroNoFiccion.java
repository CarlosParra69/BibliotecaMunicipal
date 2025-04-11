package sena.adso.sistema_gestion_libros.model;

public class LibroNoFiccion extends Libro {

    private String tema; // historia, ciencia, biografía, etc.
    private String nivelAcademico; // básico, intermedio, avanzado

    public LibroNoFiccion(String isbn, String titulo, String autor, String añoPublicacion, String tema, String nivelAcademico) {
        super(isbn, titulo, autor, "NoFiccion", añoPublicacion);
        this.tema = tema != null ? tema : "Ciencia";
        this.nivelAcademico = nivelAcademico != null ? nivelAcademico : "Básico";
    }

    public String getTema() {
        return tema;
    }

    public void setTema(String tema) {
        this.tema = tema != null ? tema : "Ciencia";
    }

    public String getNivelAcademico() {
        return nivelAcademico;
    }

    public void setNivelAcademico(String nivelAcademico) {
        this.nivelAcademico = nivelAcademico != null ? nivelAcademico : "Básico";
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
