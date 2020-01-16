/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package filters;

import database.daos.ConsoleDAO;
import database.exceptions.DAOException;
import database.factories.DAOFactory;
import database.jdbc.JDBCConsoleDAO;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Roberto97
 */
public class StatoSito implements Filter {

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    ConsoleDAO consoledao = null;

    public StatoSito() {
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        /* INIZIO FILTRO DI CONTROLLO */
        if (request instanceof HttpServletRequest) {
            try {
                boolean check;
                HttpServletRequest req = (HttpServletRequest) request;
                HttpServletResponse res = (HttpServletResponse) response;

                try {
                    //carica la Connessione inizializzata in JDBCDAOFactory, quindi ritorna il Class.for() e la connessione
                    DAOFactory daoFactory = (DAOFactory) request.getServletContext().getAttribute("daoFactory");
                    if (daoFactory == null) {
                        throw new ServletException("Impossible to get dao factory for user storage system");
                    }
                    consoledao = new JDBCConsoleDAO(daoFactory.getConnection());
                } catch (SQLException ex) {
                    System.out.println("statoSito.java errore 1");
                }

                check = consoledao.getStatus();

                String statOFF = "/ErrorPages/statoOFF.html";
                String statOFF_URI = req.getContextPath() + statOFF;
                String homeURI = req.getContextPath() + "/";
                String where = req.getRequestURI().replace(req.getContextPath(), "");

                if (where.equals(statOFF)) {
                    if (!check) {
                        chain.doFilter(request, response);
                    } else {
                        res.sendRedirect(homeURI);
                    }
                } else {
                    if (!check) {
                        res.sendRedirect(statOFF_URI);
                    } else {
                        chain.doFilter(request, response);
                    }
                }
            } catch (DAOException ex) {
                Logger.getLogger(StatoSito.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        /* FINE FILTRO DI CONTROLLO */
    }

    /**
     * Return the filter configuration object for this filter.
     *
     * @return
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    @Override
    public void destroy() {
    }

    /**
     * Init method for this filter
     *
     * @param filterConfig
     */
    @Override
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("statoSito()");
        }
        StringBuilder sb = new StringBuilder("statoSito(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (IOException ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
