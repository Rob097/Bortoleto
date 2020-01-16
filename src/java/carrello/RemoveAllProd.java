/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package carrello;

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
public class RemoveAllProd extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * Serrvlet per svuotare il carrello.
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
        HttpSession s = request.getSession(false);
        Cookie[] cookies = request.getCookies();
        for (Cookie cc : cookies) {
            if (cc.getName().equals("carrello")) {
                
                cc.setValue("");
                cc.setMaxAge(0);
                cc.setPath(request.getContextPath());
                response.addCookie(cc);
                s.setAttribute("carrello", "");
            }
            if (cc.getName().equals("varianti")) {
                
                cc.setValue("");
                cc.setMaxAge(0);
                cc.setPath(request.getContextPath());
                response.addCookie(cc);
                s.setAttribute("varianti", "");
            }
        }
        response.sendRedirect("/Bortoleto/ajax/carrelloModalContent.jsp");
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
