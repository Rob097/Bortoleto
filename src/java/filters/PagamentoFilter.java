/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package filters;

import database.daos.PagamentoDAO;
import database.factories.DAOFactory;
import database.jdbc.JDBCPagamentoDAO;
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
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Roberto97
 */
public class PagamentoFilter implements Filter {
    
    private static final boolean DEBUG = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;
    private PagamentoDAO pagamentodao;
    
    public PagamentoFilter() {
    }    
    
    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        /*if (DEBUG) {
            log("PagamentoFilter:DoBeforeProcessing");
        }*/

        if(request instanceof HttpServletRequest){
            
            HttpSession session = ((HttpServletRequest)request).getSession();
            if(session != null){
                session.setAttribute("pagamentodao", pagamentodao);
                Cookie[] cookies = ((HttpServletRequest) request).getCookies();
                if(cookies !=null){
                    for(Cookie c : cookies){
                        switch (c.getName()) {
                            case "nome":
                                session.setAttribute("nome", c.getValue());
                                break;
                            case "cognome":
                                session.setAttribute("cognome", c.getValue());
                                break;
                            case "email":
                                session.setAttribute("email", c.getValue());
                                break;
                            case "indirizzo":
                                session.setAttribute("indirizzo", c.getValue());
                                break;
                            case "citta":
                                session.setAttribute("citta", c.getValue());
                                break;
                            case "zip":
                                session.setAttribute("zip", c.getValue());
                                break;
                            default:
                                break;
                        }
                    }
                }
            }
        }
    }    
    
    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        /*if (DEBUG) {
            log("PagamentoFilter:DoAfterProcessing");
        }*/

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
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
        
        /*if (DEBUG) {
            log("PagamentoFilter:doFilter()");
        }*/
        
        doBeforeProcessing(request, response);
        
        Throwable problem = null;
        try {
            chain.doFilter(request, response);
        } catch (IOException | ServletException t) {
            // If an exception is thrown somewhere down the filter chain,
            // we still want to execute our after processing, and then
            // rethrow the problem after that.
            problem = t;
        }
        
        doAfterProcessing(request, response);

        // If there was a problem, we want to rethrow it if it is
        // a known type, otherwise log it.
        if (problem != null) {
            if (problem instanceof ServletException) {
                throw (ServletException) problem;
            }
            if (problem instanceof IOException) {
                throw (IOException) problem;
            }
            sendProcessingError(problem, response);
        }
    }

    /**
     * Return the filter configuration object for this filter.
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
     * @param filterConfig
     * @throws javax.servlet.ServletException
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {        
        try {
            this.filterConfig = filterConfig;
            DAOFactory daoFactory = null;
            if (filterConfig != null) {
                /*if (DEBUG) {
                log("PagamentoFilter:Initializing filter");
                }*/
                daoFactory = (DAOFactory) filterConfig.getServletContext().getAttribute("daoFactory");
            }
            if (daoFactory == null) {
                throw new ServletException("Impossible to get dao factory for user storage system");
            }
            //assegna a userdao la connessione(costruttore) e salva la connessione in una variabile tipo Connection
            pagamentodao = new JDBCPagamentoDAO(daoFactory.getConnection());
        } catch (SQLException ex) {
            Logger.getLogger(PagamentoFilter.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Return a String representation of this object.
     * @return 
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("pagamentoFilter()");
        }
        StringBuilder sb = new StringBuilder("pagamentoFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }
    
    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);        
        
        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                try (PrintStream ps = new PrintStream(response.getOutputStream()); PrintWriter pw = new PrintWriter(ps)) {
                    pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N
                    
                    // PENDING! Localize this for next official release
                    pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                    pw.print(stackTrace);
                    pw.print("</pre></body>\n</html>"); //NOI18N
                }
                response.getOutputStream().close();
            } catch (IOException ex) {
            }
        } else {
            try {
                try (PrintStream ps = new PrintStream(response.getOutputStream())) {
                    t.printStackTrace(ps);
                }
                response.getOutputStream().close();
            } catch (IOException ex) {
            }
        }
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
