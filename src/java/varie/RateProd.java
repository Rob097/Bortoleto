/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package varie;

import database.daos.ConsoleDAO;
import database.daos.ProductDAO;
import database.entities.Prodotto;
import database.exceptions.DAOException;
import database.factories.DAOFactory;
import database.jdbc.JDBCConsoleDAO;
import database.jdbc.JDBCProductDAO;
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
public class RateProd extends HttpServlet {

    private static final long serialVersionUID = 1L;

    ProductDAO productdao;
    ConsoleDAO consoledao;

    @Override
    public void init() throws ServletException {
        try {
            //carica la Connessione inizializzata in JDBCDAOFactory, quindi ritorna il Class.for() e la connessione
            DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
            if (daoFactory == null) {
                throw new ServletException("Impossible to get dao factory for user storage system");
            }
            productdao = new JDBCProductDAO(daoFactory.getConnection());
            consoledao = new JDBCConsoleDAO(daoFactory.getConnection());
        } catch (SQLException ex) {
            Logger.getLogger(RateProd.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * Servlet per settare una valutazione di un prodotto (Richiama il metodo)
     * Chiamata da funzione Ajax
     * 
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int prod = 0;
        double val = 0;
        HttpSession session = request.getSession(false);
        
        try {
            if (request.getParameter("prod") != null) {
                prod = Integer.parseInt(request.getParameter("prod").replace(",", "."));
            }
            if (request.getParameter("val") != null) {
                val = Double.parseDouble(request.getParameter("val").replace(",", "."));
            }
            Prodotto p = productdao.getProduct(prod);
            String name = "P_" + prod + "_" + session.getId();
            if (session.getAttribute(name) != null) {
                if (session.getAttribute(name).equals(name)) {
                    response.addHeader("already_" + prod, "true");
                }
            } else {
                productdao.setRate(prod, val);
                String ur = "/../Bortoleto/prodotto/"+p.getId()+"/"+p.getCategoria().replace(' ', '-')+"/"+p.getNome().replace(' ', '-');
                consoledao.addNotifica(NEW_RATE,  ur);
                session.setAttribute(name, name);
            }

        } catch (NumberFormatException e) {
            System.out.println("errore rateProd Servlet");
        } catch (DAOException ex) {
            Logger.getLogger(RateProd.class.getName()).log(Level.SEVERE, null, ex);
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
