/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package varie;

import database.entities.Prodotto;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.Cookie;

/**
 *
 * @author Roberto97
 */

public class Costanti {
    public static final int CART_COOKIE_MAX_AGE = 60*60*24*30;
    public static final int PREF_COOKIE_MAX_AGE = 60*60*24*365;
    
    public static final int NUM_MOST_VIEWED_POSTS = 4;
    public static final String SECRET_KEY = "6Ld8YaAUAAAAAAA9C1RXyyLjQGD8k8n1gRqQAIzZ";
    public static final String PUBLIC_KEY = "6Ld8YaAUAAAAAKDIu30P3tuRfUuPw-XgFHd9_J5U";
    
    public static final float MIN_COSTO = 100;
    public static final float MED_COSTO = 200;
    public static final float MAX_COSTO = 275;
    
    public static final double MIN_PESO = 15;
    public static final double MED_PESO = 25;
    public static final double MAX_PESO = 50;
    
    /* Costo box keatchen più la scatola protettiva obbligatoria + gel refrigerante */
    public static final double MIN_W_PRICE = 4.3+1.75+1.8;
    public static final double MED_W_PRICE = 5.4+1.75+1*1.8;
    public static final double MAX_W_PRICE = 6.4+2.5+1*1.8;
    
    /* Costo spedizioni */
    public static final double MIN_PRICE = 8.9;
    public static final double MED_PRICE = 12.9;
    public static final double MAX_PRICE = 21.9;
    
    public static final String ROB_MAIL = "dellantonio47@gmail.com";
    public static final String ROB_PASS = "jwjdxemvcgvppvgp";
    public static final String MAC_MAIL = "macelleriabortoleto@gmail.com";
    public static final String MAC_PASS = "zwvbnhynldgwqugc";
    public static final String ENCRYPT_USER = "info@macelleriadellantonio.it";
    public static final String ENCRYPT_PASS = "Bortoleto1";
    
    public static final String SPACES_COOKIE = "///-_--_";
    
    //Servono per salvare i cookie e gli attributi di sessione durante il pagamento
    //vengono identificati dall'id dell'ordine
    public static Map<String, Cookie[]> cookiesA = new HashMap<String, Cookie[]>();
    public static Map<String, Map<String, Object>> sessionA = new HashMap<String, Map<String, Object>>();
    
    public static final String NEW_ORDER = "Nuovo Ordine";
    public static final String NEW_RATE = "Nuova Valutazione";
    public static final String NEW_COMMENT = "Nuovo Commento";
    public static final String NEW_IDEA = "Nuova idea da un utente";    
    public static final String NEW_ORDER_LINK = "ordine.jsp?id=";
    
    public static ArrayList<Prodotto> suggeriti = new ArrayList<>();
    
    /* Se si aggiornano i nomi della sue macrocategorie bisogna aggiornare anche nel file /WEB-INF/urlrewrite.xml e nella sitemapBortoleto.xml */
    public static final String TRENTINO = "Specialità Del Trentino";
    public static final String FRESCHI = "Alimenti Freschi";
    
}
