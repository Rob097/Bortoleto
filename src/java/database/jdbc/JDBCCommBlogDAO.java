package database.jdbc;

import database.daos.CommBlogDAO;
import database.entities.CommBlog;
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

/**
 *JDBCDAO Per i metodi relativi ai commenti del blog.
 * 
 * @author Roberto97
 */
public class JDBCCommBlogDAO extends JDBCDAO implements CommBlogDAO {

    /**
     * Questa è il costruttore e serve fondamentalmente per collegarsi alla connessione aperta con il DB
     * 
     * @param con E' la connessione al DB
     * @throws java.sql.SQLException
     */
    public JDBCCommBlogDAO(Connection con) throws SQLException {
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
     * Metodo che ritorna tutti i commenti di tutti i blog.<br>
     * Questo metodo è utilizzato dal CookieFilter per creare un attributo di sessione
     * contenente tutti i commenti di tutti i blog. Questo attributo viene poi
     * usato nei cicli nelle pagine jsp
     * @return Ritorna un arrayList di commenti blog.
     * @throws DAOException
     */
    @Override
    public ArrayList<CommBlog> getAllCommBlog() throws DAOException {
        checkCON();
        
        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM blog_commenti")) {
            ArrayList<CommBlog> commenti = new ArrayList<>();

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    CommBlog c = new CommBlog();
                    c.setId_blog(rs.getInt("id_blog"));
                    c.setNome(rs.getString("nome"));
                    c.setCommento(rs.getString("commento"));
                    c.setData(rs.getTimestamp("data"));
                    commenti.add(c);
                }

                return commenti;
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire tutti i commenti dei blog. (JDBCCommBlogDAO, getAllCommBlog)", ex);
        }
    }

    /**
     * Metodo che ritorna tutti i commenti di un particolare blog.
     * @param id_blog Indica l'id del blog per cui si voglioino i commenti.
     * @return Ritorna un arrayList di commenti blog.
     * @throws DAOException
     */
    @Override
    public ArrayList<CommBlog> getAllCommOfBlog(int id_blog) throws DAOException {
        checkCON();
        
        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM blog_commenti where id_blog = ?")) {
            stm.setInt(1, id_blog);
            ArrayList<CommBlog> commenti = new ArrayList<>();

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    CommBlog c = new CommBlog();
                    c.setId_blog(rs.getInt("id_blog"));
                    c.setNome(rs.getString("nome"));
                    c.setCommento(rs.getString("commento"));
                    c.setData(rs.getTimestamp("data"));
                    commenti.add(c);
                }

                Collections.sort(commenti, (CommBlog z1, CommBlog z2) -> {
                    if (z1.getData().after(z2.getData())) {
                        return -1;
                    }
                    if (z1.getData().before(z2.getData())) {
                        return 1;
                    }
                    return 0;
                });
            }
            return commenti;
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire tutti i commenti del blog. (JDBCCommBlogDAO, getAllCommOfBlog)", ex);
        }
    }

    /**
     * Metodo per pubblicare un nuovo commento.
     * @param idBlog Indica l'id del blog per cui si vuole pubblicare il commento
     * @param nome Indica il nome della persona che pubblica il commento
     * @param commento Indica il testo del commento da pubblicare.
     * @throws DAOException
     */
    @Override
    public void postBlogComment(int idBlog, String nome, String commento) throws DAOException {
        checkCON();
        
        if (idBlog == 0 || nome == null || "".equals(nome) || commento == null || "".equals(commento) || commento.isEmpty() || nome.isEmpty()) {
            throw new DAOException("idBlog or name or comment invalid", new NullPointerException("idBlog or name or comment invalid"));
        }
        
        try (PreparedStatement statement = CON.prepareStatement("insert into blog_commenti (id_blog, nome, commento) values (?, ?, ?)")) {
            statement.setInt(1, idBlog);
            statement.setString(2, nome);
            statement.setString(3, commento);
            if (statement.executeUpdate() == 1) {
            } else {
                throw new DAOException("Impossible to insert the comment of blog");
            }
        } catch (SQLException ex) {
            System.out.println("Impossible to insert the comment of blog");
        }
    }

}
