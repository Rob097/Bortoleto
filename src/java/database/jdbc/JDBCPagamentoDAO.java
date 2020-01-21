/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.jdbc;

import database.daos.PagamentoDAO;
import database.daos.ProductDAO;
import database.exceptions.DAOException;
import database.exceptions.DAOFactoryException;
import database.factories.JDBCDAOFactory;
import static database.factories.JDBCDAOFactory.DBURL;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import static varie.Costanti.MAC_MAIL;
import static varie.Costanti.MAC_PASS;
import static varie.Costanti.MAX_COSTO;
import static varie.Costanti.MAX_PESO;
import static varie.Costanti.MAX_PRICE;
import static varie.Costanti.MAX_W_PRICE;
import static varie.Costanti.MED_COSTO;
import static varie.Costanti.MED_PESO;
import static varie.Costanti.MED_PRICE;
import static varie.Costanti.MED_W_PRICE;
import static varie.Costanti.MIN_COSTO;
import static varie.Costanti.MIN_PESO;
import static varie.Costanti.MIN_PRICE;
import static varie.Costanti.MIN_W_PRICE;

/**
 * JDBCDAO Per i metodi relativi alle operazioni di pagamento
 *
 * @author Roberto97
 */
public class JDBCPagamentoDAO extends JDBCDAO implements PagamentoDAO {

