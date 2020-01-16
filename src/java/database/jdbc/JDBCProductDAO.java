package database.jdbc;

import database.daos.ProductDAO;
import database.entities.Prodotto;
import database.entities.Variante;
import database.exceptions.DAOException;
import database.exceptions.DAOFactoryException;
import database.factories.JDBCDAOFactory;
import static database.factories.JDBCDAOFactory.DBURL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import static varie.Costanti.CART_COOKIE_MAX_AGE;
import static varie.Costanti.MAX_W_PRICE;
import static varie.Costanti.MED_W_PRICE;
import static varie.Costanti.MIN_W_PRICE;
import static varie.Costanti.MIN_COSTO;
import static varie.Costanti.MAX_COSTO;
import static varie.Costanti.MED_COSTO;

/**
 * JDBCDAO Per i metodi relativi ai Prodotti dell'ecommerce
 *
 * @author Roberto97
 */
public class JDBCProductDAO extends JDBCDAO implements ProductDAO {

    /**
     * Questa è il costruttore e serve fondamentalmente per collegarsi alla
     * connessione aperta con il DB
     *
     * @param con E' la connessione al DB
     * @throws java.sql.SQLException
     */
    public JDBCProductDAO(Connection con) throws SQLException {
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
     * Metodo che ritorna un arrayList di tutti i prodotti del DB<br>
     * Lo uso in casi come per il ciclo per stampare tutti i prodotti, ma anche
     * per salvare i prodotti in attributi di sessione (?)
     *
     * @return Ritorna un arrayList di tutti i prodotti del DB
     * @throws DAOException
     */
    @Override
    public ArrayList<Prodotto> getAllProducts() throws DAOException {
        checkCON();

        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM prodotto")) {
            ArrayList<Prodotto> prodotti = new ArrayList<>();

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    p.setDescrizione(rs.getString("descrizione"));
                    p.setImmagine(rs.getString("immagine"));
                    p.setCategoria(rs.getString("categoria"));
                    p.setCosto(rs.getFloat("costo"));
                    p.setDisponibile(rs.getBoolean("disponibile"));
                    p.setFresco(rs.getBoolean("fresco"));
                    prodotti.add(p);
                }

                return prodotti;
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire tutti i prodotti. (JDBCProductDAO, getAllProducts)", ex);
        }
    }

    /**
     * Metodo che ritorna tutti i prodotti che sono classificati come prodotti
     * freschi.<br>
     * Quindi qguarda l'attributo boolean fresco dei prodotti nel DB e prende i
     * true
     *
     * @return Ritorna un arrayList di tutti i prodotti FRESCHI del DB
     * @throws DAOException
     */
    @Override
    public ArrayList<Prodotto> getFreshProducts() throws DAOException {
        checkCON();

        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM prodotto where fresco = 1")) {
            ArrayList<Prodotto> prodotti = new ArrayList<>();

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    p.setDescrizione(rs.getString("descrizione"));
                    p.setImmagine(rs.getString("immagine"));
                    p.setCategoria(rs.getString("categoria"));
                    p.setCosto(rs.getFloat("costo"));
                    p.setDisponibile(rs.getBoolean("disponibile"));
                    p.setFresco(rs.getBoolean("fresco"));
                    prodotti.add(p);
                }

                return prodotti;
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire i prodotti freschi. (JDBCProductDAO, getFreshProducts)", ex);
        }
    }

    /**
     * Metodo che ritorna tutti i prodotti che sono classificati come prodotti
     * NON freschi.<br>
     * Quindi qguarda l'attributo boolean fresco dei prodotti nel DB e prende i
     * false
     *
     * @return Ritorna un arrayList di tutti i prodotti NON freschi del DB
     * @throws DAOException
     */
    @Override
    public ArrayList<Prodotto> getConfProducts() throws DAOException {
        checkCON();

        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM prodotto where fresco = 0")) {
            ArrayList<Prodotto> prodotti = new ArrayList<>();

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    p.setDescrizione(rs.getString("descrizione"));
                    p.setImmagine(rs.getString("immagine"));
                    p.setCategoria(rs.getString("categoria"));
                    p.setCosto(rs.getFloat("costo"));
                    p.setDisponibile(rs.getBoolean("disponibile"));
                    p.setFresco(rs.getBoolean("fresco"));
                    prodotti.add(p);
                }

                return prodotti;
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire i prodotti Conf. (JDBCProductDAO, getConfProducts)", ex);
        }
    }

    /**
     * Metodo che serve a trovare tutti i prodotti di una determinata cattegoria
     * di prodotti.<br>
     * Guarda l'attributo categoria nel DB che è una foreign key alla tabella
     * categoria.
     *
     * @param categoryName E' una Stringa con il nome della categoria da cercare
     * i prodotti
     * @return Ritorna un ArrayList di prodotti con attributo categoria uguale
     * al parametro CategoryName
     * @throws DAOException
     */
    @Override
    public ArrayList<Prodotto> getAllProductsOfCategory(String categoryName) throws DAOException {
        checkCON();

        if (categoryName == null) {
            throw new DAOException("categoryName is a mandatory fields", new NullPointerException("categoryName is null"));
        }
        if (categoryName.contains("'") || categoryName.contains("\"")) {
            categoryName = categoryName.replace("\"", "").replace("'", "");
        }
        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM prodotto where categoria = ?")) {
            stm.setString(1, categoryName);
            ArrayList<Prodotto> prodotti = new ArrayList<>();

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    p.setDescrizione(rs.getString("descrizione"));
                    p.setImmagine(rs.getString("immagine"));
                    p.setCategoria(rs.getString("categoria"));
                    p.setCosto(rs.getFloat("costo"));
                    p.setDisponibile(rs.getBoolean("disponibile"));
                    p.setFresco(rs.getBoolean("fresco"));
                    prodotti.add(p);
                }

                return prodotti;
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire tutti i prodotti della categoria. (JDBCProductDAO, getAllProductsOfCategory)", ex);
        }
    }

    /**
     * Metodo per ritrovare un prodotto in base all'id
     *
     * @param id
     * @return Ritorna un prodotto
     * @throws DAOException
     */
    @Override
    public Prodotto getProduct(int id) throws DAOException {
        checkCON();

        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM prodotto where id = ?")) {
            stm.setInt(1, id);
            Prodotto p = null;

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    p = new Prodotto();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    p.setDescrizione(rs.getString("descrizione"));
                    p.setImmagine(rs.getString("immagine"));
                    p.setCategoria(rs.getString("categoria"));
                    p.setCosto(rs.getFloat("costo"));
                    p.setDisponibile(rs.getBoolean("disponibile"));
                    p.setFresco(rs.getBoolean("fresco"));
                }
                return p;
            }
        } catch (SQLException ex) {
            //throw new DAOException("Impossibile restituire il prodotto. (JDBCProductDAO, getProduct)", ex);
            return null;
        }
    }

    /**
     * Metodo che analizza un determinato attributo di sessione.<br>
     * Fondamentalmente viene passato il contenuto di un attributo di sessione
     * come può essere l'attributo "preferiti" il quale è formato da tante
     * stringhe di id separate da underscore. Poi separa tutti gli id e prende
     * il prodotto con quell'id e lo aggiunge ad un ArrayList di Prodotto.<br>
     * Questo metodo è stato fatto perchè all'inizio il filtro CookieFilter
     * aggiunge tutti i preferiti del cookie preferiti ad un attributo di
     * sessione e in questo modo si riesce a recuperare tutti i preferiti.
     * Questo metodo viene usato solo per questo scopo.
     *
     * @param ids è il contenuto dell'attributo di sessione preferiti e quindi
     * una concatenzazione di id tramite _
     * @return Ritorna i preferiti aggregati in un ArrayList di prodotti
     * @throws DAOException
     */
    @Override
    public ArrayList<Prodotto> getAllProductsOfSession(String ids) throws DAOException {
        checkCON();

        ArrayList<Prodotto> prodotti = new ArrayList<>();
        if (ids.equals("") || ids.isEmpty()) {
            return prodotti;
        }
        int id;
        String[] idProducts = ids.split("_");
        for (String s : idProducts) {
            if (s.isEmpty() || s.equals("")) {
                System.out.println("Stringa vuota: " + s);
            } else {
                id = Integer.parseInt(s);

                try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM prodotto where id = ?")) {
                    stm.setInt(1, id);

                    try (ResultSet rs = stm.executeQuery()) {
                        while (rs.next()) {
                            Prodotto p = new Prodotto();
                            p.setId(rs.getInt("id"));
                            p.setNome(rs.getString("nome"));
                            p.setDescrizione(rs.getString("descrizione"));
                            p.setImmagine(rs.getString("immagine"));
                            p.setCategoria(rs.getString("categoria"));
                            p.setCosto(rs.getFloat("costo"));
                            p.setDisponibile(rs.getBoolean("disponibile"));
                            p.setFresco(rs.getBoolean("fresco"));
                            prodotti.add(p);
                        }
                    }
                } catch (SQLException ex) {
                    throw new DAOException("Impossibile restituire tutti i prodotti della sessione. (JDBCProductDAO, getAllProductsOfSession)", ex);
                }
            }

        }

        Collections.reverse(prodotti);
        return prodotti;
    }

    /**
     * Metodo usato per capire se un determinato prodotto è salvato nei
     * preferiti.<br>
     * Questo metodo viene usato in bottega.jsp o nei file richiamati da
     * funzioni ajax per capire se un determinato prodotto è salvato nei
     * preferiti e se lo è allora colora il cuore di rosso e imposta la action a
     * RemoveffromPreferiti altrimenti lo lascia grigio e la action resta
     * addtoPreferiti.
     *
     * @param id Indica l'id del prodotto da controlalre
     * @param request E' un httpRequest per poter controllare le sessioni
     * @return Ritorna un boolean. Se è preferito true altrimenti false.
     * @throws DAOException
     */
    @Override
    public boolean isPreferito(int id, HttpServletRequest request) throws DAOException {
        checkCON();

        String ids = (String) request.getSession().getAttribute("preferiti");

        String[] idProducts = null;
        if (ids != null) {
            idProducts = ids.split("_");
        }

        if (idProducts != null) {
            for (String s : idProducts) {
                if (s.equals("" + id)) {
                    return true;
                }
            }
        }

        return false;

    }

    /**
     * Metodo usato per capire se un determinato prodotto è salvato nel
     * carrello.<br>
     * Questo metodo viene usato in bottega.jsp o nei file richiamati da
     * funzioni ajax per capire se un determinato prodotto è salvato nel
     * carrelllo e se lo è allora colora il simbolino + nei modal preferiti
     * diventà una spunta verde altrimenti lascia il + grigio e la action resta
     * addtoCart.
     *
     * @param id Indica l'id del prodotto da controllare
     * @param request E' un httpRequest per poter controllare le sessioni
     * @return Ritorna un boolean. Se è nel carrello true altrimenti false.
     * @throws DAOException
     */
    @Override
    public boolean isInCart(int id, HttpServletRequest request) throws DAOException {
        checkCON();

        String ids = (String) request.getSession().getAttribute("carrello");

        String[] idProducts = null;
        if (ids != null) {
            idProducts = ids.split("_");
        }

        if (idProducts != null) {
            for (String s : idProducts) {
                if (s.equals("" + id)) {
                    return true;
                }
            }
        }

        return false;

    }

    /**
     * Metodo che serve a recuperare tutti i prodotti salvati nel carrello con
     * le relative quantità.<br>
     * Qusto metodo controlla il cookie carrello e crea dei prodotti con la
     * quantità settata n modo corretto. Dopodiché aggiunge il prodotto ad un
     * arraylist di prodotti. Alla finel'arraylist viene ordinato in modo che il
     * primo prodotto della lista sia l'ultimo aggiunto.<br>
     * Nel frattempo viene controllato che tutti i prodotti siano disponibili,
     * altrimenti li rimuove dal carrello. Viene usato per creare le varie
     * visualizzazioni del carrello.
     *
     * @param request E' un httpRequest per poter controllare i cookies.
     * @return Ritorna un ArrayList di prodotti contenente tutti i prodotti
     * salvati nel carrello
     * @throws DAOException
     */
    @Override
    public ArrayList<Prodotto> getAllProductsOfCart(HttpServletRequest request) throws DAOException {
        checkCON();

        ArrayList<Prodotto> prodotti = new ArrayList<>();
        Prodotto p;
        Cookie[] cookies = request.getCookies();
        String ids = null;
        String[] id = null;
        boolean check = false;
        boolean dispCheck = false;

        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("carrello")) {
                    ids = c.getValue();
                }
            }
        }
        if (ids != null) {
            id = ids.split("_");
        }
        if (id != null) {
            for (String s : id) {
                if (!s.equals("")) {
                    if (prodotti.isEmpty()) {
                        p = getProduct(Integer.parseInt(s));
                        if (p != null && p.isDisponibile()) {
                            p.setQuantita(1);
                            prodotti.add(p);
                        } else {
                            dispCheck = true;
                        }
                    } else {
                        for (Prodotto o : prodotti) {
                            if (o.getId() == Integer.parseInt(s)) {
                                check = true;
                            }
                        }
                        if (check) {
                            prodotti.stream().filter((o) -> (o.getId() == Integer.parseInt(s))).forEachOrdered((o) -> {
                                o.setQuantita(o.getQuantita() + 1);
                            });
                        } else {
                            p = getProduct(Integer.parseInt(s));
                            if (p.isDisponibile()) {
                                p.setQuantita(1);
                                prodotti.add(p);
                            } else {
                                dispCheck = true;
                            }
                        }
                        check = false;
                    }
                }
            }
        }

        if (dispCheck) {
            String cart = checkDisponibile(ids);

            if (cookies != null) {
                for (Cookie c : cookies) {
                    if (c.getName().equals("carrello")) {
                        c.setValue(cart);
                    }
                }
            }
            request.getSession().setAttribute("carrello", cart);
        }

        if (!prodotti.isEmpty()) {
            Collections.reverse(prodotti);
            return prodotti;
        } else {
            return null;
        }
    }

    /**
     * Metodo per calcolare il SubTotale del carrello.<br>
     * Questo metodo serve per capire quanto costano i prodotti salvati nel
     * carrello considerando le quantità.<br> Viene usato per le varie
     * visualizzazioni.
     *
     * @param request E' un httpRequest da passare ad altri metodi richiamati.
     * @return Ritorna una stringa uguale al subtotale del carrello con due
     * cifre decimali.
     * @throws DAOException
     */
    @Override
    public String getTotalOfCart(HttpServletRequest request) throws DAOException {
        checkCON();

        ArrayList<Prodotto> prodotti = getAllProductsOfCart(request);
        LinkedHashMap<ArrayList<Variante>, Integer> varianti;
        DecimalFormat df = new DecimalFormat("0.00");
        df.setMaximumFractionDigits(2);
        double totale = 0.00, varTot;

        try {
            if (prodotti != null) {
                for (Prodotto p : prodotti) {
                    varianti = getCartProductVariant(request, p.getId());

                    if (!varianti.isEmpty()) {
                        for (Map.Entry<ArrayList<Variante>, Integer> entry : varianti.entrySet()) {
                            varTot = 0.00;
                            ArrayList<Variante> key = entry.getKey();
                            Integer value = entry.getValue();
                            varTot = key.stream().map((v) -> v.getSupplement()).reduce(varTot, (accumulator, _item) -> accumulator + _item);
                            totale += (df.parse(p.getCosto()).doubleValue() + varTot) * value;
                        }
                    } else {
                        totale += (df.parse(p.getCosto()).doubleValue() * p.getQuantita());
                    }
                }
            }
        } catch (ParseException ex) {
            Logger.getLogger(JDBCProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        String totaleS = String.format("%.2f", totale).replace(",", ".");
        return totaleS;
    }

    /**
     * Metodo per calcolare il costo dei singoli prodotti del carrello
     * considerando le quantità<br>
     *
     * @param quantita Indica la quantità del prodotto nel carrello
     * @param costo Indica il costo per unità del prodotto.
     * @return Ritorna una stringa uguale al parziale del prodotto nel carrello
     * con due cifre decimali.
     * @throws DAOException
     */
    @Override
    public String getPartial(int quantita, String costo) throws DAOException {
        checkCON();

        double parziale = 0.00;
        DecimalFormat df = new DecimalFormat("0.00");
        df.setMaximumFractionDigits(2);

        try {
            parziale = (df.parse(costo).doubleValue() * quantita);
        } catch (ParseException ex) {
            Logger.getLogger(JDBCProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        String parzialeS = String.format("%.2f", parziale);
        return parzialeS;
    }

    /**
     * Metodo per modificare la quantità di un prodotto nel carrello.<br>
     * Questo metodo prende tutti i prodotti del carrello, poi prende il
     * prodotto con l'id uguale al parametro passato, poi aggiunge tutti i
     * prodotti diversi da quest'ultimo ad una stringa separando le id con _ .
     * Dopodiché aggiunge l'id del prodotto tante volte quanto è il numero di
     * quantità del parametro passato.<br>
     * Infine modifica il cookie e l'attributo di sessione carrello.
     *
     * @param id Indica l'id del prodotto a cui modificare la quantità.
     * @param variante
     * @param quantita Indica la quantità che si vuole ottenere per quel
     * prodotto.
     * @param request E' un httpRequest da passare ad altri metodi richiamati e
     * per ritrovare i cookie e la sessione.
     * @param response Eè un HttpResponse a cui si aggiunge la nuova versione
     * del cookie carrello.
     * @throws DAOException
     */
    @Override
    public void updateQuantity(int id, String variante, int quantita, HttpServletRequest request, HttpServletResponse response) throws DAOException {
        checkCON();

        String ids = "";

        if (variante == null || variante.equals("")) {
            ArrayList<Prodotto> prodotti = getAllProductsOfCart(request);
            Prodotto p;
            if (prodotti != null) {
                for (int i = 0; i < prodotti.size(); i++) {
                    p = prodotti.get(i);
                    if (p.getId() == id) {
                        p.setQuantita(quantita);
                    } else {
                    }
                }
                Collections.reverse(prodotti);
                for (Prodotto u : prodotti) {
                    for (int i = 1; i <= u.getQuantita(); i++) {
                        ids += "" + u.getId() + "_";
                    }
                }

                Cookie c = new Cookie("carrello", ids);
                c.setMaxAge(CART_COOKIE_MAX_AGE);
                c.setPath(request.getContextPath());
                response.addCookie(c);
                request.getSession().setAttribute("carrello", ids);

            }
        } else {
            LinkedHashMap<ArrayList<Variante>, Integer> varianti = getCartVariant(request);
            boolean check = false;
            String v;
            if (varianti != null) {
                for (Map.Entry<ArrayList<Variante>, Integer> entry : varianti.entrySet()) {
                    ArrayList<Variante> key = entry.getKey();
                    Integer value = entry.getValue();
                    v = getVariantBlock(key);
                    if (v.equals(variante)) {
                        if (!check) {
                            ids += v + "*" + quantita + ":";
                            check = true;
                        }
                    } else {
                        ids += v + "*" + value + ":";
                    }
                }
                ids = ids.substring(0, ids.length() - 1);
                Cookie c = new Cookie("varianti", ids);
                c.setMaxAge(CART_COOKIE_MAX_AGE);
                c.setPath(request.getContextPath());
                response.addCookie(c);
                System.out.println(c.getName() + ", " + c.getMaxAge());
                request.getSession().setAttribute("varianti", ids);
            }
        }

    }

    /**
     * Metodo che restituisce il numero di prodotti nel carrello considerando le
     * quantità.
     *
     * @param request
     * @return Ritorna un int uguale al numero di unità presenti nel carrello
     * @throws DAOException
     */
    @Override
    public int getCartSize(HttpServletRequest request) throws DAOException {
        checkCON();

        ArrayList<Prodotto> cart = getAllProductsOfCart(request);
        LinkedHashMap<ArrayList<Variante>, Integer> prodVar;
        int q = 0;

        if (cart != null && !cart.isEmpty()) {
            for (Prodotto p : cart) {
                prodVar = getCartProductVariant(request, p.getId());
                if (!prodVar.isEmpty()) {
                    for (Map.Entry<ArrayList<Variante>, Integer> entry : prodVar.entrySet()) {
                        Integer value = entry.getValue();
                        q += value;
                    }
                } else {
                    q += p.getQuantita();
                }
            }
        }
        return q;

    }

    /**
     * Metodo per inviare la valutazione di un prodotto. Setta i valori delle
     * varie stelle sostituendo quelli vecchi.
     *
     * @param id E' l'id del prodotto che si vuole valutare
     * @param value E' il valore della valutazione che sivuole lasciare.
     * @throws DAOException
     */
    @Override
    public void setRate(int id, double value) throws DAOException {
        checkCON();

        int number5 = 0, number45 = 0, number4 = 0, number35 = 0, number3 = 0, number25 = 0, number2 = 0, number15 = 0, number1 = 0, number05 = 0;

        try (PreparedStatement stm = CON.prepareStatement("select * from valutazione_prod where id_prod = ?")) {
            stm.setInt(1, id);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    number5 = rs.getInt("rate5");
                    number45 = rs.getInt("rate45");
                    number4 = rs.getInt("rate4");
                    number35 = rs.getInt("rate35");
                    number3 = rs.getInt("rate3");
                    number25 = rs.getInt("rate25");
                    number2 = rs.getInt("rate2");
                    number15 = rs.getInt("rate15");
                    number1 = rs.getInt("rate1");
                    number05 = rs.getInt("rate05");

                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(JDBCProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (value == 0.5) {
            number05++;
        } else if (value == 1.0) {
            number1++;
        } else if (value == 1.5) {
            number15++;
        } else if (value == 2.0) {
            number2++;
        } else if (value == 2.5) {
            number25++;
        } else if (value == 3.0) {
            number3++;
        } else if (value == 3.5) {
            number35++;
        } else if (value == 4.0) {
            number4++;
        } else if (value == 4.5) {
            number45++;
        } else if (value == 5.0) {
            number5++;
        }

        value = (number05 * 0.5 + number1 * 1 + number15 * 1.5 + number2 * 2 + number25 * 2.5 + number3 * 3 + number35 * 3.5 + number4 * 4 + number45 * 4.5 + number5 * 5) / (number05 + number1 + number15 + number2 + number25 + number3 + number35 + number4 + number45 + number5);

        String val = String.format("%.2f", value).replace(",", ".");
        value = Double.parseDouble(val);

        try (PreparedStatement statement = CON.prepareStatement("REPLACE INTO valutazione_prod (id_prod, rate5,rate4,rate3,rate2,rate1,rate05,rate15,rate25,rate35,rate45, value) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)")) {

            statement.setInt(1, id);

            statement.setInt(7, number05);
            statement.setInt(6, number1);
            statement.setInt(8, number15);
            statement.setInt(5, number2);
            statement.setInt(9, number25);
            statement.setInt(4, number3);
            statement.setInt(10, number35);
            statement.setInt(3, number4);
            statement.setInt(11, number45);
            statement.setInt(2, number5);
            statement.setDouble(12, value);
            if (statement.executeUpdate() > 0) {

            } else {
                throw new DAOException("Impossible to update the User");
            }

        } catch (SQLException ex) {
            throw new DAOException(ex);

        }
    }

    /**
     * Metodo che ritorna la valutazione media di un prodotto.
     *
     * @param id E' l'id del prodotto che si vuole conoscere la valutazione
     * @return Ritorna il valore della valutazione per esempio 4.5
     * @throws DAOException
     */
    @Override
    public double getRate(int id) throws DAOException {
        checkCON();

        double val = 0;
        try (PreparedStatement stm = CON.prepareStatement("select * from valutazione_prod where id_prod = ?")) {
            stm.setInt(1, id);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    val = rs.getDouble("value");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(JDBCProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return val;
    }

    /**
     * Metodo che restituisce il numero di valutazioni per un determinato
     * prodotto.
     *
     * @param id Indica l'id per cui si vuole conoscere il numero di valutazioni
     * esistenti
     * @return Ritorna il valore intero del numero di valutazioni.
     * @throws DAOException
     */
    @Override
    public int getNumberRate(int id) throws DAOException {
        checkCON();

        int val = 0;
        try (PreparedStatement stm = CON.prepareStatement("select * from valutazione_prod where id_prod = ?")) {
            stm.setInt(1, id);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    val = rs.getInt("rate05")
                            + rs.getInt("rate1")
                            + rs.getInt("rate15")
                            + rs.getInt("rate2")
                            + rs.getInt("rate25")
                            + rs.getInt("rate3")
                            + rs.getInt("rate35")
                            + rs.getInt("rate4")
                            + rs.getInt("rate45")
                            + rs.getInt("rate5");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(JDBCProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return val;
    }

    /**
     * Metodo che restituisce tutti i prodotti di una categoria apparte un
     * determinato prodotto.<br>
     * Questo metodo è utilizzato per i prodotti che ti potrebbero interesare.
     *
     * @param categoryName Indica la categoria da considerare
     * @param id Indica l'id del prodotto da escludere
     * @return Ritorna un ArrayList di prodotti.
     * @throws DAOException
     */
    @Override
    public ArrayList<Prodotto> getOtherProductsOfCategory(String categoryName, int id) throws DAOException {
        checkCON();

        if (categoryName == null) {
            throw new DAOException("categoryName is a mandatory fields", new NullPointerException("categoryName is null"));
        }
        if (categoryName.contains("'") || categoryName.contains("\"")) {
            categoryName = categoryName.replace("\"", "").replace("'", "");
        }
        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM prodotto where categoria = ?")) {
            stm.setString(1, categoryName);
            ArrayList<Prodotto> prodotti = new ArrayList<>();

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    if (rs.getInt("id") != id) {
                        Prodotto p = new Prodotto();
                        p.setId(rs.getInt("id"));
                        p.setNome(rs.getString("nome"));
                        p.setDescrizione(rs.getString("descrizione"));
                        p.setImmagine(rs.getString("immagine"));
                        p.setCategoria(rs.getString("categoria"));
                        p.setCosto(rs.getFloat("costo"));
                        p.setDisponibile(rs.getBoolean("disponibile"));
                        p.setFresco(rs.getBoolean("fresco"));
                        prodotti.add(p);
                    }
                }

                return prodotti;
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire gli altri prodotti della categoria. (JDBCProductDAO, getOtherProductsOfCategory)", ex);
        }
    }

    /**
     * MEtodo che lavora con i prodotti freschi. Controlla se nel carrello sono
     * presenti prodotti freschi e se sono presenti, considerando tutti i
     * prodotti del carrello (anche quelli non freschi), valuta il costo dei box
     * refrigerati (e delle scatole protettive obbligatorie). Si lavora con
     * costanti.
     *
     * @param request
     * @return Ritorna la stringa uguale al costo dei vari box da dover
     * utilizzare in base al costo totale con due cifre decimali.
     * @throws DAOException
     */
    @Override
    public String checkWeight(HttpServletRequest request) throws DAOException {
        checkCON();

        ArrayList<Prodotto> prodottiF = getFreshProductsOfCart(request);

        DecimalFormat df = new DecimalFormat("0.00");
        df.setMaximumFractionDigits(2);
        double totale, tot = 0.00;

        if (!prodottiF.isEmpty()) {

            totale = Double.parseDouble(getTotalOfCart(request));

            if (totale > 0 && totale < MIN_COSTO) {
                tot = MIN_W_PRICE;
            } else if (totale >= MIN_COSTO && totale <= MED_COSTO) {
                tot = MED_W_PRICE;
            } else if (totale > MED_COSTO && totale < MAX_COSTO) {
                tot = MED_W_PRICE;
            } else if (totale >= MAX_COSTO) {
                tot = MAX_W_PRICE;
            }

            String totS = String.format("%.2f", tot);
            totS = totS.replace(",", ".");
            return totS;

        } else {
            return "0.00";
        }
    }

    /**
     * Metodo che ritorna i prodotti freschi presenti nel carrello.
     *
     * @param request
     * @return Ritorna un arrayList di prodootti contenente tutti i prodotti
     * freschi presenti nel carrello.
     * @throws DAOException
     */
    @Override
    public ArrayList<Prodotto> getFreshProductsOfCart(HttpServletRequest request) throws DAOException {
        checkCON();

        ArrayList<Prodotto> prodotti = getAllProductsOfCart(request);
        ArrayList<Prodotto> freschi = new ArrayList<>();

        if (prodotti != null) {
            prodotti.stream().filter((p) -> (p.isFresco())).forEachOrdered((p) -> {
                freschi.add(p);
            });
        }
        return freschi;
    }

    /**
     * Metodo che verifica se tutti i prodotti ricavati dalla concatenazione
     * degli id sono disponibili. se uno o più non sono disponibili gli esclude
     *
     * @param ids
     * @return
     * @throws DAOException
     */
    @Override
    public String checkDisponibile(String ids) throws DAOException {
        checkCON();
        String cart = "";
        if (ids != null) {
            String[] id = ids.split("_");
            Prodotto p;
            for (String s : id) {
                if (!s.equals("")) {
                    p = getProduct(Integer.parseInt(s));
                    if (p != null && p.isDisponibile()) {
                        if (cart.equals("")) {
                            cart += p.getId();
                        } else {
                            cart += "_" + p.getId();
                        }
                    }
                }
            }
        }
        return cart;
    }

    /**
     * MEtodo che ritorna il nome del tipo di box da utilizzare
     *
     * @param request
     * @return
     * @throws DAOException
     */
    @Override
    public String getfreshBoxType(HttpServletRequest request) throws DAOException {
        checkCON();

        String boxS = checkWeight(request);
        double box = Double.parseDouble(boxS);
        String tipo = "";

        if (box == MIN_W_PRICE) {
            tipo = "Box piccolo";
        } else if (box == MED_W_PRICE) {
            tipo = "Box medio";
        } else if (box == MAX_W_PRICE) {
            tipo = "Box grande";
        }
        return tipo;
    }

    /**
     * Metodo che ritorna tutte le varianti disponibili per un prodotto
     *
     * @param idProd
     * @return
     * @throws DAOException
     */
    @Override
    public ArrayList<ArrayList<Variante>> getProductVariant(int idProd) throws DAOException {
        checkCON();

        Variante v;
        ArrayList<Variante> varianti;
        ArrayList<ArrayList<Variante>> prodVar = new ArrayList<>();
        ArrayList<String> names = null;
        boolean check = false;

        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM products_variants where idProd = ?")) {
            stm.setInt(1, idProd);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    v = new Variante();
                    v.setId(rs.getInt("id"));
                    v.setId_prod(rs.getInt("idProd"));
                    v.setVariant(rs.getString("variant"));
                    v.setVariantName(rs.getString("variantName"));
                    v.setSupplement(rs.getDouble("supplement"));

                    if (names == null || names.isEmpty()) {
                        names = new ArrayList<>();
                        varianti = new ArrayList<>();
                        varianti.add(v);
                        prodVar.add(varianti);
                        names.add(v.getVariant());
                    } else {
                        for (String name : names) {
                            if (name.equals(v.getVariant())) {
                                for (ArrayList<Variante> j : prodVar) {
                                    if (j.get(0).getVariant().equals(v.getVariant())) {
                                        j.add(v);
                                        check = true;
                                    }
                                }
                            }
                        }
                        if (!check) {
                            varianti = new ArrayList<>();
                            varianti.add(v);
                            prodVar.add(varianti);
                            names.add(v.getVariant());
                        }
                        check = false;
                    }
                }
                return prodVar;
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire tutte le varianti del prodotto. (JDBCProductDAO, getProductVariant)", ex);
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
                }
                return v;
            }
        } catch (SQLException ex) {
            //throw new DAOException("Impossibile restituire il prodotto. (JDBCProductDAO, getProduct)", ex);
            return null;
        }
    }

    /**
     * MEtodo che ritorna la prima scelta di ogni variante del prodotto. questo
     * metodo serve se viene aggiunto il prodotto al carrello dalla bottega
     * quindi non scegliendo che tipo di variante aggiungere. Si aggiunge quella
     * di default che è la prima.
     *
     * @param idProd
     * @return
     * @throws DAOException
     */
    @Override
    public ArrayList<Variante> getFrstVariantOfProduct(int idProd) throws DAOException {
        checkCON();

        try (PreparedStatement stm = CON.prepareStatement("select * from products_variants where idProd = ? group by variant order by id")) {
            stm.setInt(1, idProd);
            Variante v;
            ArrayList<Variante> varianti = new ArrayList<>();

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    v = new Variante();
                    v.setId(rs.getInt("id"));
                    v.setId_prod(rs.getInt("idProd"));
                    v.setVariant(rs.getString("variant"));
                    v.setVariantName(rs.getString("variantName"));
                    v.setSupplement(rs.getDouble("supplement"));
                    varianti.add(v);
                }
                if (varianti.isEmpty()) {
                    return null;
                } else {
                    return varianti;
                }

            }
        } catch (SQLException ex) {
            //throw new DAOException("Impossibile restituire il prodotto. (JDBCProductDAO, getProduct)", ex);
            return null;
        }
    }

    /**
     * Ritorna tutte le varianti salvate e aggiunte al carrello
     *
     * @param request
     * @return
     * @throws DAOException
     */
    @Override
    public LinkedHashMap<ArrayList<Variante>, Integer> getCartVariant(HttpServletRequest request) throws DAOException {
        checkCON();

        ArrayList<Variante> varianti;
        LinkedHashMap<ArrayList<Variante>, Integer> variants = new LinkedHashMap<>();;
        Variante v;
        Prodotto p;
        Cookie[] cookies = request.getCookies();
        String arrayString = null;
        String[] blocchi = null;
        String[] VarQuan;

        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("varianti")) {
                    arrayString = c.getValue();
                }
            }
        }
        if (arrayString != null) {
            blocchi = arrayString.split(":");
        }

        if (blocchi != null) {
            for (String blocchi1 : blocchi) {
                if (blocchi1 != null && !blocchi1.equals("")) {
                    varianti = new ArrayList<>();
                    VarQuan = blocchi1.split("\\*");
                    String vars = VarQuan[0];
                    int q = 1;
                    if (VarQuan.length == 2) {
                        q = Integer.parseInt(VarQuan[1]);
                    }
                    String[] var = vars.split("_");
                    for (String s : var) {
                        if (!s.equals("")) {
                            v = getVariant(Integer.parseInt(s));
                            if (v != null) {
                                p = getProduct(v.getId_prod());
                                if (p != null) {
                                    if (p.isDisponibile()) {
                                        varianti.add(v);
                                    }
                                }
                            }
                        }

                    }
                    variants.put(varianti, q);
                }
            }
        }

        if (!variants.isEmpty()) {
            return variants;
        } else {
            return null;
        }
    }

    /**
     * Ritorna tutte le varianti aggiunte al carrello di un determinato prodotto
     *
     * @param request
     * @param idProduct
     * @return
     * @throws DAOException
     */
    @Override
    public LinkedHashMap<ArrayList<Variante>, Integer> getCartProductVariant(HttpServletRequest request, int idProduct) throws DAOException {
        checkCON();

        LinkedHashMap<ArrayList<Variante>, Integer> prodVariant = new LinkedHashMap<>();
        LinkedHashMap<ArrayList<Variante>, Integer> cartVariant = getCartVariant(request);
        if (cartVariant != null) {
            cartVariant.entrySet().forEach((entry) -> {
                ArrayList<Variante> key = entry.getKey();
                Integer value = entry.getValue();

                key.stream().filter((v) -> (v.getId_prod() == idProduct)).forEachOrdered((_item) -> {
                    prodVariant.put(key, value);
                });
            });
        }
        return prodVariant;
    }

    /**
     * ritorna una stringa concatenzione degli id delle varianti
     *
     * @param blocco
     * @return
     * @throws DAOException
     */
    @Override
    public String getVariantBlock(ArrayList<Variante> blocco) throws DAOException {
        String ids = "";
        ids = blocco.stream().map((v) -> v.getId() + "_").reduce(ids, String::concat);
        if (!ids.equals("")) {
            ids = ids.substring(0, ids.length() - 1);
        }
        return ids;
    }

    @Override
    public ArrayList<Prodotto> getSuggestedProducts() throws DAOException {
        checkCON();

        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM prodotto where disponibile is true ORDER BY RAND() LIMIT 4")) {
            ArrayList<Prodotto> prodotti = new ArrayList<>();

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    p.setDescrizione(rs.getString("descrizione"));
                    p.setImmagine(rs.getString("immagine"));
                    p.setCategoria(rs.getString("categoria"));
                    p.setCosto(rs.getFloat("costo"));
                    p.setDisponibile(rs.getBoolean("disponibile"));
                    p.setFresco(rs.getBoolean("fresco"));
                    prodotti.add(p);
                }

                return prodotti;
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire i prodotti Consigliati. (JDBCProductDAO, getSuggestedProducts)", ex);
        }
    }

    @Override
    public Prodotto getProductByName(String nome) throws DAOException {
        checkCON();

        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM prodotto where nome = ?")) {
            stm.setString(1, nome);
            Prodotto p = null;

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    p = new Prodotto();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    p.setDescrizione(rs.getString("descrizione"));
                    p.setImmagine(rs.getString("immagine"));
                    p.setCategoria(rs.getString("categoria"));
                    p.setCosto(rs.getFloat("costo"));
                    p.setDisponibile(rs.getBoolean("disponibile"));
                    p.setFresco(rs.getBoolean("fresco"));
                }
                return p;
            }
        } catch (SQLException ex) {
            //throw new DAOException("Impossibile restituire il prodotto. (JDBCProductDAO, getProduct)", ex);
            return null;
        }
    }
}
