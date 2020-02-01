/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.jdbc;

import database.daos.ConsoleDAO;
import database.entities.Prodotto;
import database.entities.Variante;
import database.exceptions.DAOException;
import database.exceptions.DAOFactoryException;
import database.factories.JDBCDAOFactory;
import static database.factories.JDBCDAOFactory.DBURL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import static tools.EncryptDecryptString.encrypt;
import static varie.Costanti.ENCRYPT_PASS;
import static varie.Costanti.ROB_PASS;

/**
 *
 * @author Roberto97
 */
@SuppressWarnings("unchecked")
public class JDBCConsoleDAO extends JDBCDAO implements ConsoleDAO {

    /**
     *
     * @param con
     * @throws SQLException
     */
    public JDBCConsoleDAO(Connection con) throws SQLException {
        super(con);
        try {
            checkCON();
        } catch (DAOException ex) {
            Logger.getLogger(JDBCConsoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Controlla che la connessione con il DB sia aperta, altrimenti la riapre
     *
     * @throws DAOException
     */
    @Override
    public final void checkCON() throws DAOException {
        try {
            if (this.CON == null || this.CON.isClosed() || !this.CON.isValid(0)) {
                this.daoFactory = new JDBCDAOFactory(DBURL);
                this.CON = daoFactory.getConnection();
            }
        } catch (SQLException | DAOFactoryException ex) {
            System.out.println("console jdbc checkCON catch");
            Logger.getLogger(JDBCConsoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Metodo che ogni volta che viene aperta una pagina controlla se è gia
     * stata vista in questa sessione e altrimenti incrementa il numero di
     * visualizzazioni e crea un attributo di sessione.
     *
     * @param page
     * @param request
     * @param id
     * @throws DAOException
     */
    @Override
    public void incrementViews(String page, HttpServletRequest request, int id) throws DAOException {
        checkCON();

        boolean check;

        /* Questo switch serve per trasformare la variabile page nelle principali
        locazioni, per esempio articolo in blog*/
        switch (page) {
            case (""):
                page = "home";
                break;
            case ("idea"):
                page = "idee";
                break;
            case ("articolo"):
                page = "blog";
                break;
            case ("prodotto"):
            case ("categoria"):
            case ("Dal Trentino"):
            case ("Alimenti Freschi"):
                page = "bottega";
                break;
        }
        if (page.equals("macelleria") || page.equals("ristorante") || page.equals("bottega") || page.equals("idee") || page.equals("blog") || page.equals("home")) {

            /* Controllo degli attributi di sessione */
            if (id > 0) {
                if (request.getSession().getAttribute("P" + page + "ID" + id + "SID" + request.getSession().getId()) != null) {
                    check = false;
                } else {
                    request.getSession().setAttribute("P" + page + "ID" + id + "SID" + request.getSession().getId(), "P" + page + "ID" + id + "SID" + request.getSession().getId());
                    check = true;
                }
            } else {
                if (request.getSession().getAttribute("P" + page + "SID" + request.getSession().getId()) != null) {
                    check = false;
                } else {
                    request.getSession().setAttribute("P" + page + "SID" + request.getSession().getId(), "P" + page + "SID" + request.getSession().getId());
                    check = true;
                }
            }

            if (check) {
                int views = -1;
                Calendar calendar = Calendar.getInstance();
                LocalDate monday;
                java.sql.Date ourJavaDateObject = new java.sql.Date(calendar.getTime().getTime());
                if (ourJavaDateObject.toLocalDate().getDayOfWeek().equals(DayOfWeek.MONDAY)) {
                    monday = ourJavaDateObject.toLocalDate();
                } else {
                    monday = ourJavaDateObject.toLocalDate().with(TemporalAdjusters.previous(DayOfWeek.MONDAY));
                }
                String query = "UPDATE weeks_views SET views = ? where pagina = ? AND week = ?;";
                try (PreparedStatement stm = CON.prepareStatement("SELECT views from weeks_views WHERE pagina = ? AND week = ?")) {
                    stm.setString(1, page);
                    stm.setDate(2, java.sql.Date.valueOf(monday));
                    try (ResultSet rs = stm.executeQuery()) {
                        while (rs.next()) {
                            views = rs.getInt("views") + 1;
                        }
                    }
                } catch (SQLException ex) {
                    throw new DAOException(ex);
                }

                if (views == -1) {
                    views = 1;
                    query = "INSERT INTO weeks_views (views, pagina, week) VALUES (?,?,?);";
                }
                //Aggiorna le view nella table tot_views_page
                try (PreparedStatement stm = CON.prepareStatement(query)) {
                    try {
                        stm.setInt(1, views);
                        stm.setString(2, page);
                        stm.setDate(3, java.sql.Date.valueOf(monday));

                        if (stm.executeUpdate() == 1) {
                        } else {
                            throw new DAOException("Impossible to update views1 of page: " + page);
                        }

                    } catch (SQLException ex) {
                        throw new DAOException(ex);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(JDBCConsoleDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    /**
     * Metodo per aggiungere o aggiornare un'iscrizione alla newsletter
     *
     * @param email
     * @throws DAOException
     */
    @Override
    public void add_updateEmailSub(String email) throws DAOException {
        checkCON();

        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Date date = new Date();
        String dateS = dateFormat.format(date);

        try (PreparedStatement stm = CON.prepareStatement(
                "INSERT INTO email_sub (email, date) VALUES (?,?) ON DUPLICATE KEY UPDATE date = ?;"
        )) {
            try {
                stm.setString(1, email);
                stm.setTimestamp(2, java.sql.Timestamp.valueOf(java.time.LocalDateTime.now()));
                stm.setTimestamp(3, java.sql.Timestamp.valueOf(java.time.LocalDateTime.now()));

                if (stm.executeUpdate() >= 1) {
                    System.out.println("email " + email + " aggiunta alla lista");
                }

            } catch (SQLException ex) {
                throw new DAOException(ex);
            }
        } catch (SQLException ex) {
            Logger.getLogger(JDBCConsoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Metodo per rimuovere un email dalla newsletter
     *
     * @param email
     * @throws DAOException
     */
    @Override
    public void removeEmailSub(String email) throws DAOException {
        checkCON();

        try (PreparedStatement stm = CON.prepareStatement(
                "delete from email_sub where email = ?;"
        )) {
            try {
                stm.setString(1, email);

                if (stm.executeUpdate() == 1) {
                } else {
                    throw new DAOException("Impossible to delete email sub");
                }

            } catch (SQLException ex) {
                throw new DAOException(ex);
            }
        } catch (SQLException ex) {
            Logger.getLogger(JDBCConsoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Metodo per aggiungere un nuovo ordine. Viene chiamato nell'urlack dopo il
     * pagamento
     *
     * @param request
     * @param IMPORTO
     * @param delivery
     * @throws DAOException
     */
    @Override
    public void addNewOrder(HttpServletRequest request, String IMPORTO, String delivery) throws DAOException {
        checkCON();

        HttpSession s = request.getSession();

        if (s.getAttribute("productdao") == null) {
            System.out.println("addNewOrder: productdao is null.");
        } else {
            if (IMPORTO == null) {
                System.out.println("addNewOrder: IMPORTO is null.");
            }

            String items = "", nome = "", cognome = "", email = "", citta = "", indirizzo = "", zip = "", importo = "", tipo = "", id = "", varianti = "";
            ArrayList<Prodotto> carrello = new ArrayList<>();

            if (s.getAttribute("ORDER_ID") != null) {
                id = (String) s.getAttribute("ORDER_ID");
            }
            if (s.getAttribute("NOME") != null) {
                nome = (String) s.getAttribute("NOME");
            }
            if (s.getAttribute("COGNOME") != null) {
                cognome = (String) s.getAttribute("COGNOME");
            }
            if (s.getAttribute("EMAIL") != null) {
                email = (String) s.getAttribute("EMAIL");
            }
            if (s.getAttribute("CITTA") != null) {
                citta = (String) s.getAttribute("CITTA");
            }
            if (s.getAttribute("INDIRIZZO") != null) {
                indirizzo = (String) s.getAttribute("INDIRIZZO");
            }
            if (s.getAttribute("ZIP") != null) {
                zip = (String) s.getAttribute("ZIP");
            }
            if (s.getAttribute("varianti") != null) {
                varianti = (String) s.getAttribute("varianti");
            }
            if (IMPORTO != null) {
                importo = IMPORTO.replace(",", ".");
            }
            if (delivery != null) {
                tipo = delivery;
            }
            if (s.getAttribute("CART") != null) {
                carrello = (ArrayList<Prodotto>) s.getAttribute("CART");
            }

            if (carrello != null) {
                for (Prodotto p : carrello) {
                    items += p.getNome() + "_" + p.getQuantita() + ";";
                }
                if (items.length() > 0 && items.charAt(items.length() - 1) == ';') {
                    items = items.substring(0, items.length() - 1);
                }

                /* Aggiungo l'ordine */
                LocalDateTime today = LocalDateTime.now().plusHours(2);
                Timestamp timeToday = Timestamp.valueOf(today);
                try (PreparedStatement stm = CON.prepareStatement("INSERT INTO orderSum (totale, delivery, items, nome, email, citta, indirizzo, zip, id, varianti, date) VALUES (?,?,?,?,?,?,?,?,?,?,?)")) {
                    try {
                        stm.setString(1, importo);
                        stm.setString(2, tipo);
                        stm.setString(3, items);
                        stm.setString(4, nome + " " + cognome);
                        stm.setString(5, email);
                        stm.setString(6, citta);
                        stm.setString(7, indirizzo);
                        stm.setString(8, zip);
                        stm.setString(9, id);
                        stm.setString(10, varianti);
                        stm.setTimestamp(11, timeToday);
                        stm.executeUpdate();
                    } catch (SQLException ex) {
                        throw new DAOException(ex);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(JDBCConsoleDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
                /*Fine aggiunta dei dati in orderSum*/

 /*Inizio di update di numero acquisti per i vari prodotti acquistati*/
                LinkedHashMap<ArrayList<Variante>, Integer> prodVars;
                boolean check;
                for (Prodotto p : carrello) {
                    check = false;
                    prodVars = getVariants(varianti);
                    int acquisti = 0;
                    int q = 0;

                    if (!prodVars.isEmpty()) {
                        for (Map.Entry<ArrayList<Variante>, Integer> entry : prodVars.entrySet()) {
                            ArrayList<Variante> key = entry.getKey();
                            Integer value = entry.getValue();
                            if (key != null && !key.isEmpty()) {
                                if (key.get(0).getId_prod() == p.getId()) {
                                    check = true;
                                    q += value;
                                }
                            }
                        }
                    }
                    if (!check) {
                        q = p.getQuantita();
                    }

                    try (PreparedStatement stm = CON.prepareStatement("SELECT num_acquisti from prodotto WHERE nome = ?")) {
                        stm.setString(1, p.getNome());
                        try (ResultSet rs = stm.executeQuery()) {
                            while (rs.next()) {
                                acquisti = rs.getInt("num_acquisti") + q;
                            }
                        }
                    } catch (SQLException ex) {
                        throw new DAOException(ex);
                    }

                    try (PreparedStatement stm = CON.prepareStatement(
                            "UPDATE prodotto SET num_acquisti = ? where nome = ?"
                    )) {
                        try {
                            stm.setInt(1, acquisti);
                            stm.setString(2, p.getNome());

                            if (stm.executeUpdate() == 1) {
                            } else {
                                throw new DAOException("Impossible to update num_acquisti of product: " + p.getNome());
                            }

                        } catch (SQLException ex) {
                            throw new DAOException(ex);
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(JDBCConsoleDAO.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            } else {
                System.out.println("carrello is NULL");
            }

            s.removeAttribute("IMPORTO");
            s.removeAttribute("ITEMS");
            s.removeAttribute("NOME");
            s.removeAttribute("COGNOME");
            s.removeAttribute("CITTA");
            s.removeAttribute("INDIRIZZO");
            s.removeAttribute("ZIP");
            s.removeAttribute("NOTE");
            s.removeAttribute("SUB");
            s.removeAttribute("SPEDIZIONE");
            s.removeAttribute("CART");
            s.removeAttribute("varianti");
        }
    }

    /**
     * Metodo per aggiungere le notifdiche quando succede qualcosa tipo nuovo
     * ordine, nuova idea dall'utente, nuovo commento o nuova valutazione
     *
     * @param testo
     * @param link
     * @throws DAOException
     */
    @Override
    public void addNotifica(String testo, String link) throws DAOException {
        checkCON();

        if (testo == null || link == null) {
        } else {

            try (PreparedStatement stm = CON.prepareStatement("INSERT INTO notifiche (testo, link) VALUES (?,?)")) {
                try {
                    stm.setString(1, testo);
                    stm.setString(2, link);
                    if (stm.executeUpdate() >= 1) {
                    } else {
                        throw new DAOException("Impossible to add notification");
                    }
                } catch (SQLException ex) {
                    throw new DAOException(ex);
                }
            } catch (SQLException ex) {
                Logger.getLogger(JDBCConsoleDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    /**
     * MEtodo che ritorna la variante partendo dall'id
     *
     * @param id
     * @return
     * @throws DAOException
     */
    @Override
    public Variante getVariant(int id) throws DAOException {
        checkCON();

        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM products_variants where id = ?")) {
            stm.setInt(1, id);
            Variante v = null;

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    v = new Variante();
                    v.setId(rs.getInt("id"));
                    v.setId_prod(rs.getInt("idProd"));
                    v.setVariant(rs.getString("variant"));
                    v.setVariantName(rs.getString("variantName"));
                    v.setSupplement(rs.getDouble("supplement"));
                    v.setPesoMaggiore(rs.getDouble("pesoMaggiore"));
                }
                return v;
            }
        } catch (SQLException ex) {
            //throw new DAOException("Impossibile restituire il prodotto. (JDBCProductDAO, getProduct)", ex);
            return null;
        }
    }

    /**
     * MEtodo che ritorna tutte le varianti partendo dalla stringa del cookie.
     * Crea un map con un arraylist di varianti che rappresenta le varie
     * combinazioni scelte e un intero che rappresenta la quantità scelta per
     * quella combinazione.
     *
     * @param var
     * @return
     * @throws DAOException
     */
    @Override
    public LinkedHashMap<ArrayList<Variante>, Integer> getVariants(String var) throws DAOException {

        LinkedHashMap<ArrayList<Variante>, Integer> varianti = new LinkedHashMap<>();

        ArrayList<Variante> prodVars;
        String[] blocchi;
        String[] vars;
        String[] ids;
        int q;

        if (var != null) {
            blocchi = var.split(":");
            if (blocchi.length > 0) {
                for (String s : blocchi) {
                    prodVars = new ArrayList<>();
                    vars = s.split("\\*");
                    if (vars.length > 1) {
                        ids = vars[0].split("_");
                        q = Integer.parseInt(vars[1]);
                        if (ids.length > 0) {
                            for (String f : ids) {
                                prodVars.add(getVariant(Integer.parseInt(f)));
                            }
                        }
                        varianti.put(prodVars, q);
                    }
                }
            }
        }

        return varianti;
    }

    @Override
    public Boolean getStatus() throws DAOException {
        checkCON();
        Boolean stato = true;

        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM statoSito")) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {                    
                    stato = rs.getBoolean("stato");
                }
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire lo stato. (JDBCProductDAO, getStatus)", ex);
        }
        return stato;
    }
}
