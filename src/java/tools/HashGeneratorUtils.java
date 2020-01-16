/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tools;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
/**
 *
 * @author della
 */
public class HashGeneratorUtils {
    private HashGeneratorUtils() {
 
    }
 
    public static String generateMD5(String message){
        return hashString(message, "MD5");
    }
 
    public static String generateSHA1(String message){
        return hashString(message, "SHA-1");
    }
 
    public static String generateSHA256(String message){
        return hashString(message, "SHA-256");
    }
 
    private static String hashString(String message, String algorithm){
 
        try {
            MessageDigest digest = MessageDigest.getInstance(algorithm);
            byte[] hashedBytes = digest.digest(message.getBytes(StandardCharsets.UTF_8)); 
            return convertByteArrayToHexString(hashedBytes);            
            
        } catch (NoSuchAlgorithmException e) {
            System.out.println("Causa add servlet:\n");
            String error = "ERRORE";
            return error;
        }
    }
 
    private static String convertByteArrayToHexString(byte[] arrayBytes) {
        
        StringBuilder hexString = new StringBuilder();
        for (int i = 0; i < arrayBytes.length; i++) {
            String hex = Integer.toHexString(0xff & arrayBytes[i]);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }
    
    public static String MD5Digest(String args)throws Exception {

		
		String original = args;
		MessageDigest md = MessageDigest.getInstance("MD5");
		md.update(original.getBytes());
		byte[] digest = md.digest();
		StringBuilder sb = new StringBuilder();
		for (byte b : digest) {
			sb.append(String.format("%02x", b & 0xff));
		}

		System.out.println("original:" + original);
		System.out.println("digested(hex):" + sb.toString().toUpperCase());
                return sb.toString().toUpperCase();
	} 
    
}
