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
import java.sql.Timestamp;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import static varie.Costanti.NEW_IDEA;

/**
 *
 * @author Roberto97
 */
public class AddIdea extends HttpServlet {

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
            Logger.getLogger(AddIdea.class.getName()).log(Level.SEVERE, null, ex);
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

        request.setCharacterEncoding("UTF-8");
        RequestDispatcher view;
        try {
            String nome = "", procedimento = "", descrizione = "", difficolta = "ignota", creatore = "";
            int id_prod = 0, tempo = 0;
            boolean categoria = false;
            String ingS = "";
            if (request.getAttribute("titolo") != null) {
                nome = (String) request.getAttribute("titolo");
            }
            if (request.getAttribute("product") != null) {
                id_prod = Integer.parseInt((String) request.getAttribute("product"));
            }
            if (request.getAttribute("autore") != null) {
                creatore = (String) request.getAttribute("autore");
            }
            if (request.getAttribute("procedimento") != null) {
                procedimento = (String) request.getAttribute("procedimento");
                if (procedimento.length() > 3000) {
                    procedimento = procedimento.substring(0, 3000);
                }
                descrizione = procedimento.replaceAll("[<](/)?[^>]*[>]", "");
            }
            if (request.getAttribute("ingredienti") != null) {
                ingS = (String) request.getAttribute("ingredienti");
            }
            ricettedao.addRecipe(nome, procedimento, descrizione, difficolta, ingS, creatore, tempo, id_prod, categoria);
            consoledao.addNotifica(NEW_IDEA, "../console/idee.jsp");
            response.setHeader("NOTIFICA", "La tua idea è stata inviata correttamente! Grazie per il tuo contributo");
            response.setHeader("STATO", "positivo");
            view = request.getRequestDispatcher(response.encodeURL("/idee.jsp"));
        } catch (DAOException ex) {
            Logger.getLogger(AddIdea.class.getName()).log(Level.SEVERE, null, ex);
            response.setHeader("NOTIFICA", "La tua idea non è stata inviata.. Riprova più tardi o scrivi a info@macelleriadellantonio.it");
            response.setHeader("STATO", "negativo");
            view = request.getRequestDispatcher(response.encodeURL("/idee.jsp"));
        }
        view.forward(request, response);
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
