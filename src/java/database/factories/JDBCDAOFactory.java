/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.factories;

import database.exceptions.DAOFactoryException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import static tools.EncryptDecryptString.decrypt;
import static tools.EncryptDecryptString.encrypt;

/**
 *
 * @author Roberto97
 */
public class JDBCDAOFactory implements DAOFactory{
    
    /*DB on cloud
    public static final String DBURL = "jdbc:mysql://macelleriadellantonio.it:3306/maceller_MacAPPDB?confluence&autoReconnect=true";
    public static final  String USERNAME = "maceller_Mac_Usr";
    public static final String PASSWORD = encrypt("Bortoleto1901");
    
    /*DB on Rasp*/
    public static final String DBURL = "jdbc:mysql://ourlists.ddns.net:3306/DBB?autoReconnect=true&zeroDateTimeBehavior=convertToNull";
    //public static final String DBURL = "jdbc:mysql://192.168.1.104:3306/DBB?autoReconnect=true&zeroDateTimeBehavior=convertToNull";
    public static final String USERNAME = "user";
    public static final String PASSWORD = encrypt("the_password");
    
    private final String DRIVER = "com.mysql.jdbc.Driver";
    private transient Connection CON;
    private static JDBCDAOFactory instance;
    
    //ritorna un istanza di questa Classe
     public static synchronized JDBCDAOFactory getInstance() throws DAOFactoryException {
        if (instance == null) {
            //crea un istanza di questa classe e la inizializza con il costruttore. 
            instance = new JDBCDAOFactory(DBURL);
        } else {
            throw new DAOFactoryException("DAOFactory already configured");
        }
        return instance;
    }
    //Costruttore
    public JDBCDAOFactory(String dbUrl) throws DAOFactoryException {
        super();

        try {
            Class.forName(DRIVER);
            CON = DriverManager.getConnection(DBURL, USERNAME, decrypt(PASSWORD));
        } catch (SQLException sqle) {
            System.out.println("1° catch costruttore factory");
            throw new DAOFactoryException("Cannot get connection", sqle);
        } catch (ClassNotFoundException ex) {
            System.out.println("2° catch costruttore factory");
            Logger.getLogger(JDBCDAOFactory.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    //ritorna una connessione
    @Override
    public Connection getConnection(){
        try {
            if (CON.isClosed()) {
                /*System.out.println("\n\ngetConnection is closed\n");*/
                try {
                    Class.forName(DRIVER);
                    CON = DriverManager.getConnection(DBURL, USERNAME, decrypt(PASSWORD));

                } catch (SQLException | ClassNotFoundException e) {
                }
            }
            if (CON.isValid(0)) {
            } else {
                /*System.out.println("\n\ngetConnection is not valid\n");*/
                try {
                    Class.forName(DRIVER);
                    CON = DriverManager.getConnection(DBURL, USERNAME, decrypt(PASSWORD));

                } catch (SQLException | ClassNotFoundException e) {
                }
            }
        } catch (SQLException ex) {
            try {
                /*System.out.println("\n\ngetConnection in catch\n");*/
                Class.forName(DRIVER);
                CON = DriverManager.getConnection(DBURL, USERNAME, decrypt(PASSWORD));

            } catch (SQLException | ClassNotFoundException e) {
            }
        }
        return CON;
    }
    
    //Chiude la connessione
    @Override
    public void shutdown() {
        try {
            CON.close();
        } catch (SQLException ex) {
            Logger.getLogger(JDBCDAOFactory.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
