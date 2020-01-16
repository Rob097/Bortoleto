/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.daos;

import database.entities.Variante;
import database.exceptions.DAOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Roberto97
 */
public interface ConsoleDAO {
    public void checkCON() throws DAOException;    
    
    public void incrementViews(String page, HttpServletRequest request, int id) throws DAOException;
    public void add_updateEmailSub(String email) throws DAOException;
    public void removeEmailSub(String email) throws DAOException;
    public void addNewOrder(HttpServletRequest request, String IMPORTO, String delivery) throws DAOException;
    public void addNotifica(String testo, String link) throws DAOException;
    
    public Variante getVariant(int id) throws DAOException;
    public LinkedHashMap<ArrayList<Variante>, Integer> getVariants(String var) throws DAOException;
    
    public Boolean getStatus() throws DAOException;
}
