package sena.adso.sistema_gestion_libros.util;

import java.io.PrintStream;
import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * Clase utilitaria para el envío de correos electrónicos en el sistema de gestión de libros
 */
public class EmailUtil {
    // Configuración del servidor de correo (Gmail)
    private static final String HOST = "smtp.gmail.com";
    private static final String PORT = "587";
    private static final String USERNAME = "carlosfernadosolergarzon.com"; // Cambiar por un correo real
    private static final String PASSWORD = "xvlparojusfxlzdn"; // Usar contraseña de aplicación
    private static final boolean DEBUG = true;

    /**
     * Envía un correo electrónico para recuperación de contraseña
     * @param destinatario Dirección de correo del destinatario
     * @param nuevaPassword Nueva contraseña generada
     * @return true si el envío fue exitoso, false en caso contrario
     */
    public static boolean enviarCorreoRecuperacion(String destinatario, String nuevaPassword) {
        Properties props = configurarPropiedades();
        
        try {
            Session session = crearSesion(props);

            if (DEBUG) {
                activarDebug(session, destinatario);
            }

            Message mensaje = new MimeMessage(session);
            mensaje.setFrom(new InternetAddress(USERNAME));
            mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            mensaje.setSubject("Recuperación de Contraseña - Sistema de Gestión de Libros");

            String contenido = "<html><body>"
                    + "<h2>Recuperación de Contraseña</h2>"
                    + "<p>Estimado usuario,</p>"
                    + "<p>Hemos recibido una solicitud para recuperar su contraseña. "
                    + "Su nueva contraseña temporal es: <strong>" + nuevaPassword + "</strong></p>"
                    + "<p>Por favor, cambie esta contraseña después de iniciar sesión.</p>"
                    + "<p>Saludos,<br>Equipo de Biblioteca</p>"
                    + "</body></html>";

            mensaje.setContent(contenido, "text/html; charset=utf-8");
            Transport.send(mensaje);
            
            if (DEBUG) {
                System.out.println("Correo de recuperación enviado a: " + destinatario);
            }
            return true;
        } catch (MessagingException e) {
            manejarError("recuperación", destinatario, e);
            return false;
        }
    }

    /**
     * Envía credenciales de acceso al sistema
     * @param destinatario Correo del destinatario
     * @param username Nombre de usuario
     * @param password Contraseña temporal
     * @param rol Rol del usuario (Bibliotecario/Lector)
     * @return true si el envío fue exitoso
     */
    public static boolean enviarCredenciales(String destinatario, String username, String password, String rol) {
        Properties props = configurarPropiedades();

        try {
            Session session = crearSesion(props);
            
            if (DEBUG) {
                activarDebug(session, destinatario);
            }
            
            Message mensaje = new MimeMessage(session);
            mensaje.setFrom(new InternetAddress(USERNAME));
            mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            mensaje.setSubject("Credenciales de Acceso - Sistema de Gestión de Libros");
            
            String contenido = "<html><body>"
                    + "<h2>Bienvenido al Sistema de Gestión de Libros</h2>"
                    + "<p>Sus credenciales de acceso son:</p>"
                    + "<p><strong>Usuario:</strong> " + username + "</p>"
                    + "<p><strong>Contraseña temporal:</strong> " + password + "</p>"
                    + "<p><strong>Rol:</strong> " + rol + "</p>"
                    + "<p>Saludos,<br>Equipo de Biblioteca</p>"
                    + "</body></html>";
            
            mensaje.setContent(contenido, "text/html; charset=utf-8");
            Transport.send(mensaje);
            
            if (DEBUG) {
                System.out.println("Credenciales enviadas a: " + destinatario);
            }
            return true;
        } catch (MessagingException e) {
            manejarError("credenciales", destinatario, e);
            return false;
        }
    }

    /**
     * Envía notificación de préstamo de libro
     * @param destinatario Correo del lector
     * @param tituloLibro Título del libro prestado
     * @param fechaDevolucion Fecha límite de devolución
     * @return true si el envío fue exitoso
     */
    public static boolean notificarPrestamo(String destinatario, String tituloLibro, Date fechaDevolucion) {
        Properties props = configurarPropiedades();

        try {
            Session session = crearSesion(props);
            
            if (DEBUG) {
                activarDebug(session, destinatario);
            }
            
            Message mensaje = new MimeMessage(session);
            mensaje.setFrom(new InternetAddress(USERNAME));
            mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            mensaje.setSubject("Préstamo de Libro - Sistema de Gestión de Libros");
            
            String contenido = "<html><body>"
                    + "<h2>Confirmación de Préstamo</h2>"
                    + "<p>Ha solicitado el siguiente libro:</p>"
                    + "<p><strong>Título:</strong> " + tituloLibro + "</p>"
                    + "<p><strong>Fecha límite de devolución:</strong> " + fechaDevolucion + "</p>"
                    + "<p>Saludos,<br>Equipo de Biblioteca</p>"
                    + "</body></html>";
            
            mensaje.setContent(contenido, "text/html; charset=utf-8");
            Transport.send(mensaje);
            
            if (DEBUG) {
                System.out.println("Notificación de préstamo enviada a: " + destinatario);
            }
            return true;
        } catch (MessagingException e) {
            manejarError("notificación de préstamo", destinatario, e);
            return false;
        }
    }

    // Métodos auxiliares privados
    
    private static Properties configurarPropiedades() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", PORT);
        props.put("mail.smtp.ssl.trust", HOST);
        return props;
    }
    
    private static Session crearSesion(Properties props) {
        return Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });
    }
    
    private static void activarDebug(Session session, String destinatario) {
        session.setDebug(true);
        System.out.println("Preparando envío a: " + destinatario);
    }
    
    private static void manejarError(String tipo, String destinatario, MessagingException e) {
        System.err.println("Error al enviar correo de " + tipo + " a " + destinatario);
        if (DEBUG) {
            e.printStackTrace();
        }
    }
    
    /**
     * Genera una contraseña temporal aleatoria
     * @return Contraseña generada
     */
    public static String generarPasswordTemporal() {
        String caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder(8);
        for (int i = 0; i < 8; i++) {
            int index = (int)(Math.random() * caracteres.length());
            sb.append(caracteres.charAt(index));
        }
        return sb.toString();
    }
}