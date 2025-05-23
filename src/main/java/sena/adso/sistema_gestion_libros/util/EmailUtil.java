package sena.adso.sistema_gestion_libros.util;

import java.io.PrintStream;
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
 * Clase utilitaria para el envío de correos electrónicos
 */
public class EmailUtil {
    // Configuración del servidor SMTP (ejemplo para Gmail)
    private static final String HOST = "smtp.gmail.com";
    private static final String PORT = "587";
    private static final String USERNAME = "tu_correo@gmail.com"; // Cambiar por un correo real
    private static final String PASSWORD = "tu_contraseña"; // Usar contraseña de aplicación
    private static final boolean DEBUG = true;

    /**
     * Envía un correo con las credenciales de registro
     * @param destinatario Correo del destinatario
     * @param username Nombre de usuario
     * @param password Contraseña temporal
     * @param rol Rol del usuario (Bibliotecario/Lector)
     * @return true si el envío fue exitoso
     */
    public static boolean enviarCredencialesRegistro(String destinatario, String username, 
                                                   String password, String rol) {
        Properties props = configurarPropiedades();
        
        try {
            Session session = crearSesion(props);
            
            if (DEBUG) {
                activarDebug(session, destinatario);
            }
            
            Message mensaje = new MimeMessage(session);
            mensaje.setFrom(new InternetAddress(USERNAME));
            mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            mensaje.setSubject("Bienvenido al Sistema de Gestión de Libros");
            
            String contenido = "<html><body>"
                    + "<h2>Credenciales de acceso</h2>"
                    + "<p>Su registro en el Sistema de Gestión de Libros ha sido exitoso.</p>"
                    + "<p><strong>Usuario:</strong> " + username + "</p>"
                    + "<p><strong>Contraseña temporal:</strong> " + password + "</p>"
                    + "<p><strong>Rol:</strong> " + rol + "</p>"
                    + "<p>Por motivos de seguridad, deberá cambiar esta contraseña al iniciar sesión por primera vez.</p>"
                    + "<p>Saludos,<br>Equipo de Biblioteca</p>"
                    + "</body></html>";
            
            mensaje.setContent(contenido, "text/html; charset=utf-8");
            Transport.send(mensaje);
            
            if (DEBUG) {
                System.out.println("Credenciales enviadas a: " + destinatario);
            }
            return true;
        } catch (MessagingException e) {
            System.err.println("Error al enviar credenciales: " + e.getMessage());
            return false;
        }
    }

    /**
     * Envía correo de recuperación de contraseña
     * @param destinatario Correo del destinatario
     * @param nuevaPassword Nueva contraseña temporal
     * @return true si el envío fue exitoso
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
                    + "<p>Hemos recibido una solicitud para recuperar su contraseña.</p>"
                    + "<p>Su nueva contraseña temporal es: <strong>" + nuevaPassword + "</strong></p>"
                    + "<p>Por favor, cámbiela después de iniciar sesión por motivos de seguridad.</p>"
                    + "<p>Saludos,<br>Equipo de Biblioteca</p>"
                    + "</body></html>";

            mensaje.setContent(contenido, "text/html; charset=utf-8");
            Transport.send(mensaje);
            
            if (DEBUG) {
                System.out.println("Correo de recuperación enviado a: " + destinatario);
            }
            return true;
        } catch (MessagingException e) {
            System.err.println("Error al enviar correo de recuperación: " + e.getMessage());
            return false;
        }
    }

    /**
     * Genera una contraseña temporal segura
     * @return Contraseña generada
     */
    public static String generarPasswordTemporal() {
        String caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%";
        StringBuilder sb = new StringBuilder(10);
        for (int i = 0; i < 10; i++) {
            int index = (int) (Math.random() * caracteres.length());
            sb.append(caracteres.charAt(index));
        }
        return sb.toString();
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
}