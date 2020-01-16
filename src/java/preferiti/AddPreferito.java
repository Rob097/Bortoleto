/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package preferiti;

import database.factories.DAOFactory;
//import static filters.variabiliGlobali.DOMINIO;
import java.io.IOException;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.Set;
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
public class AddPreferito extends HttpServlet {
    private static final long serialVersionUID = 6106269076155338045L;
    
    @Override
    public void init() throws ServletException {
        //carica la Connessione inizializzata in JDBCDAOFactory, quindi ritorna il Class.for() e la connessione
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        
    }
    
    
    /**
     * Handles the HTTP <code>POST</code> method.
     * 
     * Questa servlet viene usata quando i vuole aggiungere al carrello un prodotto
     * presente nei preferiti
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
        Cookie c;  
        Cookie[] cookies = request.getCookies();
        //if(cookies != null){
            for(Cookie cc : cookies){
                if(cc.getName().equals("preferiti")){
                    id = cc.getValue();
                }
            }   
        //}
        if(request.getParameter("id") != null){
            if(id != null)
                id = id + "_"+request.getParameter("id");
            else
                id = request.getParameter("id");
            
            //evito i duplicati
            String[] array = id.split("_");
            Set<String> set = new LinkedHashSet<>();

            set.addAll(Arrays.asList(array));
            
            array = new String[set.size()];
            set.toArray(array);
            if(array.length == 1){
                id = array[0];
            }else{
                id = array[0];
                for(int i = 1; i < array.length; i++){
                    id = id + "_"+array[i];
                }
            }
            //Fine duplicati   
            
            
            c = new Cookie("preferiti", id);
            c.setMaxAge(PREF_COOKIE_MAX_AGE);            
            c.setPath(request.getContextPath());
            //g.setDomain(DOMINIO);
            response.addCookie(c);
            s.setAttribute("preferiti", id);
            response.sendRedirect("/Bortoleto/ajax/bigAction.jsp?id="+Integer.parseInt(request.getParameter("id")));
            
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
