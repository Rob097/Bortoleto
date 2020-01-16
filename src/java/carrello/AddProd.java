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
public class AddProd extends HttpServlet {

    private static final long serialVersionUID = 1L;

    ProductDAO productdao;
    String id1 = null, variant1 = null;

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
     * Servlet per aggiungere al carrello un determiinato prodotto. E'
     * richiamata da una funzione ajax e richiama il relativo metodo del JDBCDAO
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

        if (request.getParameter("variant") != null) {
            variant1 = request.getParameter("variant");
        } else if (request.getAttribute("variant") != null) {
            variant1 = (String) request.getAttribute("variant");
        }

        if (request.getParameter("id") != null) {
            id1 = request.getParameter("id");
        } else if (request.getAttribute("id") != null) {
            id1 = (String) request.getAttribute("id");
        }

        if (id1 != null) {
            try {
                String id = id1;

                if (productdao.getProduct(Integer.parseInt(id)).isDisponibile()) {

                    id = "";
                    int quantita = 1;
                    if (request.getParameter("quantita") != null) {
                        quantita = Integer.parseInt(request.getParameter("quantita"));
                    }
                    Cookie c;
                    Cookie[] cookies = request.getCookies();
                    if (cookies != null) {
                        for (Cookie cc : cookies) {
                            if (cc.getName().equals("carrello")) {
                                id = cc.getValue();
                            }
                        }
                    }

                    if (!checkVariant(request, response)) {

                        if (id != null) {
                            if (!id.equals("")) {
                                for (int i = 0; i < quantita; i++) {
                                    id = id + "_" + id1;
                                }
                            } else {
                                id = id1;
                                for (int i = 1; i < quantita; i++) {
                                    id = id + "_" + id1;

                                }
                            }
                        } else {
                            id = id1;
                            for (int i = 1; i < quantita; i++) {
                                id = id + "_" + id1;

                            }
                        }
                    } else {
                        if (id != null) {
                            if (!id.equals("")) {
                                if (!productdao.isInCart(Integer.parseInt(id1), request)) {
                                    id = id + "_" + id1;
                                }
                            } else {
                                id = id1;
                            }
                        } else {
                            id = id1;
                        }
                    }

                    id = id.replace("__", "_");

                    c = new Cookie("carrello", id);
                    c.setMaxAge(CART_COOKIE_MAX_AGE);
                    c.setPath(request.getContextPath());
                    //g.setDomain(DOMINIO);
                    response.addCookie(c);
                    s.setAttribute("carrello", id);

                    response.sendRedirect("/Bortoleto/ajax/carrelloModalContent.jsp");
                }
            } catch (DAOException ex) {
                Logger.getLogger(AddProd.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    /* Metodo per verificare se il prodotto che si vuole aggiungere è un prodotto con varianti */
    public boolean checkVariant(HttpServletRequest request, HttpServletResponse response) throws DAOException {

        if (request.getParameter("variant") != null) {
            variant1 = request.getParameter("variant");
        } else if (request.getAttribute("variant") != null) {
            variant1 = (String) request.getAttribute("variant");
        } else {
            variant1 = null;
        }

        if (request.getParameter("id") != null) {
            id1 = request.getParameter("id");
        } else if (request.getAttribute("id") != null) {
            id1 = (String) request.getAttribute("id");
        }

        if (id1 != null) {
            HttpSession s = request.getSession(false);
            String variant = "";
            /* Contiene le varianti gia salvate nel cookie */
            String[] blocchi;
            /*Contiene le varie combinazioni con le quantità*/
            String[] VarQuan;
            /* Cambia per ogni blocco e contiene la combinazione e la quantità */
            boolean check = false;
            Cookie c;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cc : cookies) {
                    if (cc.getName().equals("varianti")) {
                        variant = cc.getValue();
                    }
                }
            }

            if (variant1 != null && !variant1.isEmpty()) {
                int quantita = 1;
                if (request.getParameter("quantita") != null) {
                    quantita = Integer.parseInt(request.getParameter("quantita"));
                }

                if (variant != null) {
                    if (!variant.equals("")) {
                        /* Qui arrivi se esistono già varianti salvate */
                        blocchi = variant.split(":");
                            variant = "";
                            for (String blocchi1 : blocchi) {
                                if (!blocchi1.startsWith("*")) {
                                    VarQuan = blocchi1.split("\\*");
                                    String vars = VarQuan[0];
                                    /* Contiene la combinazione di varianti */
                                    int q = Integer.parseInt(VarQuan[1]);
                                    /* è la quantità della combinazione di varianti */
                                    if (vars.equals(variant1)) {
                                        /* se è uguale alla variante del prodotto che si vuole aggiungere modifica la quantità */
                                        q += quantita;
                                        check = true;
                                    }
                                    variant += vars + "*" + q + ":";
                                    /* Aggiungi la combinazione e la quantità alla stringa del nuovo cookie */
                                }
                            }
                            if (!check) {
                                variant += variant1 + "*" + quantita + ":";
                            }
                            variant = variant.substring(0, variant.length() - 1);
                    } else {
                        variant = variant1 + "*" + quantita;
                    }
                } else {
                    variant = variant1 + "*" + quantita;
                }
            } else {
                /* Se il prodotto ha le varianti ma non sono state selezionate (da bottega.jsp o dai preferiti) scegliamo la variante di default*/
                int quantita = 1;
                boolean ck = false;
                ArrayList<Variante> varianti;
                varianti = productdao.getFrstVariantOfProduct(Integer.parseInt(id1));
                if (varianti == null || varianti.isEmpty()) {
                    return false;
                } else {
                    String idVariant = "";
                    idVariant = varianti.stream().map((v) -> v.getId() + "_").reduce(idVariant, String::concat);
                    idVariant = idVariant.substring(0, idVariant.length() - 1);
                    if (request.getParameter("quantita") != null) {
                        quantita = Integer.parseInt(request.getParameter("quantita"));
                    }

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
                                            q += quantita;
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
            }

            variant = variant.replace("__", "_");
            variant = variant.replace("::", ":");
            variant = variant.replace("**", "*");
            c = new Cookie("varianti", variant);
            c.setMaxAge(CART_COOKIE_MAX_AGE);
            c.setPath(request.getContextPath());
            //g.setDomain(DOMINIO);
            response.addCookie(c);
            s.setAttribute("varianti", variant);
            return true;
        } else {
            return false;
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
