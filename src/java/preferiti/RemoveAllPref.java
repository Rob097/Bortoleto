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

/**
 *
 * @author Roberto97
 */
public class RemoveAllPref extends HttpServlet {
    private static final long serialVersionUID = 6106269076155338045L;
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * Questa servlet viene usata quand si vogliono eliminare dai preferiti tutti i preferiti.
     * 
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession s = request.getSession(false);
        Cookie[] cookies = request.getCookies();
        for (Cookie cc : cookies) {
            if (cc.getName().equals("preferiti")) {
                
                cc.setValue("");
                cc.setMaxAge(0);
                cc.setPath(request.getContextPath());
                response.addCookie(cc);
                s.setAttribute("preferiti", "");
            }
        }
        s.setAttribute("preferiti", null);
        response.sendRedirect(response.encodeURL("/Bortoleto/bottega.jsp"));
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
