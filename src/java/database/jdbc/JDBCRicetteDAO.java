/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.jdbc;

import database.daos.RicetteDAO;
import database.entities.Commento;
import database.entities.Ricetta;
import database.exceptions.DAOException;
import database.exceptions.DAOFactoryException;
import database.factories.JDBCDAOFactory;
import static database.factories.JDBCDAOFactory.DBURL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import static varie.Costanti.NUM_MOST_VIEWED_POSTS;

/**
 *JDBCDAO Per i metodi relativi alle ricette
 * 
 * @author Roberto97
 */
public class JDBCRicetteDAO extends JDBCDAO implements RicetteDAO {

    /**
     * Questa è il costruttore e serve fondamentalmente per collegarsi alla connessione aperta con il DB
     * 
     * @param con E' la connessione al DB
     * @throws java.sql.SQLException
     */
    public JDBCRicetteDAO(Connection con) throws SQLException {
        super(con);
        try {
            checkCON();
        } catch (DAOException ex) {
            Logger.getLogger(JDBCConsoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    /**
     * Controlla che la connessione con il DB sia aperta, altrimenti la riapre
     * @throws DAOException
     */
    @Override
    public final void checkCON() throws DAOException {
        try {
            if(this.CON == null || this.CON.isClosed() || !this.CON.isValid(0)){
                this.daoFactory = new JDBCDAOFactory(DBURL);
                this.CON = daoFactory.getConnection();         
            }
        } catch (SQLException | DAOFactoryException ex) {
            System.out.println("console jdbc checkCON catch");
            Logger.getLogger(JDBCConsoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    /**
     * Metodo che restituisce tutte le ricette esistenti ordinandole dalla più recente.
     * @return Ritorna un arraylist di tutte le ricette salvate nel DB.
     * @throws DAOException
     */
    @Override
    public ArrayList<Ricetta> getAllRecipes() throws DAOException {
        checkCON();
        
        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM ricette where approvata = true")) {
            ArrayList<Ricetta> ricette = new ArrayList<>();
            String[] ingredienti;
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Ricetta r = new Ricetta();
                    r.setId(rs.getInt("id"));
                    r.setId_prod(rs.getInt("id_prod"));
                    r.setNome(rs.getString("nome"));
                    ingredienti = rs.getString("ingredienti").split("_");
                    r.setIngredienti(new ArrayList<>(Arrays.asList(ingredienti)));
                    r.setImmagine(rs.getString("immagine"));
                    r.setProcedimento(rs.getString("procedimento"));
                    r.setTempo(rs.getInt("tempo"));
                    r.setDifficolta(rs.getString("difficolta"));
                    String s = Character.toUpperCase(r.getDifficolta().charAt(0)) + r.getDifficolta().substring(1);
                    r.setDifficolta(s);
                    r.setCreatore(rs.getString("creatore"));
                    r.setData(rs.getTimestamp("data"));
                    r.setDescrizione(rs.getString("descrizione"));
                    r.setMeta_descrizione(rs.getString("meta_descrizione"));
                    r.setViews(rs.getInt("views"));
                    r.setCategory(rs.getBoolean("categoria"));
                    r.setApprovata(rs.getBoolean("approvata"));
                    ricette.add(r);
                }

                try {
                    Collections.sort(ricette, (Ricetta r1, Ricetta r2) -> {
                        if (r1.getData().after(r2.getData())) {
                            return -1;
                        }
                        if (r1.getData().before(r2.getData())) {
                            return 1;
                        }
                        return 0;
                    });
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }

                return ricette;
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire tutte le ricettee. (JDBCRicetteDAO, getAllRecipes)", ex);
        }
    }

    /**
     * Metodo per trovare una particolare ricetta.
     * @param id E' l'id della ricetta che si vuole ottenere.
     * @return Ritorna un'oggetto di tipo ricetta.
     * @throws DAOException
     */
    @Override
    public Ricetta getRecipe(int id) throws DAOException {
        checkCON();
        
        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM ricette where id = ? AND approvata = true")) {
            stm.setInt(1, id);
            Ricetta r = null;
            String[] ingredienti;

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    r = new Ricetta();
                    r.setId(rs.getInt("id"));
                    r.setId_prod(rs.getInt("id_prod"));
                    r.setNome(rs.getString("nome"));
                    ingredienti = rs.getString("ingredienti").split("_");
                    r.setIngredienti(new ArrayList<>(Arrays.asList(ingredienti)));
                    r.setImmagine(rs.getString("immagine"));
                    r.setProcedimento(rs.getString("procedimento"));
                    r.setTempo(rs.getInt("tempo"));
                    r.setDifficolta(rs.getString("difficolta"));
                    String s = Character.toUpperCase(r.getDifficolta().charAt(0)) + r.getDifficolta().substring(1);
                    r.setDifficolta(s);
                    r.setCreatore(rs.getString("creatore"));
                    r.setData(rs.getTimestamp("data"));
                    r.setDescrizione(rs.getString("descrizione"));
                    r.setMeta_descrizione(rs.getString("meta_descrizione"));
                    r.setViews(rs.getInt("views"));
                    r.setCategory(rs.getBoolean("categoria"));
                    r.setApprovata(rs.getBoolean("approvata"));
                }
                return r;
            }
        } catch (SQLException ex) {
            //throw new DAOException("Impossibile restituire il prodotto. (JDBCProductDAO, getProduct)", ex);
            return null;
        }
    }
    
    /**
     * Metodo per trovare una particolare ricetta dal nome.
     * @param nome
     * @return Ritorna un'oggetto di tipo ricetta.
     * @throws DAOException
     */
    @Override
    public Ricetta getRecipeByName(String nome) throws DAOException {
        checkCON();
        
        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM ricette where nome = ? AND approvata = true")) {
            stm.setString(1, nome);
            Ricetta r = null;
            String[] ingredienti;

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    r = new Ricetta();
                    r.setId(rs.getInt("id"));
                    r.setId_prod(rs.getInt("id_prod"));
                    r.setNome(rs.getString("nome"));
                    ingredienti = rs.getString("ingredienti").split("_");
                    r.setIngredienti(new ArrayList<>(Arrays.asList(ingredienti)));
                    r.setImmagine(rs.getString("immagine"));
                    r.setProcedimento(rs.getString("procedimento"));
                    r.setTempo(rs.getInt("tempo"));
                    r.setDifficolta(rs.getString("difficolta"));
                    String s = Character.toUpperCase(r.getDifficolta().charAt(0)) + r.getDifficolta().substring(1);
                    r.setDifficolta(s);
                    r.setCreatore(rs.getString("creatore"));
                    r.setData(rs.getTimestamp("data"));
                    r.setDescrizione(rs.getString("descrizione"));
                    r.setMeta_descrizione(rs.getString("meta_descrizione"));
                    r.setViews(rs.getInt("views"));
                    r.setCategory(rs.getBoolean("categoria"));
                    r.setApprovata(rs.getBoolean("approvata"));
                }
                return r;
            }
        } catch (SQLException ex) {
            //throw new DAOException("Impossibile restituire il prodotto. (JDBCProductDAO, getProduct)", ex);
            return null;
        }
    }

    /**
     * Metodo che restituisce tutte le ricette che sono legate ad un determinato prodotto.<br>
     * Guarda tutte le ricette che hanno l'attributo id_prod richiesto. Infatti un prodotto
     * dell'ecommerce può essere associato a una o più ricette.
     * @param id_prod Indica l'id del prodotto.
     * @return Ritorna un arrayList di ricette
     * @throws DAOException
     */
    @Override
    public ArrayList<Ricetta> getRecipeOfProduct(int id_prod) throws DAOException {
        checkCON();
        
        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM ricette where id_prod = ? AND approvata = true")) {
            stm.setInt(1, id_prod);
            Ricetta r;
            ArrayList<Ricetta> ricette = new ArrayList<>();
            String[] ingredienti;

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    r = new Ricetta();
                    r.setId(rs.getInt("id"));
                    r.setId_prod(rs.getInt("id_prod"));
                    r.setNome(rs.getString("nome"));
                    ingredienti = rs.getString("ingredienti").split("_");
                    r.setIngredienti(new ArrayList<>(Arrays.asList(ingredienti)));
                    r.setImmagine(rs.getString("immagine"));
                    r.setProcedimento(rs.getString("procedimento"));
                    r.setTempo(rs.getInt("tempo"));
                    r.setDifficolta(rs.getString("difficolta"));
                    String s = Character.toUpperCase(r.getDifficolta().charAt(0)) + r.getDifficolta().substring(1);
                    r.setDifficolta(s);
                    r.setCreatore(rs.getString("creatore"));
                    r.setData(rs.getTimestamp("data"));
                    r.setDescrizione(rs.getString("descrizione"));
                    r.setMeta_descrizione(rs.getString("meta_descrizione"));
                    r.setViews(rs.getInt("views"));
                    r.setCategory(rs.getBoolean("categoria"));
                    r.setApprovata(rs.getBoolean("approvata"));
                    ricette.add(r);
                }
                return ricette;
            }
        } catch (SQLException ex) {
            //throw new DAOException("Impossibile restituire il prodotto. (JDBCProductDAO, getProduct)", ex);
            return null;
        }
    }

    /**
     * Metodo per raccogliere tutti i commenti di tutte le ricette.
     * @return Ritorna un arrayList di commenti.
     * @throws DAOException
     */
    @Override
    public ArrayList<Commento> getAllComments() throws DAOException {
        checkCON();
        
        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM commenti")) {
            ArrayList<Commento> commenti = new ArrayList<>();
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Commento c = new Commento();
                    c.setId(rs.getInt("id"));
                    c.setId_ricetta(rs.getInt("id_ricetta"));
                    c.setNome(rs.getString("nome"));
                    c.setTesto(rs.getString("testo"));
                    c.setData(rs.getTimestamp("data"));
                    commenti.add(c);
                }

                return commenti;
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire tutti i commenti. (JDBCRicetteDAO, getAllComments)", ex);
        }
    }

    /**
     * Metodo per ricavare tutti i commenti di una particolare ricetta
     * @param id_ricetta Indica l'id della ricetta
     * @return Ritorna un arrayList di commenti
     * @throws DAOException
     */
    @Override
    public ArrayList<Commento> getComments(int id_ricetta) throws DAOException {
        checkCON();
        
        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM commenti where id_ricetta = ?")) {
            stm.setInt(1, id_ricetta);
            ArrayList<Commento> commenti = new ArrayList<>();

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Commento c = new Commento();
                    c.setId(rs.getInt("id"));
                    c.setId_ricetta(rs.getInt("id_ricetta"));
                    c.setNome(rs.getString("nome"));
                    c.setTesto(rs.getString("testo"));
                    c.setData(rs.getTimestamp("data"));
                    commenti.add(c);
                }
                Collections.sort(commenti, (Commento z1, Commento z2) -> {
                    if (z1.getData().after(z2.getData())) {
                        return -1;
                    }
                    if (z1.getData().before(z2.getData())) {
                        return 1;
                    }
                    return 0;
                });
                return commenti;
            }
        } catch (SQLException ex) {
            //throw new DAOException("Impossibile restituire il prodotto. (JDBCProductDAO, getProduct)", ex);
            return null;
        }
    }

    /**
     * Metodo per pubblicare un nuovo commento.
     * @param id_ricetta Indica l'id della ricetta per cui si vuole pubblicare il commento
     * @param nome Inidica il nome dell'utente che pubblica il commento
     * @param commento Indica il testo del commento.
     * @throws DAOException
     */
    @Override
    public void postComment(int id_ricetta, String nome, String commento) throws DAOException {
        checkCON();
        
        if (id_ricetta == 0 || nome == null || "".equals(nome) || commento == null || "".equals(commento) || commento.isEmpty() || nome.isEmpty()) {
            throw new DAOException("id_ricetta or name or comment invalid", new NullPointerException("id_ricetta or name or comment invalid"));
        }
        /*System.out.println("id: " + id_ricetta + "\nnome: " + nome + "\ncommento: " + commento);*/
        try (PreparedStatement statement = CON.prepareStatement("insert into commenti (id_ricetta, nome, testo) values (?, ?, ?)")) {
            statement.setInt(1, id_ricetta);
            statement.setString(2, nome);
            statement.setString(3, commento);
            if (statement.executeUpdate() == 1) {
            } else {
                throw new DAOException("Impossible to insert the comment of ricetta");
            }
        } catch (SQLException ex) {
            System.out.println("Impossible to insert the comment of ricetta");
        }
    }

    /**
     * Metodo che restituisce le 4 ricette più viste.<br>
     * Se esistono meno di 4 ricette le restituisce tutte ordinandole in base alla più letta altrimenti
     * restituisce le 4 più lette.
     * @return Ritorna un arraylist di ricette
     * @throws DAOException
     */
    @Override
    public ArrayList<Ricetta> getMostViewedRecipes() throws DAOException {
        checkCON();
        
        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM ricette where approvata = true")) {
            ArrayList<Ricetta> ricette = new ArrayList<>();
            ArrayList<Ricetta> viewed = new ArrayList<>();
            String[] ingredienti;
            Ricetta c;
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    c = new Ricetta();
                    c.setId(rs.getInt("id"));
                    c.setId_prod(rs.getInt("id_prod"));
                    c.setNome(rs.getString("nome"));
                    c.setProcedimento(rs.getString("procedimento"));
                    ingredienti = rs.getString("ingredienti").split("_");
                    c.setIngredienti(new ArrayList<>(Arrays.asList(ingredienti)));
                    c.setImmagine(rs.getString("immagine"));
                    c.setTempo(rs.getInt("tempo"));
                    c.setDifficolta(rs.getString("difficolta"));
                    String s = Character.toUpperCase(c.getDifficolta().charAt(0)) + c.getDifficolta().substring(1);
                    c.setDifficolta(s);
                    c.setCreatore(rs.getString("creatore"));
                    c.setData(rs.getTimestamp("data"));
                    c.setDescrizione(rs.getString("descrizione"));
                    c.setMeta_descrizione(rs.getString("meta_descrizione"));
                    c.setViews(rs.getInt("views"));
                    c.setCategory(rs.getBoolean("categoria"));
                    c.setApprovata(rs.getBoolean("approvata"));
                    ricette.add(c);
                }

                Collections.sort(ricette, (Ricetta z1, Ricetta z2) -> {
                    if (z1.getViews() > z2.getViews()) {
                        return -1;
                    }
                    if (z1.getViews() < z2.getViews()) {
                        return 1;
                    }
                    return 0;
                });

                if (ricette.size() > 4) {
                    for (int i = 0; i < NUM_MOST_VIEWED_POSTS; i++) {
                        viewed.add(ricette.get(i));
                    }

                    return viewed;
                } else {
                    return ricette;
                }
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire le Idee più lette. (JDBCBlogDAO, getMostViewedRecipes)", ex);
        }
    }

    /**
     * Metodo utilizzato per aumentare il numero di letture di una ricette.<br>
     * Questo metodo viene usato ogni volta che si apre una determinata ricetta.
     * Si guarda se esiste un attributo di sessione che indica che in questa
     * sessione questa ricetta è gia stata letta, se esiste non succede nulla,
     * se non esiste allora viene incrementato di 1 il numero di visualizzazioni della ricetta
     * e poi viene creato un attributo di sessione contenente l'id della sessione
     * e l'id della ricetta.
     * @param id Indica l'id della ricetta
     * @param viewsOld Indica il numero di visualizzazioni che si vuole incrementare (Quello attuale)
     * @param request
     * @throws DAOException
     */
    @Override
    public void incrementViews(int id, int viewsOld, HttpServletRequest request) throws DAOException {
        checkCON();
        
        /*Metodo che controlla se nella sessione esiste un attributo con nome uguale all'id del post
        più l'id della sessione. Se esiste e il contenuto è uguale all'id del post più l'id della sessione non fa niente,
        in tutti gli altri casi incrementa il numero di views del post e poi crea l'attributo. In questo modo se
        la pagina viene ricaricata il numero di views rimane giustamente lo stesso.'*/
        HttpSession session = request.getSession(false);
        String name = "" + id + session.getId();
        if (session.getAttribute(name) != null) {
            if (session.getAttribute(name).equals(name)) {
            }
        } else {
            try (PreparedStatement stm = CON.prepareStatement("update ricette set views = ? where id = ?")) {

                try {
                    stm.setInt(1, viewsOld + 1);
                    stm.setInt(2, id);

                    if (stm.executeUpdate() == 1) {
                    } else {
                        System.out.println("Impossible to update views");
                    }

                } catch (SQLException ex) {
                    throw new DAOException(ex);
                }
                session.setAttribute(name, name);

            } catch (SQLException ex) {
                throw new DAOException("Impossible to update views", ex);
            }
        }
    }

    /**
     * Metodo che ordina un array di ricette.<br>
     * Questo metodo considera un dato arrayList di ricette e lo ordina in pase alla richiesta.
     * @param type Indica in che modo si vuole ordinare l'arrayList
     * @param ricette E' l'arraylist di ricette che si vuole ordinare
     * @return Ritorna l'arrayList di ricette ordinato
     * @throws DAOException
     */
    @Override
    public ArrayList<Ricetta> getOrderedBy(String type, ArrayList<Ricetta> ricette) throws DAOException {
        checkCON();
        

        switch (type) {
            case "PiuVisti":
                Collections.sort(ricette, (Ricetta z1, Ricetta z2) -> {
                    if (z1.getViews() > z2.getViews()) {
                        return -1;
                    }
                    if (z1.getViews() < z2.getViews()) {
                        return 1;
                    }
                    return 0;
                });
                break;
            case "MenoVisti":
                Collections.sort(ricette, (Ricetta z1, Ricetta z2) -> {
                    if (z1.getViews() < z2.getViews()) {
                        return -1;
                    }
                    if (z1.getViews() > z2.getViews()) {
                        return 1;
                    }
                    return 0;
                });
                break;
            case "PiuRecenti":
                Collections.sort(ricette, (Ricetta z1, Ricetta z2) -> {
                    if (z1.getData().after(z2.getData())) {
                        return -1;
                    }
                    if (z1.getData().before(z2.getData())) {
                        return 1;
                    }
                    return 0;
                });
                break;
            case "MenoRecenti":
                Collections.sort(ricette, (Ricetta z1, Ricetta z2) -> {
                    if (z1.getData().after(z2.getData())) {
                        return 1;
                    }
                    if (z1.getData().before(z2.getData())) {
                        return -1;
                    }
                    return 0;
                });
                break;
            default:
                break;
        }
        return ricette;
    }

    /**
     * Metodo che restituisce tutte le ricette di un determinato tipo
     * @param type Indica il tipo di ricette che si cercano
     * @return Restituisce un arraylist di tutte le ricette di un determinato tipo
     * @throws DAOException
     */
    @Override
    public ArrayList<Ricetta> getByType(String type) throws DAOException {
        checkCON();
        
        ArrayList<Ricetta> recipes = getAllRecipes();
        ArrayList<Ricetta> ricette = new ArrayList<>();

        switch (type) {
            case "1":
                recipes.stream().filter((r) -> (r.isCategory())).forEachOrdered((r) -> {
                    ricette.add(r);
                });
                break;
            case "2":
                recipes.stream().filter((r) -> (!r.isCategory())).forEachOrdered((r) -> {
                    ricette.add(r);
                });
                break;
            case "0":
                recipes.forEach((r) -> {
                    ricette.add(r);
                });
                break;
            default:
                break;
        }
        return ricette;
    }

    /**
     * Metodo che restituisce il numero di ricette di un determinato tipo.
     * @param type Indica il tipo di ricette
     * @return Restituisce un intero uguale al numero di ricette di un determinato tipo 
     * @throws DAOException
     */
    @Override
    public int getTypeSize(String type) throws DAOException {
        checkCON();
        
        ArrayList<Ricetta> recipes = getByType(type);
        return recipes.size();
    }

    /**
     * Metodo che restituisce il numero di valutazioni per una determinata ricetta.
     * @param id Indica l'id della ricetta per cui si vuole conoscere il numero di valutazioni esistenti
     * @return Ritorna il valore intero del numero di valutazioni.
     * @throws DAOException
     */
    @Override
    public int getNumberRate(int id) throws DAOException {
        checkCON();
        
        int val = 0;
        try (PreparedStatement stm = CON.prepareStatement("select * from valutazione_ricetta where id_ricetta = ?")) {
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
     * Metodo che ritorna la valutazione media di una ricetta.
     * @param id E' l'id della ricetta che si vuole conoscere la valutazione
     * @return Ritorna il valore della valutazione per esempio 4.5
     * @throws DAOException
     */
    @Override
    public double getRate(int id) throws DAOException {
        checkCON();
        
        double val = 0;
        try (PreparedStatement stm = CON.prepareStatement("select * from valutazione_ricetta where id_ricetta = ?")) {
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
     * Metodo per inviare la valutazione di una ricetta.<br>
     * Setta i valori delle varie stelle sostituendo quelli vecchi.
     * @param id E' l'id della ricetta che si vuole valutare
     * @param value E' il valore della valutazione che sivuole lasciare.
     * @throws DAOException
     */
    @Override
    public void setRate(int id, double value) throws DAOException {
        checkCON();
        

        int number5 = 0, number45 = 0, number4 = 0, number35 = 0, number3 = 0, number25 = 0, number2 = 0, number15 = 0, number1 = 0, number05 = 0;

        try (PreparedStatement stm = CON.prepareStatement("select * from valutazione_ricetta where id_ricetta = ?")) {
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

        try (PreparedStatement statement = CON.prepareStatement("REPLACE INTO valutazione_ricetta (id_ricetta, rate5,rate4,rate3,rate2,rate1,rate05,rate15,rate25,rate35,rate45, value) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)")) {

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
                throw new DAOException("Impossible to update the valutazione_ricetta");
            }

        } catch (SQLException ex) {
            throw new DAOException(ex);

        }
    }

    /**
     * Metodo per aggiungere una ricetta al db. viene usato quando un utente
     * invia la propria idea allora viene direttamente aggiunta al db senza pubblicarla
     * @param nome
     * @param procedimento
     * @param descrizione
     * @param difficolta
     * @param ingredienti
     * @param creatore
     * @param tempo
     * @param id_prod
     * @param categoria
     * @throws DAOException
     */
    @Override
    public void addRecipe(String nome, String procedimento, String descrizione, String difficolta, String ingredienti, String creatore, int tempo, int id_prod, boolean categoria) throws DAOException {
        checkCON();
        

        try (PreparedStatement stm = CON.prepareStatement("insert into ricette (nome, procedimento, descrizione, difficolta, ingredienti, creatore, tempo, id_prod, categoria, immagine, approvata, meta_descrizione) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)")) {
            try {
                stm.setString(1, nome);
                stm.setString(2, procedimento);
                stm.setString(3, descrizione);
                stm.setString(4, difficolta);
                stm.setString(5, ingredienti);
                stm.setString(6, creatore);
                stm.setInt(7, tempo);
                stm.setInt(8, id_prod);
                stm.setBoolean(9, categoria);
                stm.setString(10, "");
                stm.setBoolean(11, false);
                stm.setString(12, "");

                if (stm.executeUpdate() == 1) {
                } else {
                    throw new DAOException("Impossible to add new recipe");
                }

            } catch (SQLException ex) {
                throw new DAOException(ex);
            }
        } catch (SQLException ex) {
            Logger.getLogger(JDBCConsoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public Ricetta getLastRecipe() throws DAOException {
        checkCON();
        
        try (PreparedStatement stm = CON.prepareStatement("select * from ricette where data = (SELECT max(data) from (select data from ricette where approvata = true) as approvate)")) {
            Ricetta r = null;
            String[] ingredienti;

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    r = new Ricetta();
                    r.setId(rs.getInt("id"));
                    r.setId_prod(rs.getInt("id_prod"));
                    r.setNome(rs.getString("nome"));
                    ingredienti = rs.getString("ingredienti").split("_");
                    r.setIngredienti(new ArrayList<>(Arrays.asList(ingredienti)));
                    r.setImmagine(rs.getString("immagine"));
                    r.setProcedimento(rs.getString("procedimento"));
                    r.setTempo(rs.getInt("tempo"));
                    r.setDifficolta(rs.getString("difficolta"));
                    String s = Character.toUpperCase(r.getDifficolta().charAt(0)) + r.getDifficolta().substring(1);
                    r.setDifficolta(s);
                    r.setCreatore(rs.getString("creatore"));
                    r.setData(rs.getTimestamp("data"));
                    r.setDescrizione(rs.getString("descrizione"));
                    r.setMeta_descrizione(rs.getString("meta_descrizione"));
                    r.setViews(rs.getInt("views"));
                    r.setCategory(rs.getBoolean("categoria"));
                    r.setApprovata(rs.getBoolean("approvata"));
                }
                return r;
            }
        } catch (SQLException ex) {
            //throw new DAOException("Impossibile restituire il prodotto. (JDBCProductDAO, getProduct)", ex);
            return null;
        }
    }
}
