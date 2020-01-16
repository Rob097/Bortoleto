<%-- 
    Document   : sendBank
    Created on : 9-feb-2019, 19.12.41
    Author     : Roberto97
--%>


<!-- Per impedire alla maggior parte dei motori di ricerca di indicizzare la pagina -->
<meta name="robots" content="noindex">
<!-- Per impedire solo a Google di indicizzare la pagina -->
<meta name="googlebot" content="noindex">


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
System.out.println(session.getAttribute("MERCHANT_ID"));
System.out.println(session.getAttribute("ORDER_ID"));
System.out.println(session.getAttribute("IMPORTO"));
System.out.println(session.getAttribute("DIVISA"));
System.out.println(session.getAttribute("ABI"));
System.out.println(session.getAttribute("ITEMS"));
System.out.println(session.getAttribute("URLOK"));
System.out.println(session.getAttribute("URLKO"));
System.out.println(session.getAttribute("URLACK"));
System.out.println(session.getAttribute("URLNACK"));
System.out.println(session.getAttribute("MAC"));
System.out.println(session.getAttribute("LINGUA"));--%>


<input type = "hidden" name = "MERCHANT_ID" value = "${MERCHANT_ID}">
<input type = "hidden" name = "ORDER_ID" value = "${ORDER_ID}">
<input type = "hidden" name = "IMPORTO" value = "${IMPORTO}">
<input type = "hidden" name = "DIVISA" value = "${DIVISA}">
<input type = "hidden" name = "ABI" value = "${ABI}">
<input type = "hidden" name = "ITEMS" value = "${ITEMS}">
<input type = "hidden" name = "URLOK" value = "${URLOK}">
<input type = "hidden" name = "URLKO" value = "${URLKO}">
<input type = "hidden" name = "URLACK" value = "${URLACK}">
<input type = "hidden" name = "URLNACK" value = "${URLNACK}">
<input type = "hidden" name = "MAC" value = "${MAC}">
<input type = "hidden" name = "LINGUA" value = "${LINGUA}">
<input type = "hidden" name = "EMAIL" value = "${EMAIL}">

<c:remove var="MERCHANT_ID" scope="session" />
<%--<c:remove var="IMPORTO" scope="session" /> Viene cancellato dopo l'ack/nack --%>
<c:remove var="DIVISA" scope="session" />
<c:remove var="ABI" scope="session" />
<%--<c:remove var="ITEMS" scope="session" /> Viene cancellato dopo l'ack/nack --%>
<c:remove var="URLOK" scope="session" />
<c:remove var="URLKO" scope="session" />
<c:remove var="URLACK" scope="session" />
<c:remove var="URLNACK" scope="session" />
<c:remove var="MAC" scope="session" />
<c:remove var="LINGUA" scope="session" />
<%--<c:remove var="EMAIL" scope="session" /> Viene cancellato dopo l'ack/nack --%>
