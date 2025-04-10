package sena.adso.sistema_gestion_libros.model;

import java.util.ArrayList;
import java.util.Date;

public class LibroManager {
    private static LibroManager instance;
    private ArrayList<Libro> libros;
    private ArrayList<Loan> prestamos;
    private int nextLoanId;

    public LibroManager() {
        libros = new ArrayList<>();
        prestamos = new ArrayList<>();
        nextLoanId = 1;
        System.out.println("Constructor de LibroManager ejecutado - Contenedor de libros inicializado");
    }

    public static synchronized LibroManager getInstance() {
        if (instance == null) {
            instance = new LibroManager();
            System.out.println("NUEVA INSTANCIA DE LIBROMANAGER CREADA");
        } else {
            System.out.println("INSTANCIA EXISTENTE DE LIBROMANAGER REUTILIZADA");
        }
        return instance;
    }

    public ArrayList<Libro> getTodosLosLibros() {
        System.out.println("RECUPERANDO TODOS LOS LIBROS. Tamaño: " + libros.size());
        for (Libro libro : libros) {
            System.out.println("  Libro recuperado - ISBN: " + libro.getIsbn() + 
                               ", Título: " + libro.getTitulo() + 
                               ", Tipo: " + libro.getTipo() + 
                               ", Año: " + libro.getAñoPublicacion());
        }
        return libros;
    }

    public ArrayList<Libro> getLibrosDisponibles() {
        ArrayList<Libro> disponibles = new ArrayList<>();
        for (Libro libro : libros) {
            if (libro.isDisponible()) {
                disponibles.add(libro);
            }
        }
        return disponibles;
    }

    public Libro getLibroPorISBN(String isbn) {
        // Depuración adicional para verificar el año del libro recuperado
        Libro encontrado = null;
        
        for (Libro libro : libros) {
            if (libro.getIsbn().equalsIgnoreCase(isbn)) {
                encontrado = libro;
                System.out.println("[CRÍTICO] Libro encontrado por ISBN: " + isbn + ", año: " + libro.getAñoPublicacion());
                break;
            }
        }
        
        if (encontrado == null) {
            System.out.println("[CRÍTICO] No se encontró libro con ISBN: " + isbn);
        }
        
        return encontrado;
    }

    public void agregarLibro(Libro libro) {
        int añoOriginal = libro.getAñoPublicacion(); // Guardar el año original
        System.out.println("Agregando libro con ISBN: " + libro.getIsbn() + ", año ORIGINAL: " + añoOriginal);
        System.out.println("VERIFICACIÓN COMPLETA - Título: " + libro.getTitulo() + 
                          ", Autor: " + libro.getAutor() + 
                          ", Tipo: " + libro.getTipo() + 
                          ", Año: " + libro.getAñoPublicacion());
        
        // Dumpear todos los libros actuales para debug
        System.out.println("ESTADO ACTUAL DE LA COLECCIÓN ANTES DE AGREGAR:");
        for (Libro l : libros) {
            System.out.println("  - ISBN: " + l.getIsbn() + ", Título: " + l.getTitulo() + ", Año: " + l.getAñoPublicacion());
        }
        
        // Crear una copia "limpia" del libro para evitar cualquier problema de referencia
        Libro copiaNueva = null;
        
        if (libro instanceof LibroFiccion) {
            LibroFiccion lf = (LibroFiccion) libro;
            copiaNueva = new LibroFiccion(
                libro.getIsbn(), 
                libro.getTitulo(), 
                libro.getAutor(), 
                añoOriginal, // Usar el año original directamente
                lf.getGenero(),
                lf.isEsSerie()
            );
            System.out.println("Creado LibroFiccion con año: " + añoOriginal);
        } else if (libro instanceof LibroNoFiccion) {
            LibroNoFiccion lnf = (LibroNoFiccion) libro;
            copiaNueva = new LibroNoFiccion(
                libro.getIsbn(), 
                libro.getTitulo(), 
                libro.getAutor(), 
                añoOriginal, // Usar el año original directamente
                lnf.getTema(),
                lnf.getNivelAcademico()
            );
            System.out.println("Creado LibroNoFiccion con año: " + añoOriginal);
        } else if (libro instanceof LibroReferencia) {
            LibroReferencia lr = (LibroReferencia) libro;
            copiaNueva = new LibroReferencia(
                libro.getIsbn(), 
                libro.getTitulo(), 
                libro.getAutor(), 
                añoOriginal, // Usar el año original directamente
                lr.getTipoReferencia(),
                lr.getActualizaciones()
            );
            System.out.println("Creado LibroReferencia con año: " + añoOriginal);
        }
        
        if (copiaNueva != null) {
            libros.add(copiaNueva);
            System.out.println("Libro agregado (copia nueva). Verificando:");
            System.out.println("  - Original -> ISBN: " + libro.getIsbn() + ", Año: " + libro.getAñoPublicacion());
            System.out.println("  - Copia -> ISBN: " + copiaNueva.getIsbn() + ", Año: " + copiaNueva.getAñoPublicacion());
        } else {
            System.out.println("No se pudo crear copia, agregando original");
            libros.add(libro);
        }
        
        System.out.println("Verificando contenido del ArrayList después de agregar:");
        System.out.println("Tamaño de libros: " + libros.size() + " libros");
        System.out.println("Último libro agregado: " + libros.get(libros.size() - 1).getTitulo() + 
                          ", año: " + libros.get(libros.size() - 1).getAñoPublicacion());
    }

