/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.daos;

import database.entities.Commento;
import database.entities.Ricetta;
import database.exceptions.DAOException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author della
 */
public interface RicetteDAO {
    public void checkCON() throws DAOException;    
    
    public ArrayList<Ricetta> getAllRecipes() throws DAOException;
    public Ricetta getRecipe(int id) throws DAOException;
    public Ricetta getRecipeByName(String nome) throws DAOException;
    public ArrayList<Ricetta> getRecipeOfProduct(int id_prod) throws DAOException;
    public ArrayList<Ricetta> getMostViewedRecipes() throws DAOException;
    public void incrementViews(int id, int viewsOld, HttpServletRequest request) throws DAOException;
    public ArrayList<Ricetta> getOrderedBy(String type, ArrayList<Ricetta> ricette) throws DAOException;
    public ArrayList<Ricetta> getByType(String type) throws DAOException;
    public int getTypeSize(String type) throws DAOException;
    public void addRecipe(String nome, String procedimento, String descrizione, String difficolta, String ingredienti, String creatore, int tempo, boolean categoria) throws DAOException;
    public Ricetta getLastRecipe() throws DAOException;
    
    //Valutazione
    public int getNumberRate(int id) throws DAOException;
    public double getRate(int id) throws DAOException;
    public void setRate(int id, double value) throws DAOException;
    
    //Commenti
    public ArrayList<Commento> getAllComments() throws DAOException;
    public ArrayList<Commento> getComments(int id_ricetta) throws DAOException;
    public void postComment(int id_ricetta, String nome, String commento) throws DAOException;
    
    //Prodotti-Idea
    public ArrayList<Integer> getAllProdottiIdea() throws DAOException;
    public int getProdFormProdIdea(int id) throws DAOException;
    public int getIdeaFormProdIdea(int id) throws DAOException;
    public ArrayList<Integer> getAllProdsOfIdea(int id) throws DAOException;
}
