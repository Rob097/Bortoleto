/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.daos;

import database.exceptions.DAOException;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Roberto97
 */
public interface PagamentoDAO {
    public void checkCON() throws DAOException;    
    
    public String getSpeseSpedizione(String costo, boolean ritiro, HttpServletRequest request) throws DAOException;
    public String getTot(String costo, String spedizioni) throws DAOException;
    public void orderConfirmed(HttpServletRequest request, String order_id) throws DAOException;
    public void orderAnnulled(HttpServletRequest request, String order_id) throws DAOException;
}
