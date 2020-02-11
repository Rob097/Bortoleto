/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package varie;

import java.io.IOException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tools.VerifyUtils;
import static varie.Costanti.MAC_MAIL;
import static varie.Costanti.MAC_PASS;
import static varie.Costanti.ROB_MAIL;
import static varie.Costanti.ROB_PASS;

/**
 *
 * @author Roberto97
 */
public class SendEmail extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * Servelet per l'invio di email. Sarà una servlet complessa che in base ai
     * parametri ricevuti invierà un email piuttosto che un altra. NON ANCORA
     * SVILUPPATA DEL TUTTO
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        /* Inizio analisi recaptcha */
        boolean valid;
        String errorString;
        String gRecaptchaResponse = request.getParameter("recaptcha");

        // Verify CAPTCHA.
        valid = VerifyUtils.verify(gRecaptchaResponse);
        if (!valid) {
            errorString = "Captcha send email invalid!";
            System.out.println(errorString);
            response.sendRedirect(response.encodeURL("home.jsp"));
            /* Questo è da cambiare alla pagina di errore */
        } else {
            /* analisi recaptcha eseguire solo se è valido*/
            String per = "", nome = "", email = "", oggetto = "", messaggio = "QUESTO MESSAGGIO è SATO INVIATO DAL SITO INTERNET SEZIONE MACELLERIA";

            if (request.getParameter("for") != null) {
                per = request.getParameter("for");
            }
            if (request.getParameter("nome") != null) {
                nome = request.getParameter("nome");
            }
            if (request.getParameter("email") != null) {
                email = request.getParameter("email");
            }
            if (request.getParameter("oggetto") != null) {
                oggetto = request.getParameter("oggetto");
            }
            messaggio += "\n\nNome: " + nome + "\n\nEmail: " + email + "\n\nMessaggio: \n";
            if (request.getParameter("messaggio") != null) {
                messaggio += request.getParameter("messaggio");
            }

            switch (per) {
                case "macelleria":
                default:
                    try {
                        //Dati email Roberto
                        String to1 = MAC_MAIL;
                        final String user1 = MAC_MAIL;
                        final String pass1 = MAC_PASS;
                        Properties props1 = new Properties();
                        props1.put("mail.smtp.host", "smtp.gmail.com");
                        //below mentioned mail.smtp.port is optional
                        props1.put("mail.smtp.port", "587");
                        props1.put("mail.smtp.auth", "true");
                        props1.put("mail.smtp.starttls.enable", "true");
                        Session session2;
                        session2 = Session.getInstance(props1, new javax.mail.Authenticator() {
                            @Override
                            protected PasswordAuthentication getPasswordAuthentication() {
                                return new PasswordAuthentication(user1, pass1);
                            }
                        });
                        MimeMessage message = new MimeMessage(session2);
                        message.setFrom(new InternetAddress(user1));
                        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to1));
                        message.setSubject(oggetto);
                        message.setText(messaggio);

                        /* Transport class is used to deliver the message to the recipients */
                        Transport.send(message);
                    } catch (MessagingException ex1) {
                        try {
                            //Dati email Roberto
                            String to1 = ROB_MAIL;
                            final String user1 = ROB_MAIL;
                            final String pass1 = ROB_PASS;
                            Properties props1 = new Properties();
                            props1.put("mail.smtp.host", "smtp.gmail.com");
                            //below mentioned mail.smtp.port is optional
                            props1.put("mail.smtp.port", "587");
                            props1.put("mail.smtp.auth", "true");
                            props1.put("mail.smtp.starttls.enable", "true");
                            Session session2;
                            session2 = Session.getInstance(props1, new javax.mail.Authenticator() {
                                @Override
                                protected PasswordAuthentication getPasswordAuthentication() {
                                    return new PasswordAuthentication(user1, pass1);
                                }
                            });
                            MimeMessage message = new MimeMessage(session2);
                            message.setFrom(new InternetAddress(user1));
                            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to1));
                            message.setSubject(oggetto);
                            message.setText(messaggio);

                            /* Transport class is used to deliver the message to the recipients */
                            Transport.send(message);
                        } catch (MessagingException ex) {
                            System.out.println("Errore invio email");
                        }
                    }
                    break;

                case "ristorante":
                    System.out.println("Email per il ristorante");
                    break;
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        this.doPost(req, resp);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
