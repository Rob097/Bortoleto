/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tools;

import database.daos.ProductDAO;
import database.exceptions.DAOException;
import database.factories.DAOFactory;
import database.jdbc.JDBCProductDAO;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletException;

public class ScheduledTask implements Runnable {

    ProductDAO productdao = null;
    ServletContextEvent sce = null;

    public ScheduledTask(ServletContextEvent sce) {
        this.sce = sce;
    }

    @Override
    public void run() {
        try {
            getConn();
            varie.Costanti.suggeriti = productdao.getSuggestedProducts();
        } catch (ServletException | SQLException | DAOException ex) {
            Logger.getLogger(ScheduledTask.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //gets the created daoFactory connection
    private void getConn() throws ServletException, SQLException {
        DAOFactory daoFactory = (DAOFactory) sce.getServletContext() .getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }

        productdao = new JDBCProductDAO(daoFactory.getConnection());
    }
}
