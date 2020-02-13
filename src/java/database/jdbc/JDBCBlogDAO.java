package database.jdbc;

import database.daos.BlogDAO;
import database.entities.Blog;
import database.exceptions.DAOException;
import database.exceptions.DAOFactoryException;
import database.factories.JDBCDAOFactory;
import static database.factories.JDBCDAOFactory.DBURL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import static varie.Costanti.NUM_MOST_VIEWED_POSTS;

/**
 * JDBCDAO per i metodi legati al Blog
 *
 * @author Roberto97
 */
public class JDBCBlogDAO extends JDBCDAO implements BlogDAO {

    /**
     * Questa è il costruttore e serve fondamentalmente per collegarsi alla
     * connessione aperta con il DB
     *
     * @param con E' la connessione al DB
     * @throws java.sql.SQLException
     */
    public JDBCBlogDAO(Connection con) throws SQLException {
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
     * Metodo per trovare tutti gli articoli del blog.
     *
     * @return Ritorna un arraylist contenente tutti gli articoli.
     * @throws DAOException
     */
    @Override
    public ArrayList<Blog> getAllBlogs() throws DAOException {
        checkCON();

        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM blog where pubblicato = true")) {
            ArrayList<Blog> blogs = new ArrayList<>();

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Blog c = new Blog();
                    c.setId(rs.getInt("id"));
                    c.setCategoria(rs.getString("categoria"));
                    c.setNome(rs.getString("nome"));
                    c.setTesto(rs.getString("testo"));
                    c.setDescrizione(rs.getString("descrizione"));
                    c.setImmagine(rs.getString("immagine"));
                    c.setCreatore(rs.getString("creatore"));
                    c.setData(rs.getTimestamp("data"));
                    c.setViews(rs.getInt("views"));
                    c.setPubblicato(rs.getBoolean("pubblicato"));
                    blogs.add(c);
                }
                //Serve per ordinarlo per vedere prima i più recenti
                Collections.sort(blogs, (Blog z1, Blog z2) -> {
                    if (z1.getData().after(z2.getData())) {
                        return -1;
                    }
                    if (z1.getData().before(z2.getData())) {
                        return 1;
                    }
                    return 0;
                });

                return blogs;
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire tutti i blogs. (JDBCBlogDAO, getAllBlogs)", ex);
        }
    }

    /**
     * Metodo per ritrovare un articolo in base all'id.
     *
     * @param id Indica l'id dell'articolo da ritrovare
     * @return Ritorna un oggetto di tipo Blog (Un articolo)
     * @throws DAOException
     */
    @Override
    public Blog getBlogById(int id) throws DAOException {
        checkCON();

        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM blog where id = ? and pubblicato = true")) {
            stm.setInt(1, id);
            Blog c = new Blog();
            boolean check = false;

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    c.setId(rs.getInt("id"));
                    c.setCategoria(rs.getString("categoria"));
                    c.setNome(rs.getString("nome"));
                    c.setTesto(rs.getString("testo"));
                    c.setDescrizione(rs.getString("descrizione"));
                    c.setImmagine(rs.getString("immagine"));
                    c.setCreatore(rs.getString("creatore"));
                    c.setData(rs.getTimestamp("data"));
                    c.setViews(rs.getInt("views"));
                    c.setPubblicato(rs.getBoolean("pubblicato"));
                    check = true;
                }

                if (check) {
                    return c;
                } else {
                    return null;
                }
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire il blog dall'id. (JDBCCatBlogDAO, getBlogById)", ex);
        }
    }
    
    /**
     * Metodo per ritrovare un articolo in base al nome.
     *
     * @param nome
     * @return Ritorna un oggetto di tipo Blog (Un articolo)
     * @throws DAOException
     */
    @Override
    public Blog getBlogByName(String nome) throws DAOException {
        checkCON();

        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM blog where nome = ? and pubblicato = true")) {
            stm.setString(1, nome);
            Blog c = new Blog();
            boolean check = false;

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    c.setId(rs.getInt("id"));
                    c.setCategoria(rs.getString("categoria"));
                    c.setNome(rs.getString("nome"));
                    c.setTesto(rs.getString("testo"));
                    c.setDescrizione(rs.getString("descrizione"));
                    c.setImmagine(rs.getString("immagine"));
                    c.setCreatore(rs.getString("creatore"));
                    c.setData(rs.getTimestamp("data"));
                    c.setViews(rs.getInt("views"));
                    c.setPubblicato(rs.getBoolean("pubblicato"));
                    check = true;
                }

                if (check) {
                    return c;
                } else {
                    return null;
                }
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire il blog dal nome. (JDBCCatBlogDAO, getBlogById)", ex);
        }
    }

    /**
     * Metodo che ritorna il blog precedente o il successivo
     * @param type
     * @param id
     * @return
     * @throws DAOException
     */
    @Override
    public Blog getPrevOrNextById(boolean type, int id) throws DAOException {
        checkCON();

        String query;
        if (type) {
            //next
            query = "select * from blog where id = (select min(id) from blog where id > ?) and pubblicato = true";
        } else {
            //prev
            query = "select * from blog where id = (select max(id) from blog where id < ?) and pubblicato = true";
        }
        try (PreparedStatement stm = CON.prepareStatement(query)) {
            stm.setInt(1, id);
            Blog c = new Blog();
            boolean check = false;

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    c.setId(rs.getInt("id"));
                    c.setCategoria(rs.getString("categoria"));
                    c.setNome(rs.getString("nome"));
                    c.setTesto(rs.getString("testo"));
                    c.setDescrizione(rs.getString("descrizione"));
                    c.setImmagine(rs.getString("immagine"));
                    c.setCreatore(rs.getString("creatore"));
                    c.setData(rs.getTimestamp("data"));
                    c.setViews(rs.getInt("views"));
                    c.setPubblicato(rs.getBoolean("pubblicato"));
                    check = true;
                }

                if (check) {
                    return c;
                } else {
                    return null;
                }
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire il blog dall'id. (JDBCCatBlogDAO, getBlogById)", ex);
        }
    }

    /**
     * Metodo per ricavare i 4 articoli più letti.<br>
     * Se ci sono meno di 4 articoli li restituisce tutti in ordine dal più
     * letto, altrimenti restituisce i 4 più letti.
     *
     * @return Ritorna un arrayList di Blog
     * @throws DAOException
     */
    @Override
    public ArrayList<Blog> getMostViewedBlog() throws DAOException {
        checkCON();

        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM blog where pubblicato = true")) {
            ArrayList<Blog> blogs = new ArrayList<>();
            ArrayList<Blog> viewed = new ArrayList<>();

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Blog c = new Blog();
                    c.setId(rs.getInt("id"));
                    c.setCategoria(rs.getString("categoria"));
                    c.setNome(rs.getString("nome"));
                    c.setTesto(rs.getString("testo"));
                    c.setDescrizione(rs.getString("descrizione"));
                    c.setImmagine(rs.getString("immagine"));
                    c.setCreatore(rs.getString("creatore"));
                    c.setData(rs.getTimestamp("data"));
                    c.setViews(rs.getInt("views"));
                    c.setPubblicato(rs.getBoolean("pubblicato"));
                    blogs.add(c);
                }

                Collections.sort(blogs, (Blog z1, Blog z2) -> {
                    if (z1.getViews() > z2.getViews()) {
                        return -1;
                    }
                    if (z1.getViews() < z2.getViews()) {
                        return 1;
                    }
                    return 0;
                });

                if (blogs.size() > 4) {
                    for (int i = 0; i < NUM_MOST_VIEWED_POSTS; i++) {
                        viewed.add(blogs.get(i));
                    }

                    return viewed;
                } else {
                    return blogs;
                }
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire i blogs più visti. (JDBCBlogDAO, getMostViewedBlog)", ex);
        }
    }

    /**
     * Metodo per incrementare il numero di visualizzazioni di un articolo.<br>
     * Questo metodo viene usato ogni volta che si apre un determinato articolo.
     * Si guarda se esiste un attributo di sessione che indica che in questa
     * sssione questo articolo è gia stato letto, se esiste non succede nulla,
     * se non esiste allora viene incrementato di 1 il numero di visualizzazioni
     * dell'articolo e poi viene creato un attributo di sessione contenente l'id
     * della sessione e l'id dell'articolo.
     *
     * @param id Indica l'id dell'articolo
     * @param viewsOld Indica il numero di visualizzazioni dell'articolo, il
     * quale verrà incrementato
     * @param request Parametro HttpRequest
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
            try (PreparedStatement stm = CON.prepareStatement("update blog set views = ? where id = ?")) {

                try {
                    stm.setInt(1, viewsOld + 1);
                    stm.setInt(2, id);

                    if (stm.executeUpdate() >= 1) {
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
     * Metodo che ordina un array di articoli.<br>
     * Questo metodo considera un dato arrayList di blog e lo ordina in pase
     * alla richiesta.
     *
     * @param type Indica in che modo si vuole ordinare l'arrayList
     * @param blogs E' l'arraylist di blog che si vuole ordinare
     * @return Ritorna l'arrayList di articoli ordinato
     * @throws DAOException
     */
    @Override
    public ArrayList<Blog> getOrderedBy(String type, ArrayList<Blog> blogs) throws DAOException {
        checkCON();

        System.out.println(blogs.toString());
        switch (type) {
            case "PiuVisti":
                Collections.sort(blogs, (Blog z1, Blog z2) -> {
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
                Collections.sort(blogs, (Blog z1, Blog z2) -> {
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
                Collections.sort(blogs, (Blog z1, Blog z2) -> {
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
                Collections.sort(blogs, (Blog z1, Blog z2) -> {
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
        return blogs;
    }

    /**
     * Metodo che ritorna tutti gli articoli di una particolare categoria.
     *
     * @param cat Indica la categoria di blog che si sta cercando
     * @return Ritorna un arrayList di rticoli di una particolare categoria.
     * @throws DAOException
     */
    @Override
    public ArrayList<Blog> getBlogByCat(String cat) throws DAOException {
        checkCON();

        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM blog where categoria = ? and pubblicato = true")) {
            stm.setString(1, cat);
            ArrayList<Blog> cc = new ArrayList<>();
            Blog c;
            boolean check = false;

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    c = new Blog();
                    c.setId(rs.getInt("id"));
                    c.setCategoria(rs.getString("categoria"));
                    c.setNome(rs.getString("nome"));
                    c.setTesto(rs.getString("testo"));
                    c.setDescrizione(rs.getString("descrizione"));
                    c.setImmagine(rs.getString("immagine"));
                    c.setCreatore(rs.getString("creatore"));
                    c.setData(rs.getTimestamp("data"));
                    c.setViews(rs.getInt("views"));
                    c.setPubblicato(rs.getBoolean("pubblicato"));
                    cc.add(c);
                    check = true;
                }

                if (check) {
                    return cc;
                } else {
                    return null;
                }
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire il blog dalla categoria. (JDBCCatBlogDAO, getBlogByCat)", ex);
        }
    }

    /**
     * Metodo che restituisce il numero di valutazioni per una determinata
     * articolo.
     *
     * @param id Indica l'id della ricetta per cui si vuole conoscere il numero
     * di valutazioni esistenti
     * @return Ritorna il valore intero del numero di valutazioni.
     * @throws DAOException
     */
    @Override
    public int getNumberRate(int id) throws DAOException {
        checkCON();

        int val = 0;
        try (PreparedStatement stm = CON.prepareStatement("select * from valutazione_blog where id_blog = ?")) {
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
     * Metodo che ritorna la valutazione media di una articolo.
     *
     * @param id E' l'id della ricetta che si vuole conoscere la valutazione
     * @return Ritorna il valore della valutazione per esempio 4.5
     * @throws DAOException
     */
    @Override
    public double getRate(int id) throws DAOException {
        checkCON();

        double val = 0;
        try (PreparedStatement stm = CON.prepareStatement("select * from valutazione_blog where id_blog = ?")) {
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
     * Metodo per inviare la valutazione di una articolo.<br>
     * Setta i valori delle varie stelle sostituendo quelli vecchi.
     *
     * @param id E' l'id della articolo che si vuole valutare
     * @param value E' il valore della valutazione che sivuole lasciare.
     * @throws DAOException
     */
    @Override
    public void setRate(int id, double value) throws DAOException {
        checkCON();

        int number5 = 0, number45 = 0, number4 = 0, number35 = 0, number3 = 0, number25 = 0, number2 = 0, number15 = 0, number1 = 0, number05 = 0;

        try (PreparedStatement stm = CON.prepareStatement("select * from valutazione_blog where id_blog = ?")) {
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

        try (PreparedStatement statement = CON.prepareStatement("REPLACE INTO valutazione_blog (id_blog, rate5,rate4,rate3,rate2,rate1,rate05,rate15,rate25,rate35,rate45, value) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)")) {

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
                throw new DAOException("Impossible to update the valutazione_blog");
            }

        } catch (SQLException ex) {
            throw new DAOException(ex);

        }
    }

    /**
     * Metodo che ritorna tutti gli id dei tag esistenti
     * @return
     * @throws DAOException
     */
    @Override
    public ArrayList<Integer> getAllTags() throws DAOException {
        checkCON();

        ArrayList<Integer> tags = new ArrayList<>();
        ArrayList<Blog> blogs;
        boolean check;

        try (PreparedStatement stm = CON.prepareStatement("select id from tags")) {

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    check = false;
                    blogs = getAllBlogsWithTag(rs.getInt("id"));
                    if (!blogs.isEmpty()) {
                        for (Blog b : blogs) {
                            if (b.isPubblicato()) {
                                check = true;
                            }
                        }
                    }
                    if (check) {
                        tags.add(rs.getInt("id"));
                    }
                }
            }

        } catch (SQLException ex) {
            throw new DAOException("getAllTags error 1", ex);
        }

        Collections.shuffle(tags);

        return tags;
    }

    /**
     * Metodo che ritorna l'id di un tag dal testo
     * @param testo
     * @return
     * @throws DAOException
     */
    @Override
    public int getIDTag(String testo) throws DAOException {
        checkCON();

        int tag = 0;

        try (PreparedStatement stm = CON.prepareStatement("select id from tags where testo = ?")) {
            stm.setString(1, testo);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    try {
                        tag = rs.getInt("id");
                    } catch (SQLException e) {
                        System.out.println(e.getSQLState());
                    }
                }
            }

        } catch (SQLException ex) {
            throw new DAOException("getIDTag error", ex);
        }

        return tag;
    }

    /**
     * Metodo che ritorna tutti i tag di un particolare blog
     * @param id_blog
     * @return
     * @throws DAOException
     */
    @Override
    public ArrayList<Integer> getAllTagsOfBlog(int id_blog) throws DAOException {
        checkCON();

        ArrayList<Integer> tags = new ArrayList<>();

        try (PreparedStatement stm = CON.prepareStatement("select tag from blog_tags where blog=?")) {
            stm.setInt(1, id_blog);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tags.add(rs.getInt("prodotto"));
                }
            }

        } catch (SQLException ex) {
            throw new DAOException("getAllTagsOfBlog error 1", ex);
        }

        Collections.shuffle(tags);

        return tags;
    }

    /**
     * Metodo che ritorna il testo di tutti i tag di un blog
     * @param id_blog
     * @return
     * @throws DAOException
     */
    @Override
    public ArrayList<String> getAllTextTagsOfBlog(int id_blog) throws DAOException {
        checkCON();

        ArrayList<String> tags = new ArrayList<>();
        ArrayList<Integer> ids = new ArrayList<>();

        try (PreparedStatement stm = CON.prepareStatement("select tag from blog_tags where blog=?")) {
            stm.setInt(1, id_blog);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    ids.add(rs.getInt("tag"));
                }
            }

        } catch (SQLException ex) {
            throw new DAOException("getAllTagsOfBlog error 1", ex);
        }

        for (int id : ids) {
            try (PreparedStatement stm = CON.prepareStatement("select testo from tags where id=?")) {
                stm.setInt(1, id);

                try (ResultSet rs = stm.executeQuery()) {
                    while (rs.next()) {
                        tags.add(rs.getString("testo"));
                    }
                }

            } catch (SQLException ex) {
                throw new DAOException("getAllTagsOfBlog error 1", ex);
            }
        }

        Collections.shuffle(tags);

        return tags;
    }

    /**
     * Metodo che ritorna gli id dei tag collegati ad un prodotto di un blog
     * @param id_blog
     * @return
     * @throws DAOException
     */
    @Override
    public ArrayList<Integer> getProductTagsOfBlog(int id_blog) throws DAOException {
        checkCON();

        ArrayList<String> tags = getAllTextTagsOfBlog(id_blog);
        ArrayList<Integer> prodotti = new ArrayList<>();

        for (String nome : tags) {
            try (PreparedStatement stm = CON.prepareStatement("select id from prodotto where nome = ?")) {
                stm.setString(1, nome);
                try (ResultSet rs = stm.executeQuery()) {
                    while (rs.next()) {
                        prodotti.add(rs.getInt("id"));
                    }
                }
            } catch (SQLException ex) {
                throw new DAOException("Impossibile restituire tutti i prodotti dei tag del blog. (JDBCBlogDAO, getProductTagsOfBlog)", ex);
            }
        }

        Collections.shuffle(prodotti);

        return prodotti;
    }

    /**
     * Metodo che ritorna gli id dei tag collegati ad una categoria di un blog
     * @param id_blog
     * @return
     * @throws DAOException
     */
    @Override
    public ArrayList<Integer> getCategoryTagsOfBlog(int id_blog) throws DAOException {
        checkCON();

        ArrayList<String> tags = getAllTextTagsOfBlog(id_blog);
        ArrayList<Integer> categorie = new ArrayList<>();

        for (String nome : tags) {
            try (PreparedStatement stm = CON.prepareStatement("select id from categorie where nome = ?")) {
                stm.setString(1, nome);
                try (ResultSet rs = stm.executeQuery()) {
                    while (rs.next()) {
                        categorie.add(rs.getInt("id"));
                    }
                }
            } catch (SQLException ex) {
                throw new DAOException("Impossibile restituire tutte le categorie dei tag del blog. (JDBCBlogDAO, getCategoryTagsOfBlog)", ex);
            }
        }

        Collections.shuffle(categorie);

        return categorie;
    }

    /**
     * Metodo che ritorna tutti i blog di una determinata categoria
     * @param cat
     * @return
     * @throws DAOException
     */
    @Override
    public ArrayList<Blog> getAllBlogsOfCategory(String cat) throws DAOException {
        checkCON();

        ArrayList<Blog> blogs = new ArrayList<>();
        try (PreparedStatement stm = CON.prepareStatement("select * from blog where categoria = (select nome from blog_cat where id_cat = ?) and pubblicato = true")) {
            stm.setString(1, cat);  

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Blog c = new Blog();
                    c.setId(rs.getInt("id"));
                    c.setCategoria(rs.getString("categoria"));
                    c.setNome(rs.getString("nome"));
                    c.setTesto(rs.getString("testo"));
                    c.setDescrizione(rs.getString("descrizione"));
                    c.setImmagine(rs.getString("immagine"));
                    c.setCreatore(rs.getString("creatore"));
                    c.setData(rs.getTimestamp("data"));
                    c.setViews(rs.getInt("views"));
                    c.setPubblicato(rs.getBoolean("pubblicato"));
                    blogs.add(c);
                }
                //Serve per ordinarlo per vedere prima i più recenti
                Collections.sort(blogs, (Blog z1, Blog z2) -> {
                    if (z1.getData().after(z2.getData())) {
                        return -1;
                    }
                    if (z1.getData().before(z2.getData())) {
                        return 1;
                    }
                    return 0;
                });
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire tutti i blogs della categoria. (JDBCBlogDAO, getAllBlogs)", ex);
        }
        return blogs;
    }

    /**
     * Metodo che ritorna tutti i blog che contengono dei tag
     * @param tag
     * @return
     * @throws DAOException
     */
    @Override
    public ArrayList<Blog> getAllBlogsWithTag(int tag) throws DAOException {
        checkCON();

        ArrayList<Blog> blogs = new ArrayList<>();
        try (PreparedStatement stm = CON.prepareStatement("select blog from blog_tags where tag = ?")) {
            stm.setInt(1, tag);
            int b;

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    b = rs.getInt("blog");

                    try (PreparedStatement stm1 = CON.prepareStatement("select * from blog where id = ? and pubblicato = true")) {
                        stm1.setInt(1, b);

                        try (ResultSet rs1 = stm1.executeQuery()) {
                            while (rs1.next()) {
                                Blog c = new Blog();
                                c.setId(rs1.getInt("id"));
                                c.setCategoria(rs1.getString("categoria"));
                                c.setNome(rs1.getString("nome"));
                                c.setTesto(rs1.getString("testo"));
                                c.setDescrizione(rs1.getString("descrizione"));
                                c.setImmagine(rs1.getString("immagine"));
                                c.setCreatore(rs1.getString("creatore"));
                                c.setData(rs1.getTimestamp("data"));
                                c.setViews(rs1.getInt("views"));
                                c.setPubblicato(rs1.getBoolean("pubblicato"));
                                blogs.add(c);
                            }
                            //Serve per ordinarlo per vedere prima i più recenti
                            Collections.sort(blogs, (Blog z1, Blog z2) -> {
                                if (z1.getData().after(z2.getData())) {
                                    return -1;
                                }
                                if (z1.getData().before(z2.getData())) {
                                    return 1;
                                }
                                return 0;
                            });
                        }
                    } catch (SQLException ex) {
                        throw new DAOException("Impossibile restituire tutti i blogs della categoria. (JDBCBlogDAO, getAllBlogs)", ex);
                    }
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(JDBCBlogDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return blogs;
    }

    /**
     * Metodo che ritorna il testo di un determinato tag
     * @param id
     * @return
     * @throws DAOException
     */
    @Override
    public String getTagName(int id) throws DAOException {
        checkCON();

        String name = "";

        try (PreparedStatement stm = CON.prepareStatement("select testo from tags where id = ?")) {
            stm.setInt(1, id);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    name = rs.getString("testo");
                }
            }

        } catch (SQLException ex) {
            throw new DAOException("getTag error", ex);
        }

        return name;
    }

    /**
     * Metodo che ritorna tutti gli articoli collegati ad un idea
     * @param name
     * @param category
     * @return
     * @throws DAOException
     */
    @Override
    public ArrayList<Blog> getBlogsOfIdeaProd(String name, String category) throws DAOException {

        boolean check = false;
        int idTagName = getIDTag(name);
        int idTagCat = getIDTag(category);
        ArrayList<Blog> byName = getAllBlogsWithTag(idTagName);
        ArrayList<Blog> byCategory = getAllBlogsWithTag(idTagCat);
        ArrayList<Blog> blogs = new ArrayList<>(byCategory);

        for (Blog b : byName) {
            for (Blog g : byCategory) {
                if (b.getId() == g.getId()) {
                    check = true;
                } else {
                }
            }
            if (!check) {
                blogs.add(b);
            }
            check = false;
        }

        return blogs;
    }

    /**
     * MEtodo che controlla se una categoria di blog ha degli articoli visibili
     * @param idCat
     * @return
     * @throws DAOException
     */
    @Override
    public boolean hasVisibileBlogs(int idCat) throws DAOException {
        ArrayList<Blog> categoria = getAllBlogsOfCategory("" + idCat);
        if (!categoria.isEmpty()) {
            if (categoria.stream().anyMatch((b) -> (b.isPubblicato()))) {
                return true;
            }
        }
        return false;
    }

    @Override
    public Blog getLastBlog() throws DAOException {
        checkCON();
        Blog c = null;

        try (PreparedStatement stm = CON.prepareStatement("select * from blog where data = (SELECT max(data) from blog)")) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    c = new Blog();
                    c.setId(rs.getInt("id"));
                    c.setCategoria(rs.getString("categoria"));
                    c.setNome(rs.getString("nome"));
                    c.setTesto(rs.getString("testo"));
                    c.setDescrizione(rs.getString("descrizione"));
                    c.setImmagine(rs.getString("immagine"));
                    c.setCreatore(rs.getString("creatore"));
                    c.setData(rs.getTimestamp("data"));
                    c.setViews(rs.getInt("views"));
                    c.setPubblicato(rs.getBoolean("pubblicato"));
                }
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire il blog dall'id. (JDBCCatBlogDAO, getBlogById)", ex);
        }
        return c;
    }
}
