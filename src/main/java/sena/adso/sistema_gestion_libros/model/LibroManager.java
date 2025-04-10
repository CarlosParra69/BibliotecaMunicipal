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

    public void agregarLibro(Libro libro) {
        libros.add(libro);
    }

    public boolean actualizarLibro(Libro libroActualizado) {
        for (int i = 0; i < libros.size(); i++) {
            if (libros.get(i).getIsbn().equalsIgnoreCase(libroActualizado.getIsbn())) {
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
}
