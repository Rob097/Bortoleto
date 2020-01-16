<%-- 
    Document   : unSubscribe
    Created on : 21 set 2019, 11:04:19
    Author     : Roberto97
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="request" value="<%=request%>"/>
<c:set value="<%=varie.Costanti.SPACES_COOKIE%>" var="SPACES_COOKIE" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Disiscrivimi</title>
    </head>
    <body>
        <h1>Disiscrivimi dalla neswletter</h1>
        <form name="unSubscribe" action="/Bortoleto/unSubscribe" method="POST">
            <input type="text" name="email" <c:choose><c:when test="${email ne null}">value="${email.replace(SPACES_COOKIE, " ")}"</c:when><c:otherwise>placeholder="La tua email"</c:otherwise></c:choose> required />
            <input type="submit" value="Disiscrivimi" name="disiscrivimiButton" />
        </form>
    </body>
</html>