    public boolean actualizarLibro(Libro libroActualizado) {
        int añoOriginal = libroActualizado.getAñoPublicacion(); // Guardar el año original
        System.out.println("Actualizando libro con ISBN: " + libroActualizado.getIsbn() + ", año ORIGINAL: " + añoOriginal);
        
        // Imprimir todos los datos del libro por actualizar para depuración
        System.out.println("DATOS DEL LIBRO A ACTUALIZAR:");
        System.out.println("  - ISBN: " + libroActualizado.getIsbn());
        System.out.println("  - Título: " + libroActualizado.getTitulo());
        System.out.println("  - Autor: " + libroActualizado.getAutor());
        System.out.println("  - Tipo: " + libroActualizado.getTipo());
        System.out.println("  - Año: " + libroActualizado.getAñoPublicacion());
        System.out.println("  - Disponible: " + libroActualizado.isDisponible());
        
        for (int i = 0; i < libros.size(); i++) {
            if (libros.get(i).getIsbn().equalsIgnoreCase(libroActualizado.getIsbn())) {
                // Crear una copia nueva en lugar de usar la referencia directa
                Libro nuevaCopia = null;
                
                if (libroActualizado instanceof LibroFiccion) {
                    LibroFiccion lf = (LibroFiccion) libroActualizado;
                    nuevaCopia = new LibroFiccion(
                        libroActualizado.getIsbn(),
                        libroActualizado.getTitulo(),
                        libroActualizado.getAutor(),
                        añoOriginal, // Usar el año original directamente
                        lf.getGenero(),
                        lf.isEsSerie()
                    );
                    System.out.println("Actualizado LibroFiccion con año: " + añoOriginal);
                } else if (libroActualizado instanceof LibroNoFiccion) {
                    LibroNoFiccion lnf = (LibroNoFiccion) libroActualizado;
                    nuevaCopia = new LibroNoFiccion(
                        libroActualizado.getIsbn(),
                        libroActualizado.getTitulo(),
                        libroActualizado.getAutor(),
                        añoOriginal, // Usar el año original directamente
                        lnf.getTema(),
                        lnf.getNivelAcademico()
                    );
                    System.out.println("Actualizado LibroNoFiccion con año: " + añoOriginal);
                } else if (libroActualizado instanceof LibroReferencia) {
                    LibroReferencia lr = (LibroReferencia) libroActualizado;
                    nuevaCopia = new LibroReferencia(
                        libroActualizado.getIsbn(),
                        libroActualizado.getTitulo(),
                        libroActualizado.getAutor(),
                        añoOriginal, // Usar el año original directamente
                        lr.getTipoReferencia(),
                        lr.getActualizaciones()
                    );
                    System.out.println("Actualizado LibroReferencia con año: " + añoOriginal);
                }
                
                if (nuevaCopia != null) {
                    // Establecer disponibilidad
                    nuevaCopia.setDisponible(libroActualizado.isDisponible());
                    
                    // Reemplazar el objeto en la lista
                    libros.set(i, nuevaCopia);
                    
                    System.out.println("Libro actualizado. Nuevo objeto creado con año: " + nuevaCopia.getAñoPublicacion());
                    return true;
                } else {
                    // Si no se pudo crear una copia, usar el objeto original
                    libros.set(i, libroActualizado);
                    System.out.println("Libro actualizado con referencia original");
                    return true;
                }
            }
        }
        
        System.out.println("No se encontró libro para actualizar");
        return false;
    }

    public boolean eliminarLibro(String isbn) {
        for (Loan prestamo : prestamos) {
            if (prestamo.getLibro().getIsbn().equalsIgnoreCase(isbn) && prestamo.isActivo()) {
                return false; // No se puede eliminar si hay un préstamo activo
            }
        }
        return libros.removeIf(libro -> libro.getIsbn().equalsIgnoreCase(isbn));
    }

