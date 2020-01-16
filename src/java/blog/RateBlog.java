/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package blog;

import database.daos.BlogDAO;
import database.daos.ConsoleDAO;
import database.entities.Blog;
import database.exceptions.DAOException;
import database.factories.DAOFactory;
import database.jdbc.JDBCBlogDAO;
import database.jdbc.JDBCConsoleDAO;
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
import varie.RateProd;

/**
 *
 * @author Roberto97
 */
public class RateBlog extends HttpServlet {

    private static final long serialVersionUID = 1L;

    BlogDAO blogdao;
    ConsoleDAO consoledao;

    @Override
    public void init() throws ServletException {
        try {
            //carica la Connessione inizializzata in JDBCDAOFactory, quindi ritorna il Class.for() e la connessione
            DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
            if (daoFactory == null) {
                throw new ServletException("Impossible to get dao factory for user storage system");
            }
            blogdao = new JDBCBlogDAO(daoFactory.getConnection());
            consoledao = new JDBCConsoleDAO(daoFactory.getConnection());
        } catch (SQLException ex) {
            Logger.getLogger(RateBlog.class.getName()).log(Level.SEVERE, null, ex);
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

        int blog = 0;
        double val = 0;
        HttpSession session = request.getSession(false);

        try {
            if (request.getParameter("blog") != null) {
                blog = Integer.parseInt(request.getParameter("blog").replace(",", "."));
            }
            if (request.getParameter("val") != null) {
                val = Double.parseDouble(request.getParameter("val").replace(",", "."));
            }
            Blog b = blogdao.getBlogById(blog);
            String name = "B_" + blog + "_" + session.getId();
            if (session.getAttribute(name) != null) {
                if (session.getAttribute(name).equals(name)) {
                    response.addHeader("already_" + blog, "true");
                }
            } else {
                blogdao.setRate(blog, val);
                String ur = "/../Bortoleto/articolo/"+blog+"/"+b.getNome().replace(' ', '-');
                consoledao.addNotifica(NEW_RATE, ur);
                session.setAttribute(name, name);
            }

        } catch (NumberFormatException e) {
            System.out.println("errore rateBlog Servlet");
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
