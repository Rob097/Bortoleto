/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pagamento;

import database.daos.ConsoleDAO;
import database.daos.PagamentoDAO;
import database.daos.ProductDAO;
import database.entities.Prodotto;
import database.entities.Variante;
import database.exceptions.DAOException;
import database.factories.DAOFactory;
import database.jdbc.JDBCConsoleDAO;
import database.jdbc.JDBCPagamentoDAO;
import database.jdbc.JDBCProductDAO;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import tools.HashGeneratorUtils;
import static varie.Costanti.CART_COOKIE_MAX_AGE;
import static varie.Costanti.cookiesA;
import static varie.Costanti.MAC_MAIL;
import static varie.Costanti.MAC_PASS;
import static varie.Costanti.ROB_MAIL;
import static varie.Costanti.ROB_PASS;
import static varie.Costanti.SPACES_COOKIE;
import static varie.Costanti.sessionA;

/**
 * Servlet per il processo di pagamento
 *
 * @author Roberto97
 */
@SuppressWarnings("unchecked")
public class LastServlet extends HttpServlet {

    private static final long serialVersionUID = 6106269076155338045L;
    transient ProductDAO productdao = null;
    transient PagamentoDAO pagamentodao = null;
    transient ConsoleDAO consoledao = null;

    /**
     * Metodo per inizializzare i JDBCDAO e quindi la connessione con il DB
     *
     * @throws ServletException
     */
    @Override
    public void init() throws ServletException {
        try {
            //carica la Connessione inizializzata in JDBCDAOFactory, quindi ritorna il Class.for() e la connessione
            DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
            if (daoFactory == null) {
                throw new ServletException("Impossible to get dao factory for user storage system");
            }
            //assegna a userdao la connessione(costruttore) e salva la connessione in una variabile tipo Connection
            productdao = new JDBCProductDAO(daoFactory.getConnection());
            pagamentodao = new JDBCPagamentoDAO(daoFactory.getConnection());
            consoledao = new JDBCConsoleDAO(daoFactory.getConnection());
        } catch (SQLException ex) {
            Logger.getLogger(LastServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * Vengono ricercati tutti i parametri assicurandosi che non siano null.<br>
     * Vengono recuperati tutti i prodotti dal carrello e calcolato il
     * totale.<br>
     * Vengono poi realizzate le varie stringhe e parametri richiesti dal
     * sistema di pagamento.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession s = request.getSession();
        try {

            String nome = "", cognome = "", email = "", indirizzo = "", citta = "", zip = "", note = "Nessuna nota";
            String corriere;
            Boolean checkKEAT = false;
            ArrayList<Prodotto> carrello;
            LinkedHashMap<ArrayList<Variante>, Integer> prodVar;
            if (request.getParameter("nome") != null) {
                nome = request.getParameter("nome");
            }
            if (request.getParameter("cognome") != null) {
                cognome = request.getParameter("cognome");
            }
            if (request.getParameter("email") != null) {
                email = request.getParameter("email");
            }
            if (request.getParameter("indirizzo") != null) {
                indirizzo = request.getParameter("indirizzo");
            }
            if (request.getParameter("citta") != null) {
                citta = request.getParameter("citta");
            }
            if (request.getParameter("zip") != null) {
                zip = request.getParameter("zip");
            }
            if (request.getParameter("note") != null) {
                note = request.getParameter("note");
            }

            if (request.getParameter("save") != null && request.getParameter("save").equals("true")) {
                saveDati(request, response, nome, cognome, email, indirizzo, citta, zip);
            }
            if (request.getParameter("subscribe") != null && request.getParameter("subscribe").equals("true") && email != null && !email.equals("")) {                
                consoledao.add_updateEmailSub(email);
            }

            carrello = productdao.getAllProductsOfCart(request);
            String subTotale = productdao.getTotalOfCart(request);
            boolean ritiro = false;
            if (s.getAttribute("ritiroAttribute") != null) {
                ritiro = (boolean) s.getAttribute("ritiroAttribute");
            }
            String spedizione = pagamentodao.getSpeseSpedizione(subTotale, ritiro, request);
            if (!ritiro) {
                if (productdao.getFreshProductsOfCart(request) == null || productdao.getFreshProductsOfCart(request).isEmpty()) {
                    corriere = "Normale";
                } else {
                    corriere = "Refrigerato";
                    checkKEAT = true;
                }
            } else {
                corriere = "Ritiro in negozio";
            }

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("ddMMyyyyHHmmss");
            LocalDateTime today = LocalDateTime.now();
            String data = formatter.format(today);

            //Parametri di test
            String totale = "0,01", divisa = "EUR", merchant_id = "405206400002", key = "E5D49168DEAA74078B22524B02360B6B", abi = "03599", prodotti = "", ordine = "Bortol" + data;

            //Parametri ufficiali
            //String totale = pagamentodao.getTot(subTotale, spedizioni), divisa = "EUR", merchant_id = "301109900006", key = "A986E2E45F4E66261CCCFFD978386D1E", abi = "08184", prodotti = "", ordine = "Bortol" + data1;
            String costo;
            int q;
            if (carrello != null) {
                for (Prodotto p : carrello) {
                    q = 0;
                    prodVar = productdao.getCartProductVariant(request, p.getId());
                    if (prodVar != null && !prodVar.isEmpty()) {
                        for (Map.Entry<ArrayList<Variante>, Integer> entry : prodVar.entrySet()) {
                            q += entry.getValue();
                        }
                    } else {
                        q = p.getQuantita();
                    }
                    costo = p.getCosto().replace(",", ".");
                    prodotti += p.getNome() + "^" + p.getDescrizione() + "^" + q + "^" + costo + "^" + divisa + ";";
                    //importo += parziale;
                }
                if (checkKEAT) {
                    prodotti += "Spedizione Keatchen" + "^" + "Kit spedizione alimenti freschi Keatchen" + "^" + "1" + "^" + productdao.checkWeight(request) + "^" + divisa + ";";
                }
            }
            //prodotti = "Carre affumicato^Fette di carre di maiale affumicato. Peso tra i 250 e i 300 grammi.^1^4.00^EUR;";
            totale = totale.replace(".", ",");
            String MAC_dec = merchant_id + ordine + totale + divisa + abi + prodotti + key;
            String Mac = HashGeneratorUtils.generateSHA256(MAC_dec);
            String MAC = Mac.toUpperCase();

            s.setAttribute("MERCHANT_ID", merchant_id);
            s.setAttribute("ORDER_ID", ordine);
            s.setAttribute("IMPORTO", totale);
            s.setAttribute("DIVISA", divisa);
            s.setAttribute("ABI", abi);
            s.setAttribute("ITEMS", prodotti);
            s.setAttribute("URLOK", "http://www.macelleriadellantonio.it/Bortoleto/PaymentPages/urlOk.jsp");
            s.setAttribute("URLKO", "http://www.macelleriadellantonio.it/Bortoleto/PaymentPages/urlKo.jsp");
            s.setAttribute("URLACK", "http://www.macelleriadellantonio.it/Bortoleto/Urlack");
            s.setAttribute("URLNACK", "http://www.macelleriadellantonio.it/Bortoleto/Urlnack");
            s.setAttribute("MAC", MAC);
            s.setAttribute("LINGUA", "ita");

            s.setAttribute("NOME", nome);
            s.setAttribute("COGNOME", cognome);
            s.setAttribute("CITTA", citta);
            s.setAttribute("INDIRIZZO", indirizzo);
            s.setAttribute("ZIP", zip);
            s.setAttribute("NOTE", note);
            s.setAttribute("SPEDIZIONE", spedizione);
            s.setAttribute("SUB", subTotale);
            s.setAttribute("CART", carrello);
            s.setAttribute("EMAIL", email);
            s.setAttribute("DELI", corriere);

            /*Le operazioni fatte da qui in poi seervono perchè con il passaggio 
            al sito della banca non si salva ne la sessione nei cookie da poter
            utilizzare nell'urlack dove si salvano i dati per la console*/
 /* Se non esiste il cookie DELI per il tipo di spedizione lo crea, altrimenti lo aggiorna */
            Cookie[] cookies = request.getCookies();
            boolean check = false;
            if (cookies != null) {
                for (Cookie cc : cookies) {
                    if (cc.getName().equals("DELI")) {
                        cc.setValue(corriere);
                        cc.setMaxAge(CART_COOKIE_MAX_AGE);
                        cc.setPath(request.getContextPath());
                        response.addCookie(cc);
                        check = true;
                    }
                }
            }
            if (!check) {
                Cookie c = new Cookie("DELI", corriere);
                c.setMaxAge(CART_COOKIE_MAX_AGE);
                c.setPath(request.getContextPath());
                response.addCookie(c);
            }

            Cookie[] a = request.getCookies();

            // aggiungo alla costante globale l'array di cookies
            cookiesA.put(ordine, a);

            //Aggiungo alla costante globale tutti gli attributi di sessione identificati
            //dall'id dell'ordine
            Enumeration<String> e = s.getAttributeNames();
            Map<String, Object> ses = new HashMap<>();

            if (e != null) {
                while (e.hasMoreElements()) {
                    Object tring;
                    if ((tring = e.nextElement()) != null) {
                        ses.put((String) tring, s.getAttribute((String) tring));
                    }
                }
            }

            sessionA.put(ordine, ses);

            sendEmail(request, response, corriere);
            response.sendRedirect("/Bortoleto/ajax/sendBank.jsp");
        } catch (DAOException ex) {
            Logger.getLogger(LastServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Questo metodo viene usato se l'utente ha selezionato la spunta per
     * salvare i propri dati. In questo caso vengono creati appositi cookie e
     * attributi di sessione.
     *
     * @param request
     * @param response
     * @param args
     * @throws java.io.UnsupportedEncodingException
     */
    public void saveDati(HttpServletRequest request, HttpServletResponse response, String... args) throws UnsupportedEncodingException {
        String[] nomi = {"nome", "cognome", "email", "indirizzo", "citta", "zip"};
        String s, s1;
        for (int i = 0; i < args.length; i++) {
            s = args[i];
            s1 = nomi[i];
            s = s.replace(" ", SPACES_COOKIE);
            Cookie c = new Cookie(s1, s);
            c.setMaxAge(CART_COOKIE_MAX_AGE);
            c.setPath(request.getContextPath());
            response.addCookie(c);
        }
    }

    public void sendEmail(HttpServletRequest request, HttpServletResponse response, String corriere) throws DAOException {
        HttpSession s = request.getSession(false);
        String corpo, varianti = "";

        if (s.getAttribute("varianti") != null) {
            varianti = (String) s.getAttribute("varianti");
        }

        LinkedHashMap<ArrayList<Variante>, Integer> prodVars;
        LinkedHashMap<ArrayList<Variante>, Integer> prodVariant;
        boolean check;

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        LocalDateTime today = LocalDateTime.now().plusHours(2);
        String data = formatter.format(today);

        corpo = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n"
                + "<html style=\"width:100%;font-family:arial, 'helvetica neue', helvetica, sans-serif;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%;padding:0;Margin:0;\">\n"
                + " <head> \n"
                + "  <meta charset=\"UTF-8\"> \n"
                + "  <meta content=\"width=device-width, initial-scale=1\" name=\"viewport\"> \n"
                + "  <meta name=\"x-apple-disable-message-reformatting\"> \n"
                + "  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> \n"
                + "  <meta content=\"telephone=no\" name=\"format-detection\"> \n"
                + "  <title>Ordine confermato</title> \n"
                + "  <!--[if (mso 16)]>\n"
                + "    <style type=\"text/css\">\n"
                + "    a {text-decoration: none;}\n"
                + "    </style>\n"
                + "    <![endif]--> \n"
                + "  <!--[if gte mso 9]><style>sup { font-size: 100% !important; }</style><![endif]--> \n"
                + "  <style type=\"text/css\">\n"
                + "@media only screen and (max-width:600px) {p, ul li, ol li, a { font-size:16px!important; line-height:150%!important } h1 { font-size:30px!important; text-align:center; line-height:120%!important } h2 { font-size:26px!important; text-align:center; line-height:120%!important } h3 { font-size:20px!important; text-align:center; line-height:120%!important } h1 a { font-size:30px!important } h2 a { font-size:26px!important } h3 a { font-size:20px!important } .es-header-body p, .es-header-body ul li, .es-header-body ol li, .es-header-body a { font-size:16px!important } .es-footer-body p, .es-footer-body ul li, .es-footer-body ol li, .es-footer-body a { font-size:16px!important } .es-infoblock p, .es-infoblock ul li, .es-infoblock ol li, .es-infoblock a { font-size:12px!important } *[class=\"gmail-fix\"] { display:none!important } .es-m-txt-c, .es-m-txt-c h1, .es-m-txt-c h2, .es-m-txt-c h3 { text-align:center!important } .es-m-txt-r, .es-m-txt-r h1, .es-m-txt-r h2, .es-m-txt-r h3 { text-align:right!important } .es-m-txt-l, .es-m-txt-l h1, .es-m-txt-l h2, .es-m-txt-l h3 { text-align:left!important } .es-m-txt-r img, .es-m-txt-c img, .es-m-txt-l img { display:inline!important } .es-button-border { display:block!important } a.es-button { font-size:20px!important; display:block!important; border-left-width:0px!important; border-right-width:0px!important } .es-btn-fw { border-width:10px 0px!important; text-align:center!important } .es-adaptive table, .es-btn-fw, .es-btn-fw-brdr, .es-left, .es-right { width:100%!important } .es-content table, .es-header table, .es-footer table, .es-content, .es-footer, .es-header { width:100%!important; max-width:600px!important } .es-adapt-td { display:block!important; width:100%!important } .adapt-img { width:100%!important; height:auto!important } .es-m-p0 { padding:0px!important } .es-m-p0r { padding-right:0px!important } .es-m-p0l { padding-left:0px!important } .es-m-p0t { padding-top:0px!important } .es-m-p0b { padding-bottom:0!important } .es-m-p20b { padding-bottom:20px!important } .es-mobile-hidden, .es-hidden { display:none!important } .es-desk-hidden { display:table-row!important; width:auto!important; overflow:visible!important; float:none!important; max-height:inherit!important; line-height:inherit!important } .es-desk-menu-hidden { display:table-cell!important } table.es-table-not-adapt, .esd-block-html table { width:auto!important } table.es-social { display:inline-block!important } table.es-social td { display:inline-block!important } .es-menu td a { font-size:16px!important } }\n"
                + "#outlook a {\n"
                + "	padding:0;\n"
                + "}\n"
                + ".ExternalClass {\n"
                + "	width:100%;\n"
                + "}\n"
                + ".ExternalClass,\n"
                + ".ExternalClass p,\n"
                + ".ExternalClass span,\n"
                + ".ExternalClass font,\n"
                + ".ExternalClass td,\n"
                + ".ExternalClass div {\n"
                + "	line-height:100%;\n"
                + "}\n"
                + ".es-button {\n"
                + "	mso-style-priority:100!important;\n"
                + "	text-decoration:none!important;\n"
                + "}\n"
                + "a[x-apple-data-detectors] {\n"
                + "	color:inherit!important;\n"
                + "	text-decoration:none!important;\n"
                + "	font-size:inherit!important;\n"
                + "	font-family:inherit!important;\n"
                + "	font-weight:inherit!important;\n"
                + "	line-height:inherit!important;\n"
                + "}\n"
                + ".es-desk-hidden {\n"
                + "	display:none;\n"
                + "	float:left;\n"
                + "	overflow:hidden;\n"
                + "	width:0;\n"
                + "	max-height:0;\n"
                + "	line-height:0;\n"
                + "	mso-hide:all;\n"
                + "}\n"
                + "</style> \n"
                + " </head> \n"
                + " <body style=\"width:100%;font-family:arial, 'helvetica neue', helvetica, sans-serif;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%;padding:0;Margin:0;\"> \n"
                + "  <div class=\"es-wrapper-color\" style=\"background-color:#EFEFEF;\"> \n"
                + "   <!--[if gte mso 9]>\n"
                + "			<v:background xmlns:v=\"urn:schemas-microsoft-com:vml\" fill=\"t\">\n"
                + "				<v:fill type=\"tile\" color=\"#efefef\"></v:fill>\n"
                + "			</v:background>\n"
                + "		<![endif]--> \n"
                + "   <table class=\"es-wrapper\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;padding:0;Margin:0;width:100%;height:100%;background-repeat:repeat;background-position:center top;\"> \n"
                + "     <tr style=\"border-collapse:collapse;\"> \n"
                + "      <td valign=\"top\" style=\"padding:0;Margin:0;\"> \n"
                + "       <table class=\"es-header\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;table-layout:fixed !important;width:100%;background-color:transparent;background-repeat:repeat;background-position:center top;\"> \n"
                + "         <tr style=\"border-collapse:collapse;\"> \n"
                + "          <td align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                + "           <table class=\"es-header-body\" width=\"600\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#e0e4ee\" align=\"center\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:#E0E4EE;\"> \n"
                + "             <tr style=\"border-collapse:collapse;\"> \n"
                + "              <td align=\"left\" style=\"padding:0;Margin:0;padding-top:20px;padding-left:20px;padding-right:20px;\"> \n"
                + "               <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                 <tr style=\"border-collapse:collapse;\"> \n"
                + "                  <td width=\"560\" align=\"center\" valign=\"top\" style=\"padding:0;Margin:0;\"> \n"
                + "                   <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                     <tr style=\"border-collapse:collapse;\"> \n"
                + "                      <td align=\"center\" style=\"padding:0;Margin:0;\"> <img class=\"adapt-img\" src=\"https://vwtlr.stripocdn.email/content/guids/CABINET_b66a35fa6445bf0f273221a1ba934a17/images/80041558079279254.png\" alt style=\"display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic;\" width=\"200\"></td> \n"
                + "                     </tr> \n"
                + "                   </table> </td> \n"
                + "                 </tr> \n"
                + "               </table> </td> \n"
                + "             </tr> \n"
                + "           </table> </td> \n"
                + "         </tr> \n"
                + "       </table> \n"
                + "       <table class=\"es-content\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;table-layout:fixed !important;width:100%;\"> \n"
                + "         <tr style=\"border-collapse:collapse;\"> \n"
                + "          <td align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                + "           <table class=\"es-content-body\" width=\"600\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#e0e4ee\" align=\"center\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:#E0E4EE;\"> \n"
                + "             <tr style=\"border-collapse:collapse;\"> \n"
                + "              <td align=\"left\" style=\"Margin:0;padding-top:10px;padding-bottom:10px;padding-left:20px;padding-right:20px;\"> \n"
                + "               <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                 <tr style=\"border-collapse:collapse;\"> \n"
                + "                  <td width=\"560\" valign=\"top\" align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                + "                   <table style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:separate;border-spacing:0px;border-radius:0px;\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\"> \n"
                + "                     <tr style=\"border-collapse:collapse;\"> \n"
                + "                      <td align=\"center\" style=\"padding:0;Margin:0;padding-top:10px;padding-bottom:15px;\"> <h1 style=\"Margin:0;line-height:36px;mso-line-height-rule:exactly;font-family:'trebuchet ms', helvetica, sans-serif;font-size:30px;font-style:normal;font-weight:normal;color:#333333;\">Nuovo richiesta di ordine</h1><br><a href=\"https://www.servizipos.it/merchant-console-web/faces/pages/portal.xhtml\" target=\"_blank\">Accertarsi della conferma dell'ordine da parte del cliente</a> </td> \n"
                + "                     </tr> \n"
                + "                     <tr style=\"border-collapse:collapse;\"> \n"
                + "                      <td align=\"center\" style=\"padding:0;Margin:0;padding-bottom:10px;padding-top:15px;\"> <span class=\"es-button-border\" style=\"border-style:solid;border-color:#2CB543;background:#D48344 none repeat scroll 0% 0%;border-width:0px;display:inline-block;border-radius:5px;width:auto;border-top:0px solid #2CB543;border-bottom:0px solid #2CB543;\"> <a href=\"http://www.macelleriadellantonio.it/console/ordine.jsp?id="+s.getAttribute("ORDER_ID")+"\" class=\"es-button\" target=\"_blank\" style=\"mso-style-priority:100 !important;text-decoration:underline;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;font-size:16px;color:#FFFFFF;border-style:solid;border-color:#D48344;border-width:10px 20px 10px 20px;display:inline-block;background:#D48344 none repeat scroll 0% 0%;border-radius:5px;font-weight:normal;font-style:normal;line-height:19px;width:auto;text-align:center;border-top-width:10px;border-bottom-width:10px;\">Vedi lo stato dell'ordine</a> </span> </td> \n"
                + "                     </tr> \n"
                + "                   </table> </td> \n"
                + "                 </tr> \n"
                + "               </table> </td> \n"
                + "             </tr> \n"
                + "           </table> </td> \n"
                + "         </tr> \n"
                + "       </table> \n"
                + "       <table class=\"es-content\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;table-layout:fixed !important;width:100%;\"> \n"
                + "         <tr style=\"border-collapse:collapse;\"> \n"
                + "          <td align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                + "           <table class=\"es-content-body\" width=\"600\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#e0e4ee\" align=\"center\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:#E0E4EE;\"> \n"
                + "             <tr style=\"border-collapse:collapse;\"> \n"
                + "              <td align=\"left\" style=\"Margin:0;padding-top:20px;padding-left:20px;padding-right:20px;padding-bottom:30px;\"> \n"
                + "               <!--[if mso]><table width=\"560\" cellpadding=\"0\" cellspacing=\"0\"><tr><td width=\"280\" valign=\"top\"><![endif]--> \n"
                + "               <table class=\"es-left\" cellspacing=\"0\" cellpadding=\"0\" align=\"left\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left;\"> \n"
                + "                 <tr style=\"border-collapse:collapse;\"> \n"
                + "                  <td class=\"es-m-p20b\" width=\"280\" align=\"left\" style=\"padding:0;Margin:0;\"> \n"
                + "                   <table style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:separate;border-spacing:0px;background-color:#FEF9EF;border-color:#EFEFEF;border-width:1px 0px 1px 1px;border-style:solid;\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#fef9ef\"> \n"
                + "                     <tr style=\"border-collapse:collapse;\"> \n"
                + "                      <td align=\"left\" style=\"Margin:0;padding-bottom:10px;padding-top:20px;padding-left:20px;padding-right:20px;\"> <h4 style=\"Margin:0;line-height:120%;mso-line-height-rule:exactly;font-family:'trebuchet ms', helvetica, sans-serif;\">Dati ordine:</h4> </td> \n"
                + "                     </tr> \n"
                + "                     <tr style=\"border-collapse:collapse;\"> \n"
                + "                      <td align=\"left\" style=\"padding:0;Margin:0;padding-bottom:20px;padding-left:20px;padding-right:20px;\">\n"
                + "                       <table style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:100%;\" class=\"cke_show_border\" cellspacing=\"1\" cellpadding=\"1\" border=\"0\" align=\"left\"> \n"
                + "                         <tr style=\"border-collapse:collapse;\"> \n"
                + "                          <td style=\"padding:0;Margin:0;font-size:14px;line-height:21px;\">Ordine n°:</td> \n"
                + "                          <td style=\"padding:0;Margin:0;font-size:14px;line-height:21px;\">" + s.getAttribute("ORDER_ID") + "</td> \n"
                + "                         </tr> \n"
                + "                         <tr style=\"border-collapse:collapse;\"> \n"
                + "                          <td style=\"padding:0;Margin:0;font-size:14px;line-height:21px;\">Data:</td> \n"
                + "                          <td style=\"padding:0;Margin:0;font-size:14px;line-height:21px;\">" + data + "</td> \n"
                + "                         </tr> \n"
                + "                         <tr style=\"border-collapse:collapse;\"> \n"
                + "                          <td style=\"padding:0;Margin:0;font-size:14px;line-height:21px;\">Totale:</td> \n"
                + "                          <td style=\"padding:0;Margin:0;font-size:14px;line-height:21px;\">&euro; " + s.getAttribute("IMPORTO") + "</td> \n"
                + "                         </tr> \n"
                + "                         <tr style=\"border-collapse:collapse;\"> \n"
                + "                          <td style=\"padding:0;Margin:0;font-size:14px;line-height:21px;\">Corriere:</td> \n"
                + "                          <td style=\"padding:0;Margin:0;font-size:14px;line-height:21px;\">" + corriere + "</td> \n"
                + "                         </tr> \n"
                + "                       </table><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;color:#333333;\"><br></p> </td> \n"
                + "                     </tr> \n"
                + "                   </table> </td> \n"
                + "                 </tr> \n"
                + "               </table> \n"
                + "               <!--[if mso]></td><td width=\"0\"></td><td width=\"280\" valign=\"top\"><![endif]--> \n"
                + "               <table class=\"es-right\" cellspacing=\"0\" cellpadding=\"0\" align=\"right\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:right;\"> \n"
                + "                 <tr style=\"border-collapse:collapse;\"> \n"
                + "                  <td width=\"280\" align=\"left\" style=\"padding:0;Margin:0;\"> \n"
                + "                   <table style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:separate;border-spacing:0px;background-color:#FEF9EF;border-width:1px;border-style:solid;border-color:#EFEFEF;\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#fef9ef\"> \n"
                + "                     <tr style=\"border-collapse:collapse;\"> \n"
                + "                      <td align=\"left\" style=\"Margin:0;padding-bottom:10px;padding-top:20px;padding-left:20px;padding-right:20px;\"> <h4 style=\"Margin:0;line-height:120%;mso-line-height-rule:exactly;font-family:'trebuchet ms', helvetica, sans-serif;\">Dati cliente:</h4> </td> \n"
                + "                     </tr> \n"
                + "                     <tr style=\"border-collapse:collapse;\"> \n"
                + "                      <td align=\"left\" style=\"padding:0;Margin:0;padding-bottom:20px;padding-left:20px;padding-right:20px;\"> <p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;color:#333333;\">" + s.getAttribute("NOME") + " " + s.getAttribute("COGNOME") + "</p><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;color:#333333;\">" + s.getAttribute("EMAIL") + "</p><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;color:#333333;\">" + s.getAttribute("INDIRIZZO") + "</p><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;color:#333333;\">" + s.getAttribute("CITTA") + ", " + s.getAttribute("ZIP") + "</p> </td> \n"
                + "                     </tr> \n"
                + "                   </table> </td> \n"
                + "                 </tr> \n"
                + "               </table> \n"
                + "               <!--[if mso]></td></tr></table><![endif]--> </td> \n"
                + "             </tr> \n"
                + "           </table> </td> \n"
                + "         </tr> \n"
                + "       </table> \n"
                + "       <table class=\"es-content\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;table-layout:fixed !important;width:100%;\"> \n"
                + "         <tr style=\"border-collapse:collapse;\"> \n"
                + "          <td align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                + "           <table class=\"es-content-body\" width=\"600\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#ffffff\" align=\"center\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:#FFFFFF;\"> \n"
                + "             <tr style=\"border-collapse:collapse;\"> \n"
                + "              <td align=\"left\" style=\"Margin:0;padding-top:10px;padding-bottom:10px;padding-left:20px;padding-right:20px;\"> \n"
                + "               <!--[if mso]><table width=\"560\" cellpadding=\"0\" cellspacing=\"0\"><tr><td width=\"270\" valign=\"top\"><![endif]--> \n"
                + "               <table class=\"es-left\" cellspacing=\"0\" cellpadding=\"0\" align=\"left\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left;\"> \n"
                + "                 <tr style=\"border-collapse:collapse;\"> \n"
                + "                  <td class=\"es-m-p0r es-m-p20b\" width=\"270\" valign=\"top\" align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                     <tr style=\"border-collapse:collapse;\"> \n"
                + "                      <td align=\"left\" style=\"padding:0;Margin:0;padding-left:20px;\"> <h4 style=\"Margin:0;line-height:120%;mso-line-height-rule:exactly;font-family:'trebuchet ms', helvetica, sans-serif;\">Prodotto</h4> </td> \n"
                + "                     </tr> \n"
                + "                   </table> </td> \n"
                + "                 </tr> \n"
                + "               </table> \n"
                + "               <!--[if mso]></td><td width=\"20\"></td><td width=\"270\" valign=\"top\"><![endif]--> \n"
                + "               <table cellspacing=\"0\" cellpadding=\"0\" align=\"right\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                 <tr style=\"border-collapse:collapse;\"> \n"
                + "                  <td width=\"270\" align=\"left\" style=\"padding:0;Margin:0;\"> \n"
                + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                     <tr style=\"border-collapse:collapse;\"> \n"
                + "                      <td align=\"left\" style=\"padding:0;Margin:0;\"> \n"
                + "                       <table style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:100%;\" class=\"cke_show_border\" cellspacing=\"1\" cellpadding=\"1\" border=\"0\"> \n"
                + "                         <tr style=\"border-collapse:collapse;\"> \n"
                + "                          <td style=\"padding:0;Margin:0;\">Nome</td> \n"
                + "                          <td style=\"padding:0;Margin:0;text-align:center;\" width=\"60\"><span style=\"font-size:13px;\"><span style=\"line-height:100%;\">Quantità</span></span></td> \n"
                + "                          <td style=\"padding:0;Margin:0;text-align:center;\" width=\"100\"><span style=\"font-size:13px;\"><span style=\"line-height:100%;\">Prezzo</span></span></td> \n"
                + "                         </tr> \n"
                + "                       </table> </td> \n"
                + "                     </tr> \n"
                + "                   </table> </td> \n"
                + "                 </tr> \n"
                + "               </table> \n"
                + "               <!--[if mso]></td></tr></table><![endif]--> </td> \n"
                + "             </tr> \n"
                + "             <tr style=\"border-collapse:collapse;\"> \n"
                + "              <td align=\"left\" style=\"padding:0;Margin:0;padding-left:20px;padding-right:20px;\"> \n"
                + "               <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                 <tr style=\"border-collapse:collapse;\"> \n"
                + "                  <td width=\"560\" valign=\"top\" align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                     <tr style=\"border-collapse:collapse;\"> \n"
                + "                      <td align=\"center\" style=\"padding:0;Margin:0;padding-bottom:10px;\"> \n"
                + "                       <table width=\"100%\" height=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                         <tr style=\"border-collapse:collapse;\"> \n"
                + "                          <td style=\"padding:0;Margin:0px;border-bottom:1px solid #EFEFEF;background:rgba(0, 0, 0, 0) none repeat scroll 0% 0%;height:1px;width:100%;margin:0px;\"></td> \n"
                + "                         </tr> \n"
                + "                       </table> </td> \n"
                + "                     </tr> \n"
                + "                   </table> </td> \n"
                + "                 </tr> \n"
                + "               </table> </td> \n"
                + "             </tr> \n"
                + "        <!-- INIZIO PRODOTTO -->\n";
        ArrayList<Prodotto> carrello;
        int items = 0, quant;
        double costo;
        String costoS;
        if (s.getAttribute("CART") != null) {
            carrello = ((ArrayList<Prodotto>) s.getAttribute("CART"));
            for (Prodotto p : carrello) {
                quant = 0;
                costo = 0;
                prodVariant = new LinkedHashMap<>();
                check = false;
                prodVars = consoledao.getVariants(varianti);
                if (prodVars != null && !prodVars.isEmpty()) {
                    for (Map.Entry<ArrayList<Variante>, Integer> entry : prodVars.entrySet()) {
                        ArrayList<Variante> key = entry.getKey();
                        Integer value = entry.getValue();
                        if (key != null && !key.isEmpty()) {
                            if (key.get(0).getId_prod() == p.getId()) {
                                check = true;
                                quant += value;
                                prodVariant.put(key, value);
                                costo = key.stream().map((v) -> v.getSupplement() * value).reduce(costo, (accumulator, _item) -> accumulator + _item);
                                costo += Double.parseDouble(p.getCosto().replace(",", ".")) * value;
                            }
                        }
                    }
                }
                costoS = String.format("%.2f", costo);
                if (!check) {       
                    quant = p.getQuantita();
                    costo = Double.parseDouble(p.getCosto().replace(",", "."));
                    costoS = String.format("%.2f", costo * items);
                }
                items += quant;

                corpo
                        += "             <tr style=\"border-collapse:collapse;\"> \n"
                        + "              <td align=\"left\" style=\"Margin:0;padding-top:5px;padding-bottom:10px;padding-left:20px;padding-right:20px;\"> \n"
                        + "               <!--[if mso]><table width=\"560\" cellpadding=\"0\" cellspacing=\"0\"><tr><td width=\"178\" valign=\"top\"><![endif]--> \n"
                        + "               <table class=\"es-left\" cellspacing=\"0\" cellpadding=\"0\" align=\"left\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left;\"> \n"
                        + "                 <tr style=\"border-collapse:collapse;\"> \n"
                        + "                  <td class=\"es-m-p0r es-m-p20b\" width=\"178\" valign=\"top\" align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                        + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                        + "                     <tr style=\"border-collapse:collapse;\"> \n"
                        + "                      <td align=\"center\" style=\"padding:0;Margin:0;\"> <img src=http://www.macelleriadellantonio.it/console/" + p.getImmagine() + " alt=\"" + p.getNome() + "\" class=\"adapt-img\" title=\"" + p.getNome() + "\" width=\"125\" style=\"display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic;\"></td> \n"
                        + "                     </tr> \n"
                        + "                   </table> </td> \n"
                        + "                 </tr> \n"
                        + "               </table> \n"
                        + "               <!--[if mso]></td><td width=\"20\"></td><td width=\"362\" valign=\"top\"><![endif]--> \n"
                        + "               <table cellspacing=\"0\" cellpadding=\"0\" align=\"right\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                        + "                 <tr style=\"border-collapse:collapse;\"> \n"
                        + "                  <td width=\"362\" align=\"left\" style=\"padding:0;Margin:0;\"> \n"
                        + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                        + "                     <tr style=\"border-collapse:collapse;\"> \n"
                        + "                      <td align=\"left\" style=\"padding:0;Margin:0;\"> <p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;color:#333333;\"><br></p>" + p.getNome() + " \n"
                        + "                       <table style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:100%;\" class=\"cke_show_border\" cellspacing=\"1\" cellpadding=\"1\" border=\"0\"> \n"
                        + "                         <tr style=\"border-collapse:collapse;\"> \n"
                        + "                          <td style=\"padding:0;Margin:0;\"></td> \n"
                        + "                          <td style=\"padding:0;Margin:0;text-align:center;\" width=\"60\">" + quant + "</td> \n"
                        + "                          <td style=\"padding:0;Margin:0;text-align:center;\" width=\"100\">&euro; " + costoS + "</td> \n"
                        + "                         </tr> \n"
                        + "                       </table><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;color:#333333;\"><br></p> </td> \n"
                        + "                     </tr> \n"
                        + "                   </table> </td> \n"
                        + "                 </tr> \n"
                        + "               </table> \n"
                        + "               <!--[if mso]></td></tr></table><![endif]--> </td> \n"
                        + "             </tr> \n"
                        + "        <!-- FINE PRODOTTO -->\n";
            }
            if (corriere.equals("Refrigerato")) {
                corpo
                        += "             <tr style=\"border-collapse:collapse;\"> \n"
                        + "              <td align=\"left\" style=\"Margin:0;padding-top:5px;padding-bottom:10px;padding-left:20px;padding-right:20px;\"> \n"
                        + "               <!--[if mso]><table width=\"560\" cellpadding=\"0\" cellspacing=\"0\"><tr><td width=\"178\" valign=\"top\"><![endif]--> \n"
                        + "               <table class=\"es-left\" cellspacing=\"0\" cellpadding=\"0\" align=\"left\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left;\"> \n"
                        + "                 <tr style=\"border-collapse:collapse;\"> \n"
                        + "                  <td class=\"es-m-p0r es-m-p20b\" width=\"178\" valign=\"top\" align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                        + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                        + "                     <tr style=\"border-collapse:collapse;\"> \n"
                        + "                      <td align=\"center\" style=\"padding:0;Margin:0;\"> <img src=\"https://lh3.googleusercontent.com/6QOIaGv5w7KSjKo8XuMGgg_aXFQPbjQUX1TADK7LBCmxvRvNQncQRs-xDhdOz8rxnDg1tHL-zuybheQTO5a-ad3TE1YkXASmHIY7zd1jVhLMzbJE-W1rD_7NwYN-phBCflLlXuRB5Q=w2400\" alt=\"Box KEATCKEN\" class=\"adapt-img\" title=\"Box KEATCKEN\" width=\"125\" style=\"display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic;\"></td> \n"
                        + "                     </tr> \n"
                        + "                   </table> </td> \n"
                        + "                 </tr> \n"
                        + "               </table> \n"
                        + "               <!--[if mso]></td><td width=\"20\"></td><td width=\"362\" valign=\"top\"><![endif]--> \n"
                        + "               <table cellspacing=\"0\" cellpadding=\"0\" align=\"right\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                        + "                 <tr style=\"border-collapse:collapse;\"> \n"
                        + "                  <td width=\"362\" align=\"left\" style=\"padding:0;Margin:0;\"> \n"
                        + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                        + "                     <tr style=\"border-collapse:collapse;\"> \n"
                        + "                      <td align=\"left\" style=\"padding:0;Margin:0;\"> <p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;color:#333333;\"><br></p>Kit spedizione alimenti freschi Keatchen\n"
                        + "                       <table style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:100%;\" class=\"cke_show_border\" cellspacing=\"1\" cellpadding=\"1\" border=\"0\"> \n"
                        + "                         <tr style=\"border-collapse:collapse;\"> \n"
                        + "                          <td style=\"padding:0;Margin:0;\"></td> \n"
                        + "                          <td style=\"padding:0;Margin:0;text-align:center;\" width=\"60\">" + productdao.getfreshBoxType(request) + "</td> \n"
                        + "                          <td style=\"padding:0;Margin:0;text-align:center;\" width=\"100\">&euro; " + productdao.checkWeight(request) + "</td> \n"
                        + "                         </tr> \n"
                        + "                       </table><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;color:#333333;\"><br></p> </td> \n"
                        + "                     </tr> \n"
                        + "                   </table> </td> \n"
                        + "                 </tr> \n"
                        + "               </table> \n"
                        + "               <!--[if mso]></td></tr></table><![endif]--> </td> \n"
                        + "             </tr> \n"
                        + "        <!-- FINE PRODOTTO -->\n";
            }
        } else {
            corpo += "             <tr style=\"border-collapse:collapse;\"> \n"
                    + "              <td align=\"left\" style=\"padding:0;Margin:0;padding-left:20px;padding-right:20px;\"> \n"
                    + "               <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                 <tr style=\"border-collapse:collapse;\"> \n"
                    + "                  <td width=\"560\" valign=\"top\" align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                    + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                     <tr style=\"border-collapse:collapse;\"> \n"
                    + "                      <td align=\"center\" style=\"padding:0;Margin:0;padding-bottom:10px;\"> \n"
                    + "                       <table width=\"100%\" height=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                         <tr style=\"border-collapse:collapse;\"> \n"
                    + "                          <td style=\"padding:0;Margin:0px;border-bottom:1px solid #EFEFEF;background:rgba(0, 0, 0, 0) none repeat scroll 0% 0%;height:1px;width:100%;margin:0px;\"></td> \n"
                    + "                         </tr> \n"
                    + "                       </table> </td> \n"
                    + "                     </tr> \n"
                    + "                   </table> </td> \n"
                    + "                 </tr> \n"
                    + "                 <tr style=\"border-collapse:collapse;\"> \n"
                    + "                  <td width=\"560\" align=\"center\" valign=\"top\" style=\"padding:0;Margin:0;\"> \n"
                    + "                   <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                     <tr style=\"border-collapse:collapse;\"> \n"
                    + "                      <td align=\"center\" style=\"padding:40px;Margin:0;\"> <p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:30px;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:45px;color:#333333;\">Ouch! Qualcosa non va!<br>Non ci sono prodotti acquistati.<br>Contattare " + s.getAttribute("EMAIL") + "  per maggiori informazioni</p> </td> \n"
                    + "                     </tr> \n"
                    + "                   </table> </td> \n"
                    + "                 </tr> \n"
                    + "               </table> </td> \n"
                    + "             </tr> \n";
        }
        String spedizione;
        if (s.getAttribute("SPEDIZIONE").equals("0.00")) {
            spedizione = "Ritiro in negozio";
        } else {
            spedizione = "&euro; " + (String) s.getAttribute("SPEDIZIONE");
        }
        corpo
                += "             <tr style=\"border-collapse:collapse;\"> \n"
                + "              <td align=\"left\" style=\"padding:0;Margin:0;padding-left:20px;padding-right:20px;\"> \n"
                + "               <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                 <tr style=\"border-collapse:collapse;\"> \n"
                + "                  <td width=\"560\" valign=\"top\" align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                     <tr style=\"border-collapse:collapse;\"> \n"
                + "                      <td align=\"center\" style=\"padding:0;Margin:0;padding-bottom:10px;\"> \n"
                + "                       <table width=\"100%\" height=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                         <tr style=\"border-collapse:collapse;\"> \n"
                + "                          <td style=\"padding:0;Margin:0px;border-bottom:1px solid #EFEFEF;background:rgba(0, 0, 0, 0) none repeat scroll 0% 0%;height:1px;width:100%;margin:0px;\"></td> \n"
                + "                         </tr> \n"
                + "                       </table> </td> \n"
                + "                     </tr> \n"
                + "                   </table> </td> \n"
                + "                 </tr> \n"
                + "               </table> </td> \n"
                + "             </tr> \n"
                + "          <tr style=\"border-collapse:collapse;\"> \n"
                + "              <td align=\"left\" style=\"padding:0;Margin:0;padding-left:20px;padding-right:20px;\"> \n"
                + "               <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                 <tr style=\"border-collapse:collapse;\"> \n"
                + "                  <td width=\"560\" valign=\"top\" align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                     <tr style=\"border-collapse:collapse;\"> \n"
                + "                      <td align=\"center\" style=\"padding:0;Margin:0;padding-bottom:10px;\"> \n"
                + "                       <table width=\"100%\" height=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                         <tr style=\"border-collapse:collapse;\"> \n"
                + "                          <td style=\"padding:0;Margin:0px;border-bottom:1px solid #EFEFEF;background:rgba(0, 0, 0, 0) none repeat scroll 0% 0%;height:1px;width:100%;margin:0px;\"></td> \n"
                + "                         </tr> \n"
                + "                       </table> </td> \n"
                + "                     </tr> \n"
                + "                   </table> </td> \n"
                + "                 </tr> \n"
                + "                 <tr style=\"border-collapse:collapse;\"> \n"
                + "                  <td width=\"560\" align=\"center\" valign=\"top\" style=\"padding:0;Margin:0;\"> \n"
                + "                   <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                     <tr style=\"border-collapse:collapse;\"> \n"
                + "                      <td align=\"left\" class=\"esd-block-text es-p5\"> <p style=\"padding: 20px;Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:15px;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:15px;color:#333333;\">NOTE DEL CLIENTE:<br><br>" + s.getAttribute("NOTE") + "</p> </td> \n"
                + "                     </tr> \n"
                + "                   </table> </td> \n"
                + "                 </tr> \n"
                + "               </table> </td> \n"
                + "             </tr> \n"
                + "             <tr style=\"border-collapse:collapse;\"> \n"
                + "              <td align=\"left\" style=\"padding:0;Margin:0;padding-left:20px;padding-right:20px;\"> \n"
                + "               <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                 <tr style=\"border-collapse:collapse;\"> \n"
                + "                  <td width=\"560\" valign=\"top\" align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                     <tr style=\"border-collapse:collapse;\"> \n"
                + "                      <td align=\"center\" style=\"padding:0;Margin:0;padding-bottom:10px;\"> \n"
                + "                       <table width=\"100%\" height=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                         <tr style=\"border-collapse:collapse;\"> \n"
                + "                          <td style=\"padding:0;Margin:0px;border-bottom:1px solid #EFEFEF;background:rgba(0, 0, 0, 0) none repeat scroll 0% 0%;height:1px;width:100%;margin:0px;\"></td> \n"
                + "                         </tr> \n"
                + "                       </table> </td> \n"
                + "                     </tr> \n"
                + "                   </table> </td> \n"
                + "                 </tr> \n"
                + "               </table> </td> \n"
                + "             </tr> \n"
                + "             <tr style=\"border-collapse:collapse;\"> \n"
                + "              <td align=\"left\" style=\"Margin:0;padding-top:5px;padding-left:20px;padding-bottom:30px;padding-right:40px;\"> \n"
                + "               <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                 <tr style=\"border-collapse:collapse;\"> \n"
                + "                  <td width=\"540\" valign=\"top\" align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                + "                     <tr style=\"border-collapse:collapse;\"> \n"
                + "                      <td align=\"right\" style=\"padding:0;Margin:0;\"> \n"
                + "                       <table style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:500px;\" class=\"cke_show_border\" cellspacing=\"1\" cellpadding=\"1\" border=\"0\" align=\"right\"> \n"
                + "                         <tr style=\"border-collapse:collapse;\"> \n"
                + "                          <td style=\"padding:0;Margin:0;text-align:right;font-size:18px;line-height:27px;\">Subtotale (" + items + " prodotti):</td> \n"
                + "                          <td style=\"padding:0;Margin:0;text-align:right;font-size:18px;line-height:27px;\">&euro; " + s.getAttribute("SUB") + "</td> \n"
                + "                         </tr> \n"
                + "                         <tr style=\"border-collapse:collapse;\"> \n"
                + "                          <td style=\"padding:0;Margin:0;text-align:right;font-size:18px;line-height:27px;\">Spedizione:</td> \n"
                + "                          <td style=\"padding:0;Margin:0;text-align:right;font-size:18px;line-height:27px;color:#D48344;\"><strong>" + spedizione + "</strong></td> \n"
                + "                         </tr> \n"
                + "                         <tr style=\"border-collapse:collapse;\"> \n"
                + "                          <td style=\"padding:0;Margin:0;text-align:right;font-size:18px;line-height:27px;\"><strong>Totale ordine:</strong></td> \n"
                + "                          <td style=\"padding:0;Margin:0;text-align:right;font-size:18px;line-height:27px;color:#D48344;\"><b>&euro; " + s.getAttribute("IMPORTO") + "</b></td> \n"
                + "                         </tr> \n"
                + "                       </table><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;color:#333333;\"><br></p> </td> \n"
                + "                     </tr> \n"
                + "                   </table> </td> \n"
                + "                 </tr> \n"
                + "               </table> </td> \n"
                + "             </tr> \n"
                + "           </table> </td> \n"
                + "         </tr> \n"
                + "       </table> </td> \n"
                + "     </tr> \n"
                + "   </table> \n"
                + "  </div>  \n"
                + " </body>\n"
                + "</html>";

        try {
            //Dati email Macelleria
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
            message.setSubject("Nuovo ordine online");

            Multipart mp = new MimeMultipart();
            MimeBodyPart htmlPart = new MimeBodyPart();
            htmlPart.setContent(corpo, "text/html");
            mp.addBodyPart(htmlPart);
            message.setContent(mp);

            // Transport class is used to deliver the message to the recipients 
            Transport.send(message);

        } catch (MessagingException ex) {
            String testo = "Nuovo ordine dal negozio online.\n\n";
            testo += "Ordine: " + s.getAttribute("ORDER_ID");
            testo += "\nData: " + data;
            testo += "\nCliente: " + s.getAttribute("NOME") + " " + s.getAttribute("COGNOME");
            testo += "\nIndirizzo: " + s.getAttribute("INDIRIZZO") + ", " + s.getAttribute("CITTA") + ", " + s.getAttribute("ZIP");
            testo += "\nNote: " + s.getAttribute("NOTE");

            items = 0;
            if (s.getAttribute("CART") != null) {
                carrello = ((ArrayList<Prodotto>) s.getAttribute("CART"));
                for (Prodotto p : carrello) {
                    items += p.getQuantita();
                    testo += "\n\n\bProdotto " + items + 1 + "\b";
                    testo += "\nNome: " + p.getNome();
                    testo += "\nQuantità: " + p.getQuantita();
                    testo += "\nCosto: " + p.getCosto();
                }
            }

            testo += "\n\nSubtotale(" + items + " articoli): " + s.getAttribute("SUB");
            testo += "\nSpedizione: " + spedizione;
            testo += "\nTotale: " + s.getAttribute("IMPORTO");
            //Dati email roberto
            try {
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
                message.setSubject("Nuova richiesta di oridne");
                message.setText(testo);

                // Transport class is used to deliver the message to the recipients 
                Transport.send(message);
            } catch (MessagingException ex1) {
                System.out.println("Errore invio email");
            }
        }
        /*s.removeAttribute("NOME");
        s.removeAttribute("COGNOME");
        s.removeAttribute("CITTA");
        s.removeAttribute("INDIRIZZO");
        s.removeAttribute("ZIP");
        s.removeAttribute("NOTE");
        s.removeAttribute("SUB");
        s.removeAttribute("SPEDIZIONE");
        s.removeAttribute("CART");*/
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet per il processo di pagamento";
    }// </editor-fold>

}
