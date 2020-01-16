/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package varie;

import database.daos.ConsoleDAO;
import database.daos.RicetteDAO;
import database.entities.Ricetta;
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
import javax.servlet.http.HttpSession;
import static varie.Costanti.NEW_RATE;

/**
 *
 * @author Roberto97
 */
public class RateRicetta extends HttpServlet {

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
            Logger.getLogger(RateRicetta.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * Servlet per settare la valutazione di una ricetta.
     * Richiama il relativo metodo ed è chiamata da una funziona Ajax
     * 
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int ricetta = 0;
        double val = 0;
        HttpSession session = request.getSession(false);

        try {
            if (request.getParameter("ricetta") != null) {
                ricetta = Integer.parseInt(request.getParameter("ricetta").replace(",", "."));
            }
            if (request.getParameter("val") != null) {
                val = Double.parseDouble(request.getParameter("val").replace(",", "."));
            }
            Ricetta r = ricettedao.getRecipe(ricetta);
            String name = "R_" + ricetta + "_" + session.getId();
            if (session.getAttribute(name) != null) {
                if (session.getAttribute(name).equals(name)) {
                    response.addHeader("already_" + ricetta, "true");
                }
            } else {
                ricettedao.setRate(ricetta, val);
                String ur = "/../Bortoleto/idea/"+ricetta+"/"+r.getNome().replace(' ', '-');
                consoledao.addNotifica(NEW_RATE, ur);
                session.setAttribute(name, name);
            }

        } catch (NumberFormatException e) {
            System.out.println("errore rateRicetta Servlet");
        } catch (DAOException ex) {
            Logger.getLogger(RateProd.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
