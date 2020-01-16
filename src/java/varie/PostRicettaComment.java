/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package varie;

import database.daos.ConsoleDAO;
import database.daos.RicetteDAO;
import database.exceptions.DAOException;
import database.factories.DAOFactory;
import database.jdbc.JDBCConsoleDAO;
import database.jdbc.JDBCRicetteDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tools.VerifyUtils;
import static varie.Costanti.NEW_COMMENT;

/**
 *
 * @author Roberto97
 */
public class PostRicettaComment extends HttpServlet {

    private static final long serialVersionUID = 1L;

    RicetteDAO ricettedao;
    ConsoleDAO consoledao;

    @Override
    public void init() throws ServletException {
        try {
            //carica la Connessione inizializzata in JDBCDAOFactory, quindi ritorna il Class.for() e la connessione
            DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
            if (daoFactory == null) {
                throw new ServletException("Impossible to get dao factory for user storage system");
            }
            ricettedao = new JDBCRicetteDAO(daoFactory.getConnection());
            consoledao = new JDBCConsoleDAO(daoFactory.getConnection());
        } catch (SQLException ex) {
            Logger.getLogger(PostRicettaComment.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * Servlet usata per postare un commento di una ricetta.<br>
     * Fondamentalmente se il captcha risulta valido richiama il relativo metodo
     * del JDBCDAO e poi reindirizza
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
        int idRicetta = 0;
        /* Inizio analisi recaptcha */
        boolean valid;
        String errorString;
        String gRecaptchaResponse = request.getParameter("g-recaptcha-response");

        // Verify CAPTCHA.
        valid = VerifyUtils.verify(gRecaptchaResponse);
        if (!valid) {
            errorString = "Captcha post ricetta comment invalid!";
            response.sendRedirect(response.encodeURL("/Bortoleto/idee.jsp"));
            /* Questo è da cambiare alla pagina di errore */
        } else {
            /* analisi recaptcha eseguire solo se è valido*/
            String nome = "", commento = "", titolo = "";

            if (request.getParameter("nome") != null) {
                nome = request.getParameter("nome");
            }
            if (request.getParameter("commento") != null) {
                commento = request.getParameter("commento");
            }
            if (request.getParameter("titoloRicetta") != null) {
                titolo = request.getParameter("titoloRicetta");
            }
            if (request.getParameter("idRicetta") != null) {
                try {
                    idRicetta = Integer.parseInt(request.getParameter("idRicetta"));
                } catch (NumberFormatException e) {
                    System.out.println("Impossibile parse idRicetta in postRicettaComment servlet");
                }
            }
            String ur = "/../Bortoleto/";
            try {
                ricettedao.postComment(idRicetta, nome, commento);
                    ur = "/../Bortoleto/idea/" + idRicetta + "/" + titolo.replace(' ', '-');
                consoledao.addNotifica(NEW_COMMENT, ur);
            } catch (DAOException ex) {
                Logger.getLogger(PostRicettaComment.class.getName()).log(Level.SEVERE, null, ex);
            }
            response.sendRedirect(ur + "#commenti");
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
