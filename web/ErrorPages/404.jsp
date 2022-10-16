<%-- 
    Document   : 404
    Created on : 29-dic-2019, 12.42.19
    Author     : della
--%>


<!-- Per impedire alla maggior parte dei motori di ricerca di indicizzare la pagina -->
<meta name="robots" content="noindex">
<!-- Per impedire solo a Google di indicizzare la pagina -->
<meta name="googlebot" content="noindex">


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% response.setHeader("Content-Encoding", "UTF-8");%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <link rel="icon" href="/Bortoleto/img/favicon.ico" sizes="16x16" >
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>404 Pagina non trovata</title>

        <!-- bootstrap include -->
        <link rel="stylesheet nofollow" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
        <link href="/Bortoleto/css/mdb.min.css" rel="stylesheet nofollow">
        <!--include css -->
        <link rel="stylesheet nofollow" href="/Bortoleto/css/style-min.css">
        <link rel="stylesheet nofollow" href="/Bortoleto/css/font-min.css">
        <link rel="stylesheet nofollow" href="/Bortoleto/ErrorPages/ErrorPages_CSS/style.css">
        <link rel="stylesheet nofollow" href="/Bortoleto/css/navbar-min.css">
    </head>

    <body class="foo white-text" id="topPage" data-spy="scroll" data-target=".sidebar" style='background-color: #ffce92;'>
        <a class="rightGold" href="#topPage" id="myBtn45" title="Torna in cima"><i class="fas fa-arrow-up"></i></a>

        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                Menu
                <i class="fa fa-bars"></i>
            </button>
            <a id="nav-logo-img" class="navbar-brand" href="<c:url value="/#Bortoleto"/>">
                <img width="90vh" src="https://www.4shared.com/img/Eqhxxzi7fi/s25/166e3520be8/logo2" alt="Logo">
            </a>
            <a id="nav-logo-title" class="navbar-brand js-scroll-trigger" href="/Bortoleto/">'L Bortoleto</a>
            <a class="menu-cart-button hs-cart" href="<c:url value="/bottega.jsp"/>">
                <i style="margin-right: 20px; font-size: 30px; vertical-align:middle;" class="fas fa-shopping-cart"></i>
            </a>

            <div class="collapse navbar-collapse" id="navbarResponsive" style="">
                <ul class="navbar-nav text-uppercase ml-auto text-center">
                    <li class="nav-item dropdown">
                        <div class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Home</div>
                        <div id="" class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="<c:url value="/#ristorante-macelleria"/>">Chi Siamo</a>
                            <a class="dropdown-item" href="<c:url value="/#qualita-e-professionalita"/>">Qualità e Professionalità</a>
                            <a class="dropdown-item" href="<c:url value="/#i-nostri-servizi"/>">I Nostri Servizi</a>
                            <a class="dropdown-item" href="<c:url value="/#dicono-di-noi"/>">Dicono di Noi</a>
                            <a class="dropdown-item" href="<c:url value="/#raggiungici"/>">Raggiungici</a>
                            <a class="dropdown-item" href="<c:url value="/#contattaci"/>">Contattaci</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="/bottega.jsp"/>">Bottega Online</a>
                    </li>
                    <li class="nav-item dropdown">
                        <div class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">La Macelleria</div>
                        <div id="" class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="<c:url value="/macelleria.jsp"/>">Per iniziare</a>
                            <a class="dropdown-item" href="<c:url value="/macelleria.jsp#la-nostra-storia"/>">La nostra Storia</a>
                            <a class="dropdown-item" href="<c:url value="/macelleria.jsp#i-nostri-prodotti"/>">I Nostri Prodotti</a>
                            <a class="dropdown-item" href="<c:url value="/macelleria.jsp#raggiungici-macelleria"/>">Raggiungici</a>
                            <a class="dropdown-item" href="<c:url value="/macelleria.jsp#contattaci-macelleria"/>">Contattaci</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <div class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Il Ristorante</div>
                        <div id="" class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="<c:url value="/ristorante.jsp"/>">Per iniziare</a>
                            <a class="dropdown-item" href="<c:url value="/ristorante.jsp#menu"/>">Il Menù</a>
                            <a class="dropdown-item" href="<c:url value="/ristorante.jsp#materiePrime"/>">Le Materie Prime</a>
                            <a class="dropdown-item" href="<c:url value="/ristorante.jsp#raggiungici-ristorante"/>">Raggiungici</a>
                            <a class="dropdown-item" href="<c:url value="/ristorante.jsp#contattaci-ristorante"/>">Contattaci</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <div class="nav-link dropdown-toggle" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Blog & Idee</div>
                        <div id="" class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                            <a class="dropdown-item" href="<c:url value="/blog.jsp"/>">Il Blog</a>
                            <a class="dropdown-item" href="<c:url value="/idee.jsp"/>">Idee in cucina</a>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>

        <div id="notfound">

            <div class="notfound">
                <div class="notfound-404">
                    <h1>404</h1>
                </div>
                <h2>Ci dispiace, la pagina richiesta non è stata trovata</h2>
                <p>La pagina che hai cercato non esiste all'interno del nostro sito</p>
                <a href="<c:url value="/#"/>">Torna alla Homepage</a><br><br>
                <a href="<c:url value="/bottega.jsp"/>">Torna alla Bottega Online</a>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.7.2/js/all.js" integrity="sha384-0pzryjIRos8mFBWMzSSZApWtPl/5++eIfzYmTgBBmXYdhvxPc+XcFEk+zJwDgWbP" crossorigin="anonymous"></script>
        <script src="/Bortoleto/js/main.js" async></script>    
        <script src="/Bortoleto/js/nav.js"></script>
    </body>

</html>
