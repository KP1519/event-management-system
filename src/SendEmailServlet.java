

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@WebServlet("/SendEmailServlet")
public class SendEmailServlet extends HttpServlet {
    private static final String SMTP_HOST = "smtp.gmail.com"; // Change this based on your provider
    private static final String SMTP_PORT = "587"; // Use 465 for SSL
    private static final String EMAIL_SENDER = "epicevents.entertain@gmail.com"; // Replace with your email
    private static final String EMAIL_PASSWORD = "ooaa wmoh bxns qbeh"; // Use App Password for Gmail

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get email parameters from form
        String recipient = request.getParameter("recipient");
        String subject = request.getParameter("subject");
        String messageBody = request.getParameter("message");

        try {
            // Configure SMTP server settings
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            // Authenticate sender email
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_SENDER, EMAIL_PASSWORD);
                }
            });

            // Create email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_SENDER));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject(subject);
            message.setText(messageBody);

            // Send email
            Transport.send(message);
            out.println("<h3>Email Sent Successfully!</h3>");

        } catch (MessagingException e) {
            e.printStackTrace();
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
}
