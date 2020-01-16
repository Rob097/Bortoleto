

###############################################################################

STAMPARE NELL'OUTPUT TUTTI GLI ATTRIBUTI DI SESSIONE

System.out.println("\n\nATTRIBUTI DI SESSIONE");
Enumeration keys = request.getSession().getAttributeNames();
while (keys.hasMoreElements()) {
    String key = (String) keys.nextElement();
    System.out.println(key + ": " + request.getSession().getValue(key) + "<br>");
}
System.out.println("\n\n");

###############################################################################


	url = https://Rob097@github.com/Rob097/Mac-v2.1.git