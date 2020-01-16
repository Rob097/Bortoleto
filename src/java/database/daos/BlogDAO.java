/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.daos;

import database.entities.Blog;
import database.exceptions.DAOException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Roberto97
 */
public interface BlogDAO {
    public void checkCON() throws DAOException;    
    
    public ArrayList<Blog> getAllBlogs() throws DAOException;
    public Blog getBlogById(int id) throws DAOException;
    public Blog getPrevOrNextById(boolean type, int id) throws DAOException;
    public ArrayList<Blog> getBlogByCat(String cat) throws DAOException;
    public ArrayList<Blog> getMostViewedBlog() throws DAOException;
    public void incrementViews(int id, int viewsOld, HttpServletRequest request) throws DAOException;
    public ArrayList<Blog> getOrderedBy(String type, ArrayList<Blog> blogs) throws DAOException;
    public ArrayList<Blog> getAllBlogsOfCategory(String cat) throws DAOException;
    public ArrayList<Blog> getBlogsOfIdeaProd(String name, String category) throws DAOException;
    public boolean hasVisibileBlogs(int idCat) throws DAOException;
    public Blog getLastBlog() throws DAOException;
    
    
    //Valutazione
    public int getNumberRate(int id) throws DAOException;
    public double getRate(int id) throws DAOException;
    public void setRate(int id, double value) throws DAOException;
    
    //TAGS
    public ArrayList<Integer> getAllTags() throws DAOException;
    public int getIDTag(String text) throws DAOException;
    public String getTagName(int id) throws DAOException;    
    public ArrayList<Blog> getAllBlogsWithTag(int id) throws DAOException;
    public ArrayList<Integer> getAllTagsOfBlog(int id_blog) throws DAOException;
    public ArrayList<String> getAllTextTagsOfBlog(int id_blog) throws DAOException;
    public ArrayList<Integer> getProductTagsOfBlog(int id_blog) throws DAOException;
    public ArrayList<Integer> getCategoryTagsOfBlog(int id_blog) throws DAOException;
}
