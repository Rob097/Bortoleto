/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package carrello;

import database.daos.ProductDAO;
import database.exceptions.DAOException;
import database.factories.DAOFactory;
import database.jdbc.JDBCProductDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Roberto97
 */
public class UpdateQuantity extends HttpServlet {

    private static final long serialVersionUID = 1L;

    ProductDAO productdao = null;
    
    @Override
    public void init() throws ServletException {
        try {
            //carica la Connessione inizializzata in JDBCDAOFactory, quindi ritorna il Class.for() e la connessione
            DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
            if (daoFactory == null) {
                throw new ServletException("Impossible to get dao factory for user storage system");
            }
            productdao = new JDBCProductDAO(daoFactory.getConnection());
        } catch (SQLException ex) {
            Logger.getLogger(UpdateQuantity.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * Serrvlet aggiornare la quantità di un prodotto
     * richiama il relativo metodo di JDBCDAO ed è chiamata da una fuznzione ajax.
     * 
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = 0, quantita = 0;
            String variante = null;
            if(request.getParameter("id") != null)
                id = Integer.parseInt(request.getParameter("id"));
            if(request.getParameter("quantita") != null)
                quantita = Integer.parseInt(request.getParameter("quantita"));
            if(request.getParameter("variante") != null)
                variante = request.getParameter("variante");
            productdao.updateQuantity(id, variante, quantita, request, response);
            response.sendRedirect("/Bortoleto/ajax/carrelloModalContent.jsp");
        } catch (DAOException ex) {
            Logger.getLogger(UpdateQuantity.class.getName()).log(Level.SEVERE, null, ex);
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
