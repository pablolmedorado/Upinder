package upinder.util;

import com.itextpdf.text.Document;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class Mailer {

    private String user;
    private String password;
    private Session session;

    static Properties properties = new Properties();

    static {
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.socketFactory.port", "465");
        properties.put("mail.smtp.socketFactory.class",
                "javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.port", "465");
    }

    public Mailer() {
        user = "soporte.upinder@gmail.com";
        password = "%upinder%";
        session = Session.getDefaultInstance(this.properties,
            new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(user, password);
                }
            }
        );
    }

    public void sendMail(String to, String subject, String body) {
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(body);
            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void sendNotificationMail(String to, String name, String notification) {
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Notificacion Upinder");
            
            String cuerpo = "Hola "+ name +", tienes una nueva notificación en Upinder:\n\n"
                    + notification + "\n\n"
                    + "Esta notificación se ha enviado a " + to + ". Si no quieres recibir más emails como éste, cambia tus preferencias dentro de tu perfil.";
            
            message.setText(cuerpo);
            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void sendAltaMail(String to, String name, String password, String codigo) {
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Bienvenido a Upinder");
            
            String cuerpo = "Bienvenido a Upinder, "+ name +".\n\n"
                    + "Tus credenciales de acceso son:\n"
                    + "-Usuario: " + to + "\n"
                    + "-Contraseña: " + password + "\n\n"
                    + "Para poder acceder al sistema, es necesario que confirmes primero tu cuenta "
                    + "accediendo al siguiente enlace http://localhost:8084/Upinder/validarUsuario.action?user="
                        + URLEncoder.encode(to, "UTF-8") + "&codigo=" + codigo;
            
            message.setText(cuerpo);
            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void sendDenunciaMail(String to, String name, String fullname, String denunciado, String tipo, String declaracion, String ruta){
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("soporte.upinder@gmail.com"));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(to));
            message.setSubject("Denuncia de Upinder");
            
            BodyPart messageBodyPart = new MimeBodyPart();
            String cuerpo = "Buenas " + name + ";\n\n"
                    + "Hemos recibido una solicitud de denuncia por tu parte hacia el usuario " + denunciado
                    + ".\nTe adjuntamos una copia en pdf de dicha denuncia que deberás remitirnos firmada "
                    + "para que podamos ponernos manos a la obra.\n\n"
                    + "Ten en cuenta que una denuncia como esta podría derivar en el cierre de la cuenta del usuario denunciado "
                    + "o de la tuya en caso de que se trate de una denuncia falsa.\n\n"
                    + "Recibe un cordial saludo de parte del equipo de Upinder.\n\n"
                    + "Esta notificación se ha enviado a " + to + ". Si crees que no eres el destinatario, contesta a este email y comunícanoslo.";
            messageBodyPart.setText(cuerpo);
            
            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(messageBodyPart);
            messageBodyPart = new MimeBodyPart();
            
            String filename = ruta + "/Denuncia"+name+String.valueOf(System.currentTimeMillis())+".pdf";
            Document document = new Document();
            PdfWriter.getInstance(document, new FileOutputStream(filename));
            document.open();
            document.add(new Paragraph("DATOS DEL AFECTADO	 D. / Dª : " + fullname+"\n\n"));
            document.add(new Paragraph("DATOS DEL PRESUNTO RESPONSABLE	 D. / Dª : " + denunciado+"\n\n"));
            document.add(new Paragraph("De acuerdo con lo previsto en la normativa vigente, pone en conocimiento "
                    + "de los Administradores de la aplicación Upinder los siguientes HECHOS bajo la categoria " + tipo.toUpperCase() +":\n\n"));
            document.add(new Paragraph("\""+declaracion+"\""));
            document.add(new Paragraph("\n\nEn virtud de lo expuesto, SOLICITA que se dicte acuerdo de inicio de procedimiento "
                    + "sancionador o de infracción de las Administraciones Públicas o se incoen actuaciones con objeto de determinar "
                    + "si concurren circunstancias que justifiquen tal iniciación y que, en cualquier caso, se me notifique el acuerdo "
                    + "que se adopte, de conformidad con lo previsto en el Reglamento de desarrollo de la Ley Orgánica 15/1999, aprobado "
                    + "mediante Real Decreto 1720/2007, de 21 de diciembre.\n"
                    + "En ..............................  a  ........ de ........................ de 20...... \n"));
            document.add(new Paragraph("Firmado:\n\n\n"));
            document.add(new Paragraph("A la atención de la Administración de Upinder, S.A.\n"
                    + "C/ Calle Utrera.- 41013 Sevilla.\n"
                    + "La denuncia puede presentarse por el propio afectado, en cuyo caso acompañará copia del DNI, o cualquier "
                    + "otro documento que acredite la identidad y sea considerado válido en derecho. También puede concederse "
                    + "la representación legal a un tercero, en cuyo caso, además, se deberá aportar DNI y documento "
                    + "acreditativo de la representación de éste."));
            document.close();
            
            
            DataSource source = new FileDataSource(filename);
            messageBodyPart.setDataHandler(new DataHandler(source));
            messageBodyPart.setFileName(filename);
            multipart.addBodyPart(messageBodyPart);

            message.setContent(multipart);

            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
