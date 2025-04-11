package sena.adso.sistema_gestion_libros.model;

import java.util.ArrayList;
import java.util.Date;

public class LibroManager {

    private static LibroManager instance;
    private final ArrayList<Libro> libros;
    private final ArrayList<Loan> prestamos;
    private int nextLoanId;

    public LibroManager() {
        libros = new ArrayList<>();
        prestamos = new ArrayList<>();
        nextLoanId = 1;
    }

    public static synchronized LibroManager getInstance() {
        if (instance == null) {
            instance = new LibroManager();
        }
        return instance;
    }

    public ArrayList<Libro> getTodosLosLibros() {
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
        for (Libro libro : libros) {
            if (libro.getIsbn().equalsIgnoreCase(isbn)) {
                return libro;
            }
        }
        return null;
    }
    
    public Libro buscarLibroPorISBN(String isbn) {
        return getLibroPorISBN(isbn);
    }

    public void agregarLibro(Libro libro) {
        // Verificar si ya existe un libro con el mismo ISBN
        for (Libro l : libros) {
            if (l.getIsbn().equalsIgnoreCase(libro.getIsbn())) {
                return; // No agregar si ya existe un libro con el mismo ISBN
            }
        }

        // Agregar el libro directamente
        libros.add(libro);
    }

    public boolean actualizarLibro(Libro libroActualizado) {
        for (int i = 0; i < libros.size(); i++) {
            if (libros.get(i).getIsbn().equalsIgnoreCase(libroActualizado.getIsbn())) {
                // Actualizar directamente con el libro recibido
                libros.set(i, libroActualizado);
                return true;
            }
        }

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

        Date fechaPrestamo = new Date(); // Fecha actual del sistema
        long tiempoEnMilis = diasPrestamo * 24L * 60L * 60L * 1000L;
        Date fechaLimite = new Date(fechaPrestamo.getTime() + tiempoEnMilis);

        Loan prestamo = new Loan(nextLoanId++, libro, nombrePrestatario, idPrestatario, fechaPrestamo, fechaLimite);
        prestamos.add(prestamo);
        libro.setDisponible(false);

        return prestamo;
    }

    public Loan crearPrestamoConFechas(String isbn, String nombrePrestatario, String idPrestatario, 
                                      Date fechaPrestamo, Date fechaLimite) {
        Libro libro = getLibroPorISBN(isbn);

        if (libro == null || !libro.isDisponible()) {
            return null;
        }

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
}
