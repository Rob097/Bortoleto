<%-- 
    Document   : menu
    Created on : 30-apr-2019, 17.38.17
    Author     : Roberto97
--%>


<!-- Per impedire alla maggior parte dei motori di ricerca di indicizzare la pagina -->
<meta name="robots" content="noindex">
<!-- Per impedire solo a Google di indicizzare la pagina -->
<meta name="googlebot" content="noindex">


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="request" value="<%=request%>"/>
<c:set var="nome" value="${request.getParameter('nome')}"/>
<c:set var="immagine" value="${request.getParameter('immagine')}"/>

<div id="sections" class="container">                    
    <div class="mt-5 mb-5 text-center">
        <h3 class="macTitle" data-aos="fade-right" data-aos-duration="2000">${nome}</h3>
        <a class="buttonS" href="#menu" onclick="backMenu();" style='color: black; background-color: white;'>Torna indietro</a><br>
        <a target="_blank" rel="noopener" href="${immagine}"><i class="fas fa-search-plus mr-2"></i>Ingrandisci</a><br>
        <img style="margin-top: 3rem!important; width: 100%;  box-shadow: 0px 0px 50px rgba(0, 0, 0, 0.22);" src="${immagine}"/>
    </div>
</div>

<div class="mt-5 mb-5 text-center">
    <a class="buttonS" href="#menu" onclick="backMenu();" style='color: black; background-color: white;'>Torna indietro</a>
</div>

