/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.daos;

import database.entities.Prodotto;
import database.entities.Variante;
import database.exceptions.DAOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Roberto97
 */
public interface ProductDAO{ 
    public void checkCON() throws DAOException;    
    
    public ArrayList<Prodotto> getAllProducts() throws DAOException;
    public ArrayList<Prodotto> getFreshProducts() throws DAOException;
    public ArrayList<Prodotto> getConfProducts() throws DAOException;
    public ArrayList<Prodotto> getAllProductsOfCategory(String categoryName) throws DAOException;
    public ArrayList<Prodotto> getOtherProductsOfCategory(String categoryName, int id) throws DAOException;
    public Prodotto getProduct(int id) throws DAOException;
    public Prodotto getProductByName(String nome) throws DAOException;
    public ArrayList<Prodotto> getAllProductsOfSession(String ids) throws DAOException;
    public boolean isPreferito(int id, HttpServletRequest request) throws DAOException;
    public void setRate(int id, double value) throws DAOException;
    public double getRate(int id) throws DAOException;
    public int getNumberRate(int id) throws DAOException;
    public ArrayList<Prodotto> getSuggestedProducts() throws DAOException;
    
    //Carrello
    public boolean isInCart(int id, HttpServletRequest request) throws DAOException;
    public ArrayList<Prodotto> getAllProductsOfCart(HttpServletRequest request) throws DAOException;
    public ArrayList<Prodotto> getFreshProductsOfCart(HttpServletRequest request) throws DAOException;
    public String getPartial(int quantita, String costo) throws DAOException;
    public String getTotalOfCart(HttpServletRequest request) throws DAOException;
    public double getTotalWeightOfCart(HttpServletRequest request) throws DAOException;
    public void updateQuantity(int id, String variante, int quantita, HttpServletRequest request, HttpServletResponse response) throws DAOException;
    public int getCartSize(HttpServletRequest request) throws DAOException;
    public String checkWeight(HttpServletRequest request) throws DAOException;
    public String checkDisponibile(String ids) throws DAOException;
    public String getfreshBoxType(HttpServletRequest request) throws DAOException;
    
    //Varianti
    //public HashMap<String, ArrayList<String>> getProductVariant(int idProd) throws DAOException;
    public ArrayList<ArrayList<Variante>> getProductVariant(int idProd) throws DAOException;
    public Variante getVariant(int id) throws DAOException;
    public ArrayList<Variante> getFrstVariantOfProduct(int idProd) throws DAOException;
    public LinkedHashMap<ArrayList<Variante>, Integer> getCartVariant(HttpServletRequest request) throws DAOException;
    public String getVariantBlock(ArrayList<Variante> blocco) throws DAOException;
    public LinkedHashMap<ArrayList<Variante>, Integer> getCartProductVariant(HttpServletRequest request, int idProduct) throws DAOException;
    public double getWeightOfVariantCombination(ArrayList<Variante> blocco) throws DAOException;
    public double getCostOfVariantCombination(ArrayList<ArrayList<Variante>> blocco) throws DAOException;    
    public double getWeightOfVariantCombinationFull(ArrayList<ArrayList<Variante>> blocco) throws DAOException;
}
