/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package varie;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
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
public class SendRecipe extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * Servlet per l'invio per emeil di una ricetta
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        /* Inizio analisi recaptcha */
        boolean valid;
        String errorString = null;
        String gRecaptchaResponse = request.getParameter("g-recaptcha-response");

        // Verify CAPTCHA.
        valid = VerifyUtils.verify(gRecaptchaResponse);
        if (!valid) {
            errorString = "Captcha send ricetta invalid!";
            response.sendRedirect(response.encodeURL("home.jsp"));
            /* Questo è da cambiare alla pagina di errore */
        } else {
            /* analisi recaptcha eseguire solo se è valido*/
            String nome = "", email = "", procedimento = "", titolo = "";
            ArrayList<String> ingredientiNomi = new ArrayList<>();
            ArrayList<String> quantitaNomi = new ArrayList<>();

            ArrayList<String> ingredienti = new ArrayList<>();
            ArrayList<String> quantita = new ArrayList<>();

            String messaggio = "";

            if (request.getParameter("nome") != null) {
                nome = request.getParameter("nome");
            }

            if (request.getParameter("email") != null) {
                email = request.getParameter("email");
            }
            if (request.getParameter("procedimento") != null) {
                procedimento = request.getParameter("procedimento");
            }
            if (request.getParameter("titolo") != null) {
                titolo = request.getParameter("titolo");
            }
            Enumeration<String> keys = request.getParameterNames();
            try {
                while (keys.hasMoreElements()) {
                    String key = keys.nextElement();
                    if (key.contains("[ingrediente]")) {
                        ingredientiNomi.add(key);
                    }
                    if (key.contains("[quantity]")) {
                        quantitaNomi.add(key);
                    }
                }

                for (int k = 0; k < ingredientiNomi.size(); k++) {
                    if (!request.getParameter(ingredientiNomi.get(k)).equals("")) {
                        ingredienti.add(request.getParameter(ingredientiNomi.get(k)));
                    }
                    if (!request.getParameter(quantitaNomi.get(k)).equals("")) {
                        quantita.add(request.getParameter(quantitaNomi.get(k)));
                    }
                }
                String ingS = "";
                for (int k = 0; k < ingredienti.size(); k++) {
                    ingS += ingredienti.get(k) + " " + quantita.get(k) + "_";
                }
                StringBuilder b = new StringBuilder(ingS);
                b = b.replace(ingS.lastIndexOf("_"), ingS.lastIndexOf("_"), "");
                ingS = b.toString();

                String ing = "";
                for (int k = 0; k < ingredienti.size(); k++) {
                    ing += "\n" + (k + 1) + "° Ingrediente: " + ingredienti.get(k) + "  " + (k + 1) + "° Quantità: " + quantita.get(k);
                }
                messaggio = "Nome: " + nome + "\n\nEmail: " + email + "\n";
                messaggio += "TITOLO: '" + titolo + "'";
                messaggio += ing;
                messaggio += "\n\nProcedimento: " + procedimento + "\n";

                request.setAttribute("product", "0");
                request.setAttribute("ingredienti", ingS);
                request.setAttribute("titolo", titolo);
                request.setAttribute("autore", nome);
                request.setAttribute("procedimento", procedimento);

                /*System.out.println("Ing: " + ingS);
                System.out.println("Autore: " + nome);*/
            } catch (Exception e) {
                System.out.println("Errore send recipe");
            }
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
                message.setSubject("RICETTA");
                message.setText(messaggio);

                /* Transport class is used to deliver the message to the recipients */
                Transport.send(message);
            } catch (MessagingException ex) {
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
                    message.setSubject("RICETTA");
                    message.setText(messaggio);

                    /* Transport class is used to deliver the message to the recipients */
                    Transport.send(message);
                } catch (MessagingException ex1) {
                    System.out.println("Errore invio email Ordine Confermato");
                }
            }
            try {
                //Dati email Roberto
                String to1 = email;
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
                message.setSubject("Grazie del tuo contributo!");
                message.setText("Grazie " + nome + " per la tua ricetta '" + titolo + "'. Appena l'avremo revisionata la troverai sul nostro sito web!");

                /* Transport class is used to deliver the message to the recipients */
                Transport.send(message);
            } catch (MessagingException ex) {
                System.out.println("Errore invio email Ordine Confermato");
            }
            RequestDispatcher rd = request.getRequestDispatcher("addIdea");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        this.doGet(req, resp);
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
