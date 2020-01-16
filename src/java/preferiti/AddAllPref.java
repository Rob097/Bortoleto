/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package preferiti;

import carrello.AddProd;
import database.daos.ProductDAO;
import database.entities.Variante;
import database.exceptions.DAOException;
import database.factories.DAOFactory;
import database.jdbc.JDBCProductDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
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
public class AddAllPref extends HttpServlet {

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
     * Questa servlet viene usata quando si vogliono aggiungere al carrello
     * tutti i prodotti presenti nei preferiti
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
        Cookie c;
        String preferiti = null, carrello = "", variant = "";
        String[] id, blocchi, VarQuan;
        int quantita = 1;
        ArrayList<Variante> varianti;

        if (cookies != null) {
            for (Cookie cc : cookies) {
                switch (cc.getName()) {
                    case "preferiti":
                        preferiti = cc.getValue();
                        break;
                    case "carrello":
                        carrello = cc.getValue();
                        break;
                    case "varianti":
                        variant = cc.getValue();
                        break;
                    default:
                        break;
                }
            }
        }

        if (preferiti != null) {
            id = preferiti.split("_");
            for (String id1 : id) {
                boolean ck = false;
                try {
                    varianti = productdao.getFrstVariantOfProduct(Integer.parseInt(id1));

                    if (varianti != null && !varianti.isEmpty()) {
                        String idVariant = "";
                        for (Variante v : varianti) {
                            idVariant += v.getId() + "_";
                        }
                        idVariant = idVariant.substring(0, idVariant.length() - 1);
                        if (variant != null) {
                            if (!variant.equals("")) {
                                blocchi = variant.split(":");
                                variant = "";
                                for (String blocchi1 : blocchi) {
                                    if (!blocchi1.startsWith("*")) {
                                        VarQuan = blocchi1.split("\\*");
                                        String vars = VarQuan[0];
                                        int q = Integer.parseInt(VarQuan[1]);
                                        if (vars.equals(idVariant)) {
                                            ck = true;
                                        }
                                        variant += vars + "*" + q + ":";
                                    }
                                }
                                if (!ck) {
                                    variant += idVariant + "*" + quantita + ":";
                                }
                                if (!variant.equals("")) {
                                    variant = variant.substring(0, variant.length() - 1);
                                }
                            } else {
                                variant = idVariant + "*" + quantita;
                            }
                        } else {
                            variant = idVariant + "*" + quantita;
                        }
                    }

                    if (carrello != null) {
                        if (!carrello.equals("")) {
                            if (!productdao.isInCart(Integer.parseInt(id1), request)) {
                                carrello = carrello + "_" + id1;
                            }
                        } else {
                            carrello = id1;
                        }
                    } else {
                        carrello = id1;
                    }

                } catch (DAOException ex) {
                    Logger.getLogger(AddAllPref.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        if (!variant.equals("")) {
            variant = variant.replace("__", "_");
            variant = variant.replace("::", ":");
            variant = variant.replace("**", "*");
            c = new Cookie("varianti", variant);
            c.setMaxAge(CART_COOKIE_MAX_AGE);
            c.setPath(request.getContextPath());
            //g.setDomain(DOMINIO);
            response.addCookie(c);
            s.setAttribute("varianti", variant);
        }
        if (!carrello.equals("")) {
            carrello = carrello.replace("__", "_");
            c = new Cookie("carrello", carrello);
            c.setMaxAge(CART_COOKIE_MAX_AGE);
            c.setPath(request.getContextPath());
            //g.setDomain(DOMINIO);
            response.addCookie(c);
            s.setAttribute("carrello", carrello);
        }

        response.sendRedirect("/Bortoleto/carrello.jsp");
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
