/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.jdbc;

import database.daos.MenuDAO;
import database.entities.Menu;
import database.exceptions.DAOException;
import database.exceptions.DAOFactoryException;
import database.factories.JDBCDAOFactory;
import static database.factories.JDBCDAOFactory.DBURL;
import java.sql.Connection;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Roberto97
 */
public class JDBCMenuDAO extends JDBCDAO implements MenuDAO{
    
    /**
     * Costruttore
     * @param con
     * @throws SQLException
     */
    public JDBCMenuDAO(Connection con) throws SQLException {
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
     * Ritorna tutti i menu presenti nel DB
     * @return
     * @throws DAOException
     */
    @Override
    public ArrayList<Menu> getAllMenu() throws DAOException {
        checkCON();
        
        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM menu")) {
            ArrayList<Menu> menu = new ArrayList<>();

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Menu p = new Menu();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    p.setImmagine(rs.getString("immagine"));
                    p.setCopertina(rs.getString("copertina"));
                    menu.add(p);
                }

                return menu;
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossibile restituire tutti i menu. (JDBCMenuDAO, getAllMenu)", ex);
        }
    }
    
}
