/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.daos;

import database.entities.Menu;
import database.exceptions.DAOException;
import java.util.ArrayList;

/**
 *
 * @author Roberto97
 */
public interface MenuDAO {
    public void checkCON() throws DAOException;    
    
    public ArrayList<Menu> getAllMenu() throws DAOException;
}
