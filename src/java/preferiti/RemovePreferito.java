/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package preferiti;

//import static filters.variabiliGlobali.DOMINIO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import static varie.Costanti.PREF_COOKIE_MAX_AGE;

/**
 *
 * @author Roberto97
 */
public class RemovePreferito extends HttpServlet {

    private static final long serialVersionUID = 6106269076155338045L;

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * Questa servlet viene usata quando si vuole eliminare dai preferiti un
     * determinato prodotto.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession s = request.getSession(false);
        String id = null;
        Cookie c = null;
        String[] idProducts = null;
        String ids = "";
        Cookie[] cookies = request.getCookies();

        //Scelgo il cookie dei preferiti
        for (Cookie cc : cookies) {
            if (cc.getName().equals("preferiti")) {
                c = cc;
            }
        }

        //Formo la stringa di id concatenata da underscore
        if (c != null) {
            idProducts = c.getValue().split("_");
        }

        /*Controllo che niente sia uguale a null e poi aggiungo alla string ids
        tutti gli id apparte quello passato come parametro che è quello che deve
        essere eliminato. Ovviamente il primo lo aggiungo e basta, tutti gli altri
        aggiungo prima underscore e poi l'id.
         */
        if (request.getParameter("id") != null) {
            if (idProducts != null) {
                for (String i : idProducts) {
                    if (i.equals(request.getParameter("id"))) {
                    } else {
                        if (ids.equals("")) {
                            ids = i;
                        } else {
                            ids += "_" + i;
                        }
                    }
                }
            }
        }

        /*Se la nuova stringa di id non è vuota, che vuol dire che il prodotto
        da togliere dai preferiti non era l'unico preferito, allora crea un nuovo
        cookie preferiti con le nuove ids, altrimenti setta a null il valore
        dell'attuale cookie (Se non lo fai quando hai un solo cookie servono due
        tentativi per eliminarlo) e poi lo elimini.
        In fine in entrambi i casi cambi il valore in sessione che è quello che
        viene usato nel front end
         */
        if (!ids.isEmpty()) {
            c = new Cookie("preferiti", ids);
            c.setMaxAge(PREF_COOKIE_MAX_AGE);
            c.setPath(request.getContextPath());
            //c.setDomain(DOMINIO);
            response.addCookie(c);
            /*if (id != null) {
                s.setAttribute("preferiti", id);
            }*/
        } else {
            //c = new Cookie("preferiti", ids);
            //c.setDomain(DOMINIO);
            //response.addCookie(c);
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("preferiti")) {
                    cookie.setValue(null);
                    cookie.setMaxAge(0);
                    cookie.setPath(request.getContextPath());
                    response.addCookie(cookie);
                }
            }
            s.setAttribute("preferiti", null);
        }

        response.sendRedirect("/Bortoleto/ajax/bigAction.jsp?id="+Integer.parseInt(request.getParameter("id")));
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
