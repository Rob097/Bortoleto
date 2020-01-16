/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package carrello;

import database.daos.ProductDAO;
import database.entities.Variante;
import database.exceptions.DAOException;
import database.factories.DAOFactory;
import database.jdbc.JDBCProductDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import static varie.Costanti.CART_COOKIE_MAX_AGE;

/**
 *
 * @author Roberto97
 */
public class RemoveProd extends HttpServlet {

    private static final long serialVersionUID = 1L;

    ProductDAO productdao;

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
            Logger.getLogger(AddProd.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * Serrvlet per rimuovere un prodotto dal carrello. richiama il relativo
     * metodo di JDBCDAO ed è chiamata da una fuznzione ajax.
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

            String variante = null;
            if (request.getParameter("variante") != null) {
                variante = request.getParameter("variante");
            }

            LinkedHashMap<ArrayList<Variante>, Integer> prodVariant = productdao.getCartProductVariant(request, Integer.parseInt(request.getParameter("id")));

            if (variante == null || variante.equals("")) {
                removeProduct(request, response);
                if (prodVariant != null && !prodVariant.isEmpty()) {
                    removeALLVariants(request, response, Integer.parseInt(request.getParameter("id")));
                }
            } else {
                removeVariant(request, response, variante);
                if (prodVariant == null || prodVariant.size() <= 1) {
                    removeProduct(request, response);
                }
            }
            /*ProductDAO productdao = (ProductDAO) s.getAttribute("productdao");
            productdao.checkWeight(request, response);*/
            response.sendRedirect("/Bortoleto/ajax/carrelloModalContent.jsp");
        } catch (DAOException ex) {
            Logger.getLogger(RemoveProd.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void removeProduct(HttpServletRequest request, HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();
        Cookie c = null;
        String[] idProducts = null;
        String ids = "";
        HttpSession s = request.getSession(false);
        String id = null;

        for (Cookie cc : cookies) {
            if (cc.getName().equals("carrello")) {
                c = cc;
            }
        }
        if (c != null) {
            idProducts = c.getValue().split("_");
        }
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
        if (!ids.isEmpty()) {
            c = new Cookie("carrello", ids);
            c.setMaxAge(CART_COOKIE_MAX_AGE);
            c.setPath(request.getContextPath());
            //c.setDomain(DOMINIO);
            response.addCookie(c);
            /*if (id != null) {
                s.setAttribute("carrello", id);
            }*/
        } else {
            //c = new Cookie("preferiti", ids);
            //c.setDomain(DOMINIO);
            //response.addCookie(c);
            if (c != null) {
                c.setMaxAge(0);
                c.setPath(request.getContextPath());
                //c.setDomain(DOMINIO);
                response.addCookie(c);
            }
            s.setAttribute("carrello", null);
        }
    }

    public void removeVariant(HttpServletRequest request, HttpServletResponse response, String variante) {
        HttpSession s = request.getSession(false);
        Cookie c;
        String ids = "";
        try {
            LinkedHashMap<ArrayList<Variante>, Integer> varianti = productdao.getCartVariant(request);
            String v;
            if (varianti != null) {
                for (Map.Entry<ArrayList<Variante>, Integer> entry : varianti.entrySet()) {
                    ArrayList<Variante> key = entry.getKey();
                    Integer value = entry.getValue();
                    v = productdao.getVariantBlock(key);
                    if (v.equals(variante)) {
                    } else {
                        ids += v + "*" + value + ":";
                    }
                }
                if (!ids.equals("")) {
                    ids = ids.substring(0, ids.length() - 1);
                    c = new Cookie("varianti", ids);
                    c.setMaxAge(CART_COOKIE_MAX_AGE);
                    c.setPath(request.getContextPath());
                    response.addCookie(c);
                    request.getSession().setAttribute("varianti", ids);
                } else {
                    c = new Cookie("varianti", ids);
                    c.setValue("");
                    c.setMaxAge(0);
                    c.setPath(request.getContextPath());
                    response.addCookie(c);
                    s.setAttribute("varianti", "");
                }
            }
        } catch (DAOException ex) {
            Logger.getLogger(RemoveProd.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void removeALLVariants(HttpServletRequest request, HttpServletResponse response, int idProd) {
        HttpSession s = request.getSession(false);
        Cookie c;
        String ids = "";

        try {
            //LinkedHashMap<ArrayList<Variante>, Integer> prodVariant = productdao.getCartProductVariant(request, idProd);
            LinkedHashMap<ArrayList<Variante>, Integer> varianti = productdao.getCartVariant(request);
            String v;
            if (varianti != null) {
                for (Map.Entry<ArrayList<Variante>, Integer> entry : varianti.entrySet()) {
                    ArrayList<Variante> key = entry.getKey();
                    Integer value = entry.getValue();
                    v = productdao.getVariantBlock(key);
                    if (key != null && !key.isEmpty()) {
                        
                        if (key.get(0).getId_prod() != idProd) {
                            ids += v + "*" + value + ":";
                        }
                        
                    }
                }
                if (!ids.equals("")) {
                    ids = ids.substring(0, ids.length() - 1);
                    c = new Cookie("varianti", ids);
                    c.setMaxAge(CART_COOKIE_MAX_AGE);
                    c.setPath(request.getContextPath());
                    response.addCookie(c);
                    request.getSession().setAttribute("varianti", ids);
                } else {
                    c = new Cookie("varianti", ids);
                    c.setValue("");
                    c.setMaxAge(0);
                    c.setPath(request.getContextPath());
                    response.addCookie(c);
                    s.setAttribute("varianti", "");
                }
            }
        } catch (DAOException ex) {
            Logger.getLogger(RemoveProd.class.getName()).log(Level.SEVERE, null, ex);
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
