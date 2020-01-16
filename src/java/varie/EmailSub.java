/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package varie;

import database.daos.ConsoleDAO;
import database.exceptions.DAOException;
import database.factories.DAOFactory;
import database.jdbc.JDBCConsoleDAO;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.SQLException;
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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import static varie.Costanti.MAC_MAIL;
import static varie.Costanti.MAC_PASS;
import static varie.Costanti.ROB_MAIL;
import static varie.Costanti.ROB_PASS;

/**
 *
 * @author Roberto97
 */
public class EmailSub extends HttpServlet {

    private static final long serialVersionUID = 1L;

    ConsoleDAO consoledao;

    @Override
    public void init() throws ServletException {
        try {
            //carica la Connessione inizializzata in JDBCDAOFactory, quindi ritorna il Class.for() e la connessione
            DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
            if (daoFactory == null) {
                throw new ServletException("Impossible to get dao factory for user storage system");
            }
            consoledao = new JDBCConsoleDAO(daoFactory.getConnection());
        } catch (SQLException ex) {
            Logger.getLogger(EmailSub.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = "";

        if (request.getParameter("email") != null) {
            email = request.getParameter("email");
        }

        if (email.equals("")) {
            System.out.println("email void");
        } else {
            try {
                consoledao.add_updateEmailSub(email);
                sendEmail(email);
            } catch (DAOException ex) {
                Logger.getLogger(EmailSub.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public void sendEmail(String email) {
        try {
            String testo = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n"
                    + "<html style=\"width:100%;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%;padding:0;Margin:0;\">\n"
                    + " <head> \n"
                    + "  <meta charset=\"UTF-8\"> \n"
                    + "  <meta content=\"width=device-width, initial-scale=1\" name=\"viewport\"> \n"
                    + "  <meta name=\"x-apple-disable-message-reformatting\"> \n"
                    + "  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> \n"
                    + "  <meta content=\"telephone=no\" name=\"format-detection\"> \n"
                    + "  <title>Nuovo modello di email 2019-09-04</title> \n"
                    + "  <!--[if (mso 16)]>\n"
                    + "    <style type=\"text/css\">\n"
                    + "    a {text-decoration: none;}\n"
                    + "    </style>\n"
                    + "    <![endif]--> \n"
                    + "  <!--[if gte mso 9]><style>sup { font-size: 100% !important; }</style><![endif]--> \n"
                    + "  <!--[if !mso]><!-- --> \n"
                    + "  <link href=\"https://fonts.googleapis.com/css?family=Open+Sans:400,400i,700,700i\" rel=\"stylesheet\"> \n"
                    + "  <!--<![endif]--> \n"
                    + "  <style type=\"text/css\">\n"
                    + "@media only screen and (max-width:600px) {p, ul li, ol li, a { font-size:16px!important; line-height:150%!important } h1 { font-size:32px!important; text-align:center; line-height:120%!important } h2 { font-size:26px!important; text-align:center; line-height:120%!important } h3 { font-size:20px!important; text-align:center; line-height:120%!important } h1 a { font-size:32px!important } h2 a { font-size:26px!important } h3 a { font-size:20px!important } .es-menu td a { font-size:16px!important } .es-header-body p, .es-header-body ul li, .es-header-body ol li, .es-header-body a { font-size:16px!important } .es-footer-body p, .es-footer-body ul li, .es-footer-body ol li, .es-footer-body a { font-size:16px!important } .es-infoblock p, .es-infoblock ul li, .es-infoblock ol li, .es-infoblock a { font-size:12px!important } *[class=\"gmail-fix\"] { display:none!important } .es-m-txt-c, .es-m-txt-c h1, .es-m-txt-c h2, .es-m-txt-c h3 { text-align:center!important } .es-m-txt-r, .es-m-txt-r h1, .es-m-txt-r h2, .es-m-txt-r h3 { text-align:right!important } .es-m-txt-l, .es-m-txt-l h1, .es-m-txt-l h2, .es-m-txt-l h3 { text-align:left!important } .es-m-txt-r img, .es-m-txt-c img, .es-m-txt-l img { display:inline!important } .es-button-border { display:inline-block!important } a.es-button { font-size:16px!important; display:inline-block!important; border-width:15px 30px 15px 30px!important } .es-btn-fw { border-width:10px 0px!important; text-align:center!important } .es-adaptive table, .es-btn-fw, .es-btn-fw-brdr, .es-left, .es-right { width:100%!important } .es-content table, .es-header table, .es-footer table, .es-content, .es-footer, .es-header { width:100%!important; max-width:600px!important } .es-adapt-td { display:block!important; width:100%!important } .adapt-img { width:100%!important; height:auto!important } .es-m-p0 { padding:0px!important } .es-m-p0r { padding-right:0px!important } .es-m-p0l { padding-left:0px!important } .es-m-p0t { padding-top:0px!important } .es-m-p0b { padding-bottom:0!important } .es-m-p20b { padding-bottom:20px!important } .es-mobile-hidden, .es-hidden { display:none!important } .es-desk-hidden { display:table-row!important; width:auto!important; overflow:visible!important; float:none!important; max-height:inherit!important; line-height:inherit!important } .es-desk-menu-hidden { display:table-cell!important } table.es-table-not-adapt, .esd-block-html table { width:auto!important } table.es-social { display:inline-block!important } table.es-social td { display:inline-block!important } }\n"
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
                    + " <body style=\"width:100%;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%;padding:0;Margin:0;\"> \n"
                    + "  <div class=\"es-wrapper-color\" style=\"background-color:#EEEEEE;\"> \n"
                    + "   <!--[if gte mso 9]>\n"
                    + "			<v:background xmlns:v=\"urn:schemas-microsoft-com:vml\" fill=\"t\">\n"
                    + "				<v:fill type=\"tile\" color=\"#eeeeee\"></v:fill>\n"
                    + "			</v:background>\n"
                    + "		<![endif]--> \n"
                    + "   <table class=\"es-wrapper\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;padding:0;Margin:0;width:100%;height:100%;background-repeat:repeat;background-position:center top;\"> \n"
                    + "     <tr style=\"border-collapse:collapse;\"> \n"
                    + "      <td valign=\"top\" style=\"padding:0;Margin:0;\"> \n"
                    + "       <table class=\"es-content\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;table-layout:fixed !important;width:100%;\"> \n"
                    + "         <tr style=\"border-collapse:collapse;\"></tr> \n"
                    + "         <tr style=\"border-collapse:collapse;\"> \n"
                    + "          <td align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                    + "           <table class=\"es-header-body\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:#044767;\" width=\"600\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#044767\" align=\"center\"> \n"
                    + "             <tr style=\"border-collapse:collapse;\"> \n"
                    + "              <td align=\"left\" style=\"Margin:0;padding-top:35px;padding-bottom:35px;padding-left:35px;padding-right:35px;\"> \n"
                    + "               <!--[if mso]><table width=\"530\" cellpadding=\"0\" cellspacing=\"0\"><tr><td width=\"340\" valign=\"top\"><![endif]--> \n"
                    + "               <table class=\"es-left\" cellspacing=\"0\" cellpadding=\"0\" align=\"left\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left;\"> \n"
                    + "                 <tr style=\"border-collapse:collapse;\"> \n"
                    + "                  <td class=\"es-m-p0r es-m-p20b\" width=\"340\" valign=\"top\" align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                    + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                     <tr style=\"border-collapse:collapse;\"> \n"
                    + "                      <td class=\"es-m-txt-c\" align=\"left\" style=\"padding:0;Margin:0;\"><h1 style=\"Margin:0;line-height:36px;mso-line-height-rule:exactly;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;font-size:36px;font-style:normal;font-weight:bold;color:#FFFFFF;\">'L Bortoleto</h1></td> \n"
                    + "                     </tr> \n"
                    + "                   </table></td> \n"
                    + "                 </tr> \n"
                    + "               </table> \n"
                    + "               <!--[if mso]></td><td width=\"20\"></td><td width=\"170\" valign=\"top\"><![endif]--> \n"
                    + "               <table cellspacing=\"0\" cellpadding=\"0\" align=\"right\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                 <tr class=\"es-hidden\" style=\"border-collapse:collapse;\"> \n"
                    + "                  <td class=\"es-m-p20b\" width=\"170\" align=\"left\" style=\"padding:0;Margin:0;\"> \n"
                    + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                     <tr style=\"border-collapse:collapse;\"> \n"
                    + "                      <td align=\"center\" style=\"padding:0;Margin:0;padding-bottom:5px;\"> \n"
                    + "                       <table width=\"100%\" height=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                         <tr style=\"border-collapse:collapse;\"> \n"
                    + "                          <td style=\"padding:0;Margin:0px;border-bottom:1px solid #044767;background:rgba(0, 0, 0, 0) none repeat scroll 0% 0%;height:1px;width:100%;margin:0px;\"></td> \n"
                    + "                         </tr> \n"
                    + "                       </table></td> \n"
                    + "                     </tr> \n"
                    + "                     <tr style=\"border-collapse:collapse;\"> \n"
                    + "                      <td style=\"padding:0;Margin:0;\"> \n"
                    + "                       <table cellspacing=\"0\" cellpadding=\"0\" align=\"right\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                         <tr style=\"border-collapse:collapse;\"> \n"
                    + "                          <td align=\"left\" style=\"padding:0;Margin:0;\"> \n"
                    + "                           <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                             <tr style=\"border-collapse:collapse;\"> \n"
                    + "                              <td align=\"right\" style=\"padding:0;Margin:0;\"><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;line-height:21px;color:#FFFFFF;\"><a target=\"_blank\" style=\"-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;font-size:18px;text-decoration:none;color:#FFFFFF;line-height:22px;\" href=\"https://macelleriadellantonio.it/"+URLEncoder.encode("/bottega.jsp", "UTF-8")+"\">Shop</a></p></td> \n"
                    + "                             </tr> \n"
                    + "                           </table></td> \n"
                    + "                          <td valign=\"top\" align=\"left\" style=\"padding:0;Margin:0;padding-left:10px;\"><img src=\"https://vwtlr.stripocdn.email/content/guids/CABINET_75694a6fc3c4633b3ee8e3c750851c02/images/77981522050090360.png\" alt style=\"display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic;\" width=\"27\"></td> \n"
                    + "                         </tr> \n"
                    + "                       </table></td> \n"
                    + "                     </tr> \n"
                    + "                   </table></td> \n"
                    + "                 </tr> \n"
                    + "               </table> \n"
                    + "               <!--[if mso]></td></tr></table><![endif]--></td> \n"
                    + "             </tr> \n"
                    + "           </table></td> \n"
                    + "         </tr> \n"
                    + "       </table> \n"
                    + "       <table class=\"es-content\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;table-layout:fixed !important;width:100%;\"> \n"
                    + "         <tr style=\"border-collapse:collapse;\"> \n"
                    + "          <td align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                    + "           <table class=\"es-content-body\" width=\"600\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#ffffff\" align=\"center\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:#FFFFFF;\"> \n"
                    + "             <tr style=\"border-collapse:collapse;\"> \n"
                    + "              <td style=\"Margin:0;padding-bottom:35px;padding-left:35px;padding-right:35px;padding-top:40px;background-color:#F7F7F7;\" bgcolor=\"#f7f7f7\" align=\"left\"> \n"
                    + "               <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                 <tr style=\"border-collapse:collapse;\"> \n"
                    + "                  <td width=\"530\" valign=\"top\" align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                    + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                     <tr style=\"border-collapse:collapse;\"> \n"
                    + "                      <td class=\"es-m-txt-l\" align=\"left\" style=\"padding:0;Margin:0;padding-top:20px;\"><h3 style=\"Margin:0;line-height:22px;mso-line-height-rule:exactly;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;font-size:18px;font-style:normal;font-weight:bold;color:#333333;\">BENVENUTO!<br></h3></td> \n"
                    + "                     </tr> \n"
                    + "                     <tr style=\"border-collapse:collapse;\"> \n"
                    + "                      <td align=\"left\" style=\"padding:0;Margin:0;padding-bottom:10px;padding-top:15px;\"><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:16px;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;line-height:24px;color:#777777;\">Grazie per esserti iscritto alla newsletter!<br>In questo modo potrai rimanere sempre aggiornato sui nuovi articoli del blog e su tutte le interessanti idee per la cucina che verranno aggiunte da noi o da VOI!<br></p></td> \n"
                    + "                     </tr> \n"
                    + "                   </table></td> \n"
                    + "                 </tr> \n"
                    + "               </table></td> \n"
                    + "             </tr> \n"
                    + "             <tr style=\"border-collapse:collapse;\"> \n"
                    + "              <td align=\"left\" style=\"Margin:0;padding-left:35px;padding-right:35px;padding-top:40px;padding-bottom:40px;\"> \n"
                    + "               <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                 <tr style=\"border-collapse:collapse;\"> \n"
                    + "                  <td width=\"530\" valign=\"top\" align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                    + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                     <tr style=\"border-collapse:collapse;\"> \n"
                    + "                      <td align=\"center\" style=\"padding:0;Margin:0;padding-top:20px;\"><h3 style=\"Margin:0;line-height:22px;mso-line-height-rule:exactly;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;font-size:18px;font-style:normal;font-weight:bold;color:#333333;\">Fai un giro nel sito web!</h3></td> \n"
                    + "                     </tr> \n"
                    + "                     <tr style=\"border-collapse:collapse;\"> \n"
                    + "                      <td align=\"center\" style=\"Margin:0;padding-left:10px;padding-right:10px;padding-bottom:15px;padding-top:20px;\"><span class=\"es-button-border\" style=\"border-style:solid;border-color:transparent;background:#ED8E20 none repeat scroll 0% 0%;border-width:0px;display:inline-block;border-radius:5px;width:auto;\"><a href=\"https://macelleriadellantonio.it\" class=\"es-button\" target=\"_blank\" style=\"mso-style-priority:100 !important;text-decoration:none;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;font-size:18px;color:#FFFFFF;border-style:solid;border-color:#ED8E20;border-width:15px 30px;display:inline-block;background:#ED8E20 none repeat scroll 0% 0%;border-radius:5px;font-weight:normal;font-style:normal;line-height:22px;width:auto;text-align:center;\">'L Bortoleto</a></span></td> \n"
                    + "                     </tr> \n"
                    + "                   </table></td> \n"
                    + "                 </tr> \n"
                    + "               </table></td> \n"
                    + "             </tr> \n"
                    + "           </table></td> \n"
                    + "         </tr> \n"
                    + "       </table> \n"
                    + "       <table class=\"es-content\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;table-layout:fixed !important;width:100%;\"> \n"
                    + "         <tr style=\"border-collapse:collapse;\"> \n"
                    + "          <td align=\"center\" style=\"padding:0;Margin:0;color:#9C5555;\"> \n"
                    + "           <table class=\"es-content-body\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:#1B9BA3;border-bottom:10px solid #48AFB5;\" width=\"600\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#1b9ba3\" align=\"center\"> \n"
                    + "             <tr style=\"border-collapse:collapse;\"> \n"
                    + "              <td align=\"left\" style=\"padding:0;Margin:0;\"> \n"
                    + "               <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                 <tr style=\"border-collapse:collapse;\"> \n"
                    + "                  <td width=\"600\" valign=\"top\" align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                    + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                     <tr style=\"border-collapse:collapse;\"> \n"
                    + "                      <td style=\"padding:0;Margin:0;\"> \n"
                    + "                       <table class=\"es-menu\" width=\"40%\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                         <tr class=\"links-images-top\" style=\"border-collapse:collapse;\"> \n"
                    + "                          <td style=\"Margin:0;padding-left:5px;padding-right:5px;padding-top:35px;padding-bottom:30px;border:0;\" width=\"20%\" bgcolor=\"transparent\" align=\"center\"><a target=\"_blank\" style=\"-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;font-size:20px;text-decoration:none;display:block;color:#FFFFFF;\" href=\"https://www.facebook.com/macelleriadellantonio/\"><img src=\"https://vwtlr.stripocdn.email/content/guids/CABINET_3ef3c4a0538c293f4c84f503cd8af2cc/images/60961522067175378.png\" alt title height=\"27\" align=\"absmiddle\" style=\"display:inline-block !important;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic;padding-bottom:5px;\"><br></a></td> \n"
                    + "                          <td style=\"Margin:0;padding-left:5px;padding-right:5px;padding-top:35px;padding-bottom:30px;border:0;\" width=\"20%\" bgcolor=\"transparent\" align=\"center\"><a target=\"_blank\" style=\"-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;font-size:20px;text-decoration:none;display:block;color:#FFFFFF;\" href=\"https://www.facebook.com/LBortoleto/\"><img src=\"https://vwtlr.stripocdn.email/content/guids/CABINET_3ef3c4a0538c293f4c84f503cd8af2cc/images/60961522067175378.png\" alt title height=\"27\" align=\"absmiddle\" style=\"display:inline-block !important;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic;padding-bottom:5px;\"><br></a></td> \n"
                    + "                          <td style=\"Margin:0;padding-left:5px;padding-right:5px;padding-top:35px;padding-bottom:30px;border:0;\" width=\"20%\" bgcolor=\"transparent\" align=\"center\"><a target=\"_blank\" style=\"-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;font-size:20px;text-decoration:none;display:block;color:#FFFFFF;\" href=\"https://macelleriadellantonio.it/"+URLEncoder.encode("/idee.jsp", "UTF-8")+"\"><img src=\"https://vwtlr.stripocdn.email/content/guids/CABINET_6b1073548c13ac600ba0fa1fb99a0e68/images/29591567602277829.PNG\" alt title height=\"27\" align=\"absmiddle\" style=\"display:inline-block !important;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic;padding-bottom:5px;\"><br></a></td> \n"
                    + "                          <td style=\"Margin:0;padding-left:5px;padding-right:5px;padding-top:35px;padding-bottom:30px;border:0;\" width=\"20%\" bgcolor=\"transparent\" align=\"center\"><a target=\"_blank\" style=\"-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;font-size:20px;text-decoration:none;display:block;color:#FFFFFF;\" href=\"https://macelleriadellantonio.it/"+URLEncoder.encode("/blog.jsp", "UTF-8")+"\"><img src=\"https://vwtlr.stripocdn.email/content/guids/CABINET_6b1073548c13ac600ba0fa1fb99a0e68/images/18731567602315260.PNG\" alt title height=\"27\" align=\"absmiddle\" style=\"display:inline-block !important;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic;padding-bottom:5px;\"><br></a></td> \n"
                    + "                          <td style=\"Margin:0;padding-left:5px;padding-right:5px;padding-top:35px;padding-bottom:30px;border:0;\" width=\"20%\" bgcolor=\"transparent\" align=\"center\"><a target=\"_blank\" style=\"-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;font-size:20px;text-decoration:none;display:block;color:#FFFFFF;\" href=\"https://www.youtube.com/watch?time_continue=2&v=9-3If8AhVwM\"><img src=\"https://vwtlr.stripocdn.email/content/guids/CABINET_6b1073548c13ac600ba0fa1fb99a0e68/images/43381567602946636.png\" alt title height=\"27\" align=\"absmiddle\" style=\"display:inline-block !important;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic;padding-bottom:5px;\"><br></a></td> \n"
                    + "                         </tr> \n"
                    + "                       </table></td> \n"
                    + "                     </tr> \n"
                    + "                   </table></td> \n"
                    + "                 </tr> \n"
                    + "               </table></td> \n"
                    + "             </tr> \n"
                    + "           </table></td> \n"
                    + "         </tr> \n"
                    + "       </table> \n"
                    + "       <table class=\"es-footer\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;table-layout:fixed !important;width:100%;background-color:transparent;background-repeat:repeat;background-position:center top;\"> \n"
                    + "         <tr style=\"border-collapse:collapse;\"> \n"
                    + "          <td align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                    + "           <table class=\"es-footer-body\" width=\"600\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:#FFFFFF;\"> \n"
                    + "             <tr style=\"border-collapse:collapse;\"> \n"
                    + "              <td align=\"left\" style=\"padding:0;Margin:0;padding-top:20px;padding-left:35px;padding-right:35px;\"> \n"
                    + "               <!--[if mso]><table width=\"530\" cellpadding=\"0\" cellspacing=\"0\"><tr><td width=\"255\" valign=\"top\"><![endif]--> \n"
                    + "               <table cellpadding=\"0\" cellspacing=\"0\" class=\"es-left\" align=\"left\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:left;\"> \n"
                    + "                 <tr style=\"border-collapse:collapse;\"> \n"
                    + "                  <td width=\"255\" class=\"es-m-p20b\" align=\"left\" style=\"padding:0;Margin:0;\"> \n"
                    + "                   <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                     <tr style=\"border-collapse:collapse;\"> \n"
                    + "                      <td align=\"center\" style=\"padding:0;Margin:0;\"><img class=\"adapt-img\" src=\"https://vwtlr.stripocdn.email/content/guids/CABINET_6b1073548c13ac600ba0fa1fb99a0e68/images/54851567603171327.png\" alt style=\"display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic;\" width=\"70\"></td> \n"
                    + "                     </tr> \n"
                    + "                     <tr style=\"border-collapse:collapse;\"> \n"
                    + "                      <td align=\"center\" style=\"padding:0;Margin:0;\"><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;line-height:21px;color:#333333;\"><strong>Predazzo(TN) 38037</strong><br></p><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;line-height:21px;color:#333333;\"><strong>Via Cesare Battisti 2</strong><br></p><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;line-height:21px;color:#333333;\"><strong>0462-501231 info@macelleriadellantonio.it</strong></p></td> \n"
                    + "                     </tr> \n"
                    + "                   </table></td> \n"
                    + "                 </tr> \n"
                    + "               </table> \n"
                    + "               <!--[if mso]></td><td width=\"20\"></td><td width=\"255\" valign=\"top\"><![endif]--> \n"
                    + "               <table cellpadding=\"0\" cellspacing=\"0\" class=\"es-right\" align=\"right\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;float:right;\"> \n"
                    + "                 <tr style=\"border-collapse:collapse;\"> \n"
                    + "                  <td width=\"255\" align=\"left\" style=\"padding:0;Margin:0;\"> \n"
                    + "                   <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                     <tr style=\"border-collapse:collapse;\"> \n"
                    + "                      <td align=\"center\" style=\"padding:0;Margin:0;\"><img class=\"adapt-img\" src=\"https://vwtlr.stripocdn.email/content/guids/CABINET_6b1073548c13ac600ba0fa1fb99a0e68/images/12851567601700248.jpg\" alt style=\"display:block;border:0;outline:none;text-decoration:none;-ms-interpolation-mode:bicubic;\" width=\"100\"></td> \n"
                    + "                     </tr> \n"
                    + "                     <tr style=\"border-collapse:collapse;\"> \n"
                    + "                      <td align=\"center\" style=\"padding:0;Margin:0;\"><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;line-height:21px;color:#333333;\"><strong>Predazzo(TN) 38037</strong><br></p><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;line-height:21px;color:#333333;\"><strong>Via Cavour 2</strong><br></p><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;line-height:21px;color:#333333;\"><strong>0462-500261</strong><br></p><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;line-height:21px;color:#333333;\"><strong>ristorantebortoleto@gmail.com</strong></p></td> \n"
                    + "                     </tr> \n"
                    + "                   </table></td> \n"
                    + "                 </tr> \n"
                    + "               </table> \n"
                    + "               <!--[if mso]></td></tr></table><![endif]--></td> \n"
                    + "             </tr> \n"
                    + "             <tr style=\"border-collapse:collapse;\"> \n"
                    + "              <td align=\"left\" style=\"Margin:0;padding-top:35px;padding-left:35px;padding-right:35px;padding-bottom:40px;\"> \n"
                    + "               <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                 <tr style=\"border-collapse:collapse;\"> \n"
                    + "                  <td width=\"530\" valign=\"top\" align=\"center\" style=\"padding:0;Margin:0;\"> \n"
                    + "                   <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;\"> \n"
                    + "                     <tr style=\"border-collapse:collapse;\"> \n"
                    + "                      <td class=\"es-m-txt-c\" esdev-links-color=\"#777777\" align=\"left\" style=\"padding:0;Margin:0;padding-top:10px;\"><p style=\"Margin:0;-webkit-text-size-adjust:none;-ms-text-size-adjust:none;mso-line-height-rule:exactly;font-size:14px;font-family:'open sans', 'helvetica neue', helvetica, arial, sans-serif;line-height:21px;color:#777777;\">Se hai&nbsp;ricevuto questa email per sbaglio ti chiediamo di ignorarla</p></td> \n"
                    + "                     </tr> \n"
                    + "                   </table></td> \n"
                    + "                 </tr> \n"
                    + "               </table></td> \n"
                    + "             </tr> \n"
                    + "           </table></td> \n"
                    + "         </tr> \n"
                    + "       </table></td> \n"
                    + "     </tr> \n"
                    + "   </table> \n"
                    + "  </div>  \n"
                    + " </body>\n"
                    + "</html>";

            String to1 = email;
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
            message.setSubject("BENVENUTO da 'L Bortoleto");

            Multipart mp = new MimeMultipart();
            MimeBodyPart htmlPart = new MimeBodyPart();
            htmlPart.setContent(testo, "text/html");
            mp.addBodyPart(htmlPart);
            message.setContent(mp);

            // Transport class is used to deliver the message to the recipients 
            Transport.send(message);
        } catch (MessagingException | UnsupportedEncodingException ex) {
            Logger.getLogger(EmailSub.class.getName()).log(Level.SEVERE, null, ex);
        }
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
