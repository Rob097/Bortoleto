<%-- 
    Document   : bigAction
    Created on : 11-giu-2019, 15.16.23
    Author     : Roberto97
--%>


<!-- Per impedire alla maggior parte dei motori di ricerca di indicizzare la pagina -->
<meta name="robots" content="noindex">
<!-- Per impedire solo a Google di indicizzare la pagina -->
<meta name="googlebot" content="noindex">


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="request" value="<%=request%>"/>
<c:set value="${productdao.getProduct(param.id)}" var="prodotto"/>
<c:choose>
    <c:when test="${prodotto.isDisponibile() eq true}">
        <input id="quantitaInput" style="background-color: #795548; color: white; border: none; max-width: 3rem;" type="number" min="1" value="1" />
        <button class="btn btn-outline-brown" onclick="addProd(${param.id}); animation($(this));" style="color: white !important;">
            Aggiungi al carrello
        </button>
    </c:when>
    <c:otherwise>
        <h4 style="background-color: #c32707; padding: 0.3em;">ESAURITO</h4>
    </c:otherwise>
</c:choose>
<c:choose>
    <c:when test="${productdao.isPreferito(param.id, request) == true}">                                        
        <i onclick="removePreferito(${param.id});" style="font-size: 28px; color: #abb9c3;" id="heartGrande" class="fa fa-heart red-text"></i>
    </c:when>
    <c:otherwise>
        <i onclick="addPreferito(${param.id});" style="font-size: 28px; color: #abb9c3;" id="heartGrande" class="fa fa-heart"></i>
    </c:otherwise>
</c:choose>