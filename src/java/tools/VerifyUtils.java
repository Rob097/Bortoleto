/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tools;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.net.ssl.HttpsURLConnection;
import static varie.Costanti.SECRET_KEY;

public class VerifyUtils {

    public static final String SITE_VERIFY_URL
            = //
            "https://www.google.com/recaptcha/api/siteverify";

    public static boolean verify(String gRecaptchaResponse) {
        if (gRecaptchaResponse == null || gRecaptchaResponse.length() == 0) {
            return false;
        }

        try {
            URL verifyUrl = new URL(SITE_VERIFY_URL);

            // Open a Connection to URL above.
            HttpsURLConnection conn = (HttpsURLConnection) verifyUrl.openConnection();

            // Add the Header informations to the Request to prepare send to the server.
            conn.setRequestMethod("POST");
            conn.setRequestProperty("User-Agent", "Mozilla/5.0");
            conn.setRequestProperty("Accept-Language", "en-US,en;q=0.5");

            // Data will be sent to the server.
            String postParams = "secret=" + SECRET_KEY //
                    + "&response=" + gRecaptchaResponse;

            // Send Request
            conn.setDoOutput(true);

            try ( // Get the output stream of Connection.
            // Write data in this stream, which means to send data to Server.
                    OutputStream outStream = conn.getOutputStream()) {
                outStream.write(postParams.getBytes());
                
                outStream.flush();
            }

            // Response code return from Server.
            //int responseCode = conn.getResponseCode();
            //System.out.println("responseCode=" + responseCode);

            // Get the Input Stream of Connection to read data sent from the Server.
            InputStream is = conn.getInputStream();

            JsonObject jsonObject;
            try (JsonReader jsonReader = Json.createReader(is)) {
                jsonObject = jsonReader.readObject();
            }

            // ==> {"success": true}
            //System.out.println("Response: " + jsonObject);

            boolean success = jsonObject.getBoolean("success");
            return success;
        } catch (IOException e) {
            return false;
        }
    }
}
