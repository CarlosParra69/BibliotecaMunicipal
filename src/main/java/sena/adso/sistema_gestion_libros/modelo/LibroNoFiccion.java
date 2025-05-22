package sena.adso.sistema_gestion_libros.modelo;

public class LibroNoFiccion extends Libro {

    private String tema; // historia, ciencia, biografía, etc.
    private String nivelAcademico; // básico, intermedio, avanzado

    public LibroNoFiccion(String isbn, String titulo, String autor, int añoPublicacion, String tema, String nivelAcademico) {
        super(isbn, titulo, autor, "NoFiccion", añoPublicacion);
        this.tema = tema != null ? tema : "Ciencia";
        this.nivelAcademico = nivelAcademico != null ? nivelAcademico : "Basico";
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
        this.nivelAcademico = nivelAcademico != null ? nivelAcademico : "Basico";
    }

    @Override
    public String getDescripcion() {
        return getTitulo() + " es un libro de no ficción sobre " + tema +
               ", orientado a un nivel académico " + nivelAcademico + ".";
    }

    @Override
    public String toString() {
        return super.toString() + ", Tema: " + tema +
               ", Nivel academico: " + nivelAcademico;
    }
}