    public ArrayList<Loan> getTodosLosPrestamos() {
        return prestamos;
    }

    public ArrayList<Loan> getPrestamosActivos() {
        ArrayList<Loan> activos = new ArrayList<>();
        for (Loan prestamo : prestamos) {
            if (prestamo.isActivo()) {
                activos.add(prestamo);
            }
        }
        return activos;
    }

    public Loan getPrestamoPorId(int id) {
        for (Loan prestamo : prestamos) {
            if (prestamo.getId() == id) {
                return prestamo;
            }
        }
        return null;
    }

    public Loan crearPrestamo(String isbn, String nombrePrestatario, String idPrestatario, int diasPrestamo) {
        Libro libro = getLibroPorISBN(isbn);

        if (libro == null || !libro.isDisponible()) {
            return null;
        }

        Date fechaPrestamo = new Date();
        long tiempoEnMilis = diasPrestamo * 24L * 60L * 60L * 1000L;
        Date fechaLimite = new Date(fechaPrestamo.getTime() + tiempoEnMilis);

        Loan prestamo = new Loan(nextLoanId++, libro, nombrePrestatario, idPrestatario, fechaPrestamo, fechaLimite);
        prestamos.add(prestamo);
        libro.setDisponible(false);

        return prestamo;
    }

    public boolean devolverLibro(int idPrestamo) {
        Loan prestamo = getPrestamoPorId(idPrestamo);

        if (prestamo == null || !prestamo.isActivo()) {
            return false;
        }

        prestamo.returnLibro(new Date());
        return true;
    }

    public boolean devolverLibro(int idPrestamo, String estadoDevolucion, String observaciones) {
        Loan prestamo = getPrestamoPorId(idPrestamo);

        if (prestamo == null || !prestamo.isActivo()) {
            return false;
        }

        prestamo.returnLibro(new Date(), estadoDevolucion, observaciones);
        return true;
    }

    public boolean eliminarPrestamo(int idPrestamo) {
        for (int i = 0; i < prestamos.size(); i++) {
            if (prestamos.get(i).getId() == idPrestamo) {
                // Si el préstamo está activo, devolver el libro primero
                if (prestamos.get(i).isActivo()) {
                    devolverLibro(idPrestamo);
                }
                // Eliminar el préstamo
                prestamos.remove(i);
                return true;
            }
        }
        return false;
    }

    public void verificarEstadoContenedor() {
        System.out.println("=============== VERIFICACIÓN DE ESTADO DEL CONTENEDOR ===============");
        System.out.println("Cantidad total de libros: " + libros.size());
        for (int i = 0; i < libros.size(); i++) {
            Libro libro = libros.get(i);
            System.out.println("Libro #" + (i+1) + ": ISBN=" + libro.getIsbn() + 
                              ", Título=" + libro.getTitulo() + 
                              ", Autor=" + libro.getAutor() + 
                              ", Tipo=" + libro.getTipo() + 
                              ", Año=" + libro.getAñoPublicacion());
            // Verificar el tipo específico de libro
            if (libro instanceof LibroFiccion) {
                LibroFiccion lf = (LibroFiccion) libro;
                System.out.println("   > Es LibroFiccion. Género: " + lf.getGenero() + 
                                  ", Serie: " + (lf.isEsSerie() ? "Sí" : "No"));
            } else if (libro instanceof LibroNoFiccion) {
                LibroNoFiccion lnf = (LibroNoFiccion) libro;
                System.out.println("   > Es LibroNoFiccion. Tema: " + lnf.getTema() + 
                                  ", Nivel: " + lnf.getNivelAcademico());
            } else if (libro instanceof LibroReferencia) {
                LibroReferencia lr = (LibroReferencia) libro;
                System.out.println("   > Es LibroReferencia. Tipo: " + lr.getTipoReferencia() + 
                                  ", Actualizaciones: " + lr.getActualizaciones());
            }
        }
        System.out.println("================================================================");
    }

    // Nuevo método para corregir manualmente el año de un libro ya agregado
    public void corregirAñoLibro(String isbn, int añoReal) {
        for (Libro libro : libros) {
            if (libro.getIsbn().equals(isbn)) {
                // Verificar si el libro tiene el año predeterminado 2000
                if (libro.getAñoPublicacion() == 2000) {
                    System.out.println("[CRÍTICO] Corrigiendo año para libro " + libro.getTitulo() + " de 2000 a " + añoReal);
                    libro.setAñoPublicacion(añoReal);
                    System.out.println("[CRÍTICO] Año corregido, ahora es: " + libro.getAñoPublicacion());
                }
                break;
            }
        }
    }
}