    /**
     * Questa è il costruttore e serve fondamentalmente per collegarsi alla
     * connessione aperta con il DB
     *
     * @param con E' la connessione al DB
     * @throws java.sql.SQLException
     */
    public JDBCPagamentoDAO(Connection con) throws SQLException {
        super(con);
        try {
            checkCON();
        } catch (DAOException ex) {
            Logger.getLogger(JDBCConsoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Controlla che la connessione con il DB sia aperta, altrimenti la riapre
     * @throws DAOException
     */
    @Override
    public final void checkCON() throws DAOException {
        try {
            if (this.CON == null || this.CON.isClosed() || !this.CON.isValid(0)) {
                this.daoFactory = new JDBCDAOFactory(DBURL);
                this.CON = daoFactory.getConnection();
            }
        } catch (SQLException | DAOFactoryException ex) {
            System.out.println("console jdbc checkCON catch");
            Logger.getLogger(JDBCConsoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Metodo per calcolare le spese di spedizione dell'ordine.<br>
     * Questo metodo verifica se nel carrello ci sono prodotti freschi.<br>
     * Se non ci sono calcola le spese in base alla spedizione con KEATCHEN senza box.<br>
     * Se ci sono allora calcola le spese in base alla spedizione con KEATCHEN e
     * ci aggiunge anche il costo dei box refrigeranti più scatola di sicurezza
     * obbligatoria usando il metodo productdao.checkWeight(request).
     *
     * @param costo Indica il costo dei prodotti presenti nel carrello
     * (Consideerando le quantità)
     * @param ritiro E' il parametro che verifica se l'utente ha selezionato il
     * ritiro in negozio. In questo caso setta le spese di spedizione a 0.00
     * @param request
     * @return Ritorna una stringa uguale al costo totale della spedizione con
     * due cifre decimali.
     * @throws DAOException
     */
    @Override
    public String getSpeseSpedizione(String costo, boolean ritiro, HttpServletRequest request) throws DAOException {
        checkCON();
        //System.out.println("RITIRO in JDBC" + ritiro);
        if (costo == null || costo.isEmpty()) {
            return null;
        } else {
            DecimalFormat df = new DecimalFormat("0.00");
            df.setMaximumFractionDigits(2);
            double costoN = 0.00;
            String spedizione = null;
            ProductDAO productdao = (ProductDAO) request.getSession().getAttribute("productdao");
            
            double pesoTot = productdao.getTotalWeightOfCart(request);

            if (ritiro != true) {
                /*costoN += (df.parse(costo).doubleValue());
                if (productdao.getFreshProductsOfCart(request) == null || productdao.getFreshProductsOfCart(request).isEmpty()) {
                if (costoN <= MIN_COSTO) {
                spedizione = "" + MIN_PRICE;
                } else if (costoN > MIN_COSTO && costoN <= MED_COSTO) {
                spedizione = "" + MED_PRICE;
                } else if (costoN > MED_COSTO && costoN < MAX_COSTO) {
                spedizione = "" + MAX_PRICE;
                } else if (costoN >= MAX_COSTO) {
                spedizione = "0.00";
                }
                } else {
                if (costoN <= MIN_COSTO) {
                spedizione = "" + (MIN_PRICE + MIN_W_PRICE);
                } else if (costoN > MIN_COSTO && costoN <= MED_COSTO) {
                spedizione = "" + (MED_PRICE + MED_W_PRICE);
                } else if (costoN > MED_COSTO && costoN < MAX_COSTO) {
                spedizione = "" + (MAX_PRICE + MAX_W_PRICE);
                } else if (costoN >= MAX_COSTO) {
                spedizione = String.format("%.2f", MAX_W_PRICE).replace(",", ".");
                }
                }*/
                
                if (productdao.getFreshProductsOfCart(request) == null || productdao.getFreshProductsOfCart(request).isEmpty()) {
                    if (pesoTot <= MIN_PESO) {
                        spedizione = "" + MIN_PRICE;
                    } else if (pesoTot > MIN_PESO && pesoTot <= MED_PESO) {
                        spedizione = "" + MED_PRICE;
                    } else if (pesoTot > MED_PESO && pesoTot < MAX_PESO) {
                        spedizione = "" + MAX_PRICE;
                    } else if (pesoTot >= MAX_PESO) {
                        spedizione = "0.00";
                    }
                } else {
                    if (pesoTot <= MIN_PESO) {
                        spedizione = "" + (MIN_PRICE + MIN_W_PRICE);
                    } else if (pesoTot > MIN_PESO && pesoTot <= MED_PESO) {
                        spedizione = "" + (MED_PRICE + MED_W_PRICE);
                    } else if (pesoTot > MED_PESO && pesoTot < MAX_PESO) {
                        spedizione = "" + (MAX_PRICE + MAX_W_PRICE);
                    } else if (pesoTot >= MAX_PESO) {
                        spedizione = String.format("%.2f", MAX_W_PRICE).replace(",", ".");
                    }
                }
            } else {
                spedizione = "0.00";
            }
            return String.format("%.2f", Double.parseDouble(spedizione)).replace(",", ".");
        }
    }

    /**
     * Metodo che restituisce il costo totale dell'ordine. Somma le spese della
     * spedizione con il costo dei prodotti.
     *
     * @param costo Indica il costo dei prodotti.
     * @param spedizioni Indica le spese totali di spedizione.
     * @return Ritrona una stringa uguale al costo totle dell'ordine con due
     * cifre decimali.
     * @throws DAOException
     */
    @Override
    public String getTot(String costo, String spedizioni) throws DAOException {
        checkCON();

        if (costo.isEmpty() || spedizioni.isEmpty()) {
            return "0.00";
        } else {
            spedizioni = spedizioni.replace(",", ".");
            costo = costo.replace(",", ".");
            double spedizioniD, totaleD;
            double totale;
            String totaleS;

            spedizioniD = Double.parseDouble(spedizioni);
            totaleD = Double.parseDouble(costo);
            totale = spedizioniD + totaleD;
            totaleS = String.format("%.2f", totale);
            return totaleS;
        }
    }

    /**
     * Ordine confermato. Invia un'email per confermare che l'utente ha completato
     * l'ordine. Viene chiamato nell'urlack dopo il pagamento
     * @param request
     * @param order_id
     * @throws DAOException
     */
    @Override
    public void orderConfirmed(HttpServletRequest request, String order_id) throws DAOException {
        checkCON();

        String id = "";

        if (order_id != null) {
            id = order_id;
        }
        id = id.toUpperCase();
        try {
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
            message.setSubject("Ordine Confermato");
            message.setText("ATTENZIONE!\nL'ordine" + id + " è stato \bCONFERMATO\b dall'utente");
            // Transport class is used to deliver the message to the recipients 
            Transport.send(message);
        } catch (MessagingException ex1) {
            System.out.println("Errore invio email");
        }
        request.getSession().removeAttribute("ORDER_ID");
    }

    /**
     * Ordine annullato. Invia un'email per confermare che l'utente ha annullato
     * l'ordine. Viene chiamato nell'urlack dopo il pagamento
     * @param request
     * @param order_id
     * @throws DAOException
     */
    @Override
    public void orderAnnulled(HttpServletRequest request, String order_id) throws DAOException {
        checkCON();

        String id = "";

        if (order_id != null) {
            id = " " + order_id;
        }
        id = id.toUpperCase();

        try {
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
            message.setSubject("Ordine Annullato");
            message.setText("ATTENZIONE!\nL'ordine" + id + " è stato ANNULLATO dall'utente");

            // Transport class is used to deliver the message to the recipients 
            Transport.send(message);
        } catch (MessagingException ex1) {
            System.out.println("Errore invio email");
        }
        request.getSession().removeAttribute("ORDER_ID");
    }

}
