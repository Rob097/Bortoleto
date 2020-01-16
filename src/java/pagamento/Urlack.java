/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pagamento;

import database.daos.ConsoleDAO;
import database.daos.PagamentoDAO;
import database.exceptions.DAOException;
import database.factories.DAOFactory;
import database.jdbc.JDBCConsoleDAO;
import database.jdbc.JDBCPagamentoDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import static varie.Costanti.NEW_ORDER;
import static varie.Costanti.NEW_ORDER_LINK;
import static varie.Costanti.cookiesA;
import static varie.Costanti.sessionA;

/**
 *
 * @author Roberto97
 */
public class Urlack extends HttpServlet {

    private static final long serialVersionUID = 1L;

    ConsoleDAO consoledao;
    PagamentoDAO pagamentodao;

    @Override
    public void init() throws ServletException {
        try {
            //carica la Connessione inizializzata in JDBCDAOFactory, quindi ritorna il Class.for() e la connessione
            DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
            if (daoFactory == null) {
                throw new ServletException("Impossible to get dao factory for user storage system");
            }
            consoledao = new JDBCConsoleDAO(daoFactory.getConnection());
            pagamentodao = new JDBCPagamentoDAO(daoFactory.getConnection());
        } catch (SQLException ex) {
            Logger.getLogger(Urlack.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws database.exceptions.DAOException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, DAOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession s = request.getSession();

        Map<String, Cookie[]> cookieMap = cookiesA;
        Map<String, Cookie[]> newCookiesA = new HashMap<>();
        Cookie[] cookies;
        String id = request.getParameter("ORDER_ID");
        String delivery = "";

        //Cerco il cookie con il tipo di spedizione e lo salvo nella variabile delivery
        //poi elimino dalla variabile globale i cookie identificati dall'id dell'ordine
        if (cookieMap != null) {
            Iterator<Map.Entry<String, Cookie[]>> it = cookieMap.entrySet().iterator();
            Map.Entry<String, Cookie[]> entry;
            while (it.hasNext()) {
                entry = it.next();
                if (entry.getKey().equals(id)) {
                    cookies = entry.getValue();
                    if (cookies != null) {
                        for (Cookie c : cookies) {
                            if (c.getName().equals("DELI")) {
                                delivery = c.getValue();
                            }
                        }
                    } else {
                        System.out.println("cookie null in urlack");
                    }
                }else{
                    newCookiesA.put(entry.getKey(), entry.getValue());
                }
            }
        }
        
        cookiesA = newCookiesA;

        /*ritrovo tutti gli attributi di sessione identificati dall'id dell'ordine,
        li salvo nella sessiona attuale e poi elimino dalla variabile globale
        l'elemento con l'id dell'ordine*/
        Map<String, Map<String, Object>> sess = sessionA;
        Map<String, Map<String, Object>> newSessionA = new HashMap<>();

        if (sess != null) {
            Iterator<Map.Entry<String, Map<String, Object>>> itS = sess.entrySet().iterator();
            Map.Entry<String, Map<String, Object>> entryS;
            while (itS.hasNext()) {
                entryS = itS.next();
                if (entryS.getKey().equals(id)) {

                    Map<String, Object> value = entryS.getValue();

                    Iterator<Map.Entry<String, Object>> itV = value.entrySet().iterator();
                    Map.Entry<String, Object> entryV;
                    while (itV.hasNext()) {
                        entryV = itV.next();
                        if (entryV.getKey().equals("ORDER_ID")) {
                            s.setAttribute("ORDER_ID", entryV.getValue());
                        }
                        if (entryV.getKey().equals("NOME")) {
                            s.setAttribute("NOME", entryV.getValue());
                        }
                        if (entryV.getKey().equals("COGNOME")) {
                            s.setAttribute("COGNOME", entryV.getValue());
                        }
                        if (entryV.getKey().equals("EMAIL")) {
                            s.setAttribute("EMAIL", entryV.getValue());
                        }
                        if (entryV.getKey().equals("CITTA")) {
                            s.setAttribute("CITTA", entryV.getValue());
                        }
                        if (entryV.getKey().equals("INDIRIZZO")) {
                            s.setAttribute("INDIRIZZO", entryV.getValue());
                        }
                        if (entryV.getKey().equals("ZIP")) {
                            s.setAttribute("ZIP", entryV.getValue());
                        }
                        if (entryV.getKey().equals("CART")) {
                            s.setAttribute("CART", entryV.getValue());
                        }
                        if (entryV.getKey().equals("DELI") && delivery.equals("")) {
                            delivery = entryV.getValue().toString();
                        }
                        if (entryV.getKey().equals("varianti")) {
                            s.setAttribute("varianti", entryV.getValue());
                        }
                    }
                }else{
                    newSessionA.put(entryS.getKey(), entryS.getValue());
                }
            }
        }
        sessionA = newSessionA;
        
        //System.out.println("cookiesA: " + cookiesA.toString() + "\nsessionA: " + sessionA.toString());

        //richiamo i metodi che salvano i dati e inviano l'email di conferma
        //nei metodi vengono cancellati gli attributi di sessione
        //in urlok vengono cancellati i cookie perchè nei metodi è impossibile
        consoledao.addNewOrder(request, request.getParameter("IMPORTO"), delivery);
        consoledao.addNotifica(NEW_ORDER, NEW_ORDER_LINK+id);
        pagamentodao.orderConfirmed(request, request.getParameter("ORDER_ID"));
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (DAOException ex) {
            Logger.getLogger(Urlack.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            processRequest(request, response);
        } catch (DAOException ex) {
            Logger.getLogger(Urlack.class.getName()).log(Level.SEVERE, null, ex);
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
