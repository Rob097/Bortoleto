<%-- 
    Document   : ricetta
    Created on : 18-apr-2019, 18.32.21
    Author     : Roberto97
--%>

<%@page import="database.daos.ProductDAO"%>
<%@page import="database.jdbc.JDBCProductDAO"%>
<%@page import="database.jdbc.JDBCRicetteDAO"%>
<%@page import="database.factories.DAOFactory"%>
<%@page import="database.entities.Ricetta"%>
<%@page import="database.daos.RicetteDAO"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="request" value="<%=request%>"/>
<c:set value="${ricettedao.getMostViewedRecipes()}" var="viewed" />
<c:set value="${ricettedao.getAllRecipes()}" var="ricette" />
<%
    /* Devo farlo perchè altrimenti facebook e google non vedono i parametri nei metadati e nel testo da quanto si usa l'url rewriting */
    DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
    if (daoFactory == null) {
        throw new ServletException("Impossible to get dao factory for user storage system");
    }
    RicetteDAO ricetteDAO = new JDBCRicetteDAO(daoFactory.getConnection());
    ProductDAO productDAO = new JDBCProductDAO(daoFactory.getConnection());

    Ricetta idea = ricetteDAO.getRecipeByName(request.getParameter("nome").replace("-", " "));
%>
<c:set value="<%=idea%>" var="ricetta" />
<c:set value="<%=ricetteDAO%>" var="ricettedao" />
<c:set value="<%=productDAO%>" var="productdao" />
<c:choose>
    <c:when test="${param.id ne null && param.nome ne null && param.id ne '' && param.nom ne '' && param.nome eq ricettedao.getRecipe(param.id).nome.replace(' ', '-')}">
        <c:set value="${ricettedao.getComments(ricetta.id)}" var="commenti" />
        ${ricettedao.incrementViews(ricetta.id, ricetta.views, request)}
        ${consoledao.incrementViews("idee", request, param.id)}
    </c:when>
    <c:otherwise>
        <c:set value="${null}" var="ricetta" />
    </c:otherwise>
</c:choose>
<!DOCTYPE html>
<html lang="en">
    <head>

        <!-- Global site tag (gtag.js) - Google Analytics -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=UA-156001507-1"></script>
        <script>
            window.dataLayer = window.dataLayer || [];
            function gtag() {
                dataLayer.push(arguments);
            }
            gtag('js', new Date());

            gtag('config', 'UA-156001507-1');
        </script>
        <!-- Markup JSON-LD generato da Assistente per il markup dei dati strutturati di Google. -->
        <script type="application/ld+json">
            {
            "@context" : "http://schema.org",
            "@type" : "Recipe",
            "name" : "${ricetta.nome}",
            "author" : {
            "@type" : "Person",
            "name" : "${ricetta.creatore}"
            },
            "datePublished" : "${ricetta.data.toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-yy"))}",
            "image" : "/${ricetta.immagine}",
            "recipeInstructions": [
            {
            "@type": "HowToStep",
            "text": "${ricetta.descrizione}"
            }
            ],
            "description": "${ricetta.descrizione}",
            "recipeCuisine": "Italiana",
                
            <c:set var="AllProdsOfIdea" value="${ricettedao.getAllProdsOfIdea(ricetta.id)}"/>
            <c:if test="${!AllProdsOfIdea.isEmpty()}">
                "keywords": [
                <c:set var="size" value="${0}"/>
                <c:forEach items="${AllProdsOfIdea}" var="idProd">                    
                    <c:set var="size" value="${size + 1}"/>
                    <c:set var="prod" value="${productdao.getProduct(idProd)}"/>
                    "${prod.nome}"<c:if test="${size < AllProdsOfIdea.size()}">,</c:if>
                </c:forEach>
                ],
            </c:if>
                
            <c:if test="${ricetta.ingredienti ne null && !ricetta.ingredienti.isEmpty() && !ricetta.ingredienti.get(0).equals('')}">
                "recipeIngredient": [
                <c:set var="size" value="${0}"/>
                <c:forEach items="${ricetta.ingredienti}" var="ingrediente">                    
                    <c:set var="size" value="${size + 1}"/>
                    "${ingrediente}"<c:if test="${size < ricetta.ingredienti.size()}">,</c:if>
                </c:forEach>
                ],
            </c:if>
            
            "url" : "https://macelleriadellantonio.it/Bortoleto/idea/${ricetta.id}/${ricetta.nome.replace(" ", "-")}",
            "aggregateRating" : {
            "@type" : "AggregateRating",
            "ratingValue" : "${ricettedao.getRate(ricetta.id)}",
            "ratingCount" : "${ricettedao.getNumberRate(ricetta.id)}"
            },
            "totalTime": "${ricetta.getTempoFormat()}"
            }
        </script>

        <meta property="og:url"           content="https://macelleriadellantonio.it<c:url value="/idea.jsp?id=${ricetta.id}&nome=${ricetta.nome.replace(' ', '-')}"/>" />
        <meta property="og:type"          content="website" />
        <meta property="og:title"         content="${ricetta.nome} | Bortoleto" />
        <meta property="og:description"   content="${ricetta.meta_descrizione}" />
        <meta property="og:image"         content="https://www.macelleriadellantonio.it/console/${ricetta.immagine}" />
        <meta property="fb:app_id"         content="320307085338651" />

        <link rel="icon" href="/Bortoleto/img/favicon.ico" sizes="16x16" >
        <title>${ricetta.nome} | Bortoleto</title>
        <meta name="Description" content="${ricetta.meta_descrizione}">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="theme-color" content="#31353d">        

        <!-- bootstrap include -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="/Bortoleto/css/mdb.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
        <!-- fine bootstrap include -->

        <!--include css -->
        <link rel="stylesheet" href="/Bortoleto/css/Cards-min.css" type="text/css">
        <link rel="stylesheet" href="/Bortoleto/css/style-min.css">
        <link rel="stylesheet" href="/Bortoleto/css/prodotto-min.css">
        <link rel="stylesheet" href="/Bortoleto/css/parallax.css">
        <link rel="stylesheet" href="/Bortoleto/css/font-min.css">
        <link rel="stylesheet" href="/Bortoleto/css/blog-min.css">
        <link rel="stylesheet" href="/Bortoleto/css/vari-min.css">
        <link rel="stylesheet" href="/Bortoleto/css/navbar-min.css">
        <!-- fine include css -->    
        <style>
            body{
                overflow-x: visible;
            }
            .container1 {
                position: relative;
                width: 80%;
                margin: auto auto;
            }

            .image1 {
                display: block;
                width: 100%;
                height: auto;
            }

            .overlay1 {
                position: absolute;
                top: 0;
                bottom: 0;
                left: 0;
                right: 0;
                height: inherit;
                width: 100%;
                opacity: 1;
                transition: .5s ease;
                background-color: rgba(0, 0, 0, 0.35);
            }

            .text1 {
                color: white;
                font-size: 20px;
                position: absolute;
                top: 50%;
                left: 50%;
                -webkit-transform: translate(-50%, -50%);
                -ms-transform: translate(-50%, -50%);
                transform: translate(-50%, -50%);
                text-align: center;
            }
            @media (min-width: 1200px){
                .container {
                    max-width: 1500px;
                }
            }
            @media (min-width: 992px) and (max-width: 1199px){
                .container {
                    max-width: 1100px;
                }
            }
            @media (min-width: 768px) and (max-width: 991px){
                .container {
                    max-width: 950px;
                }
            }
            @media (min-width: 576px) and (max-width: 767px){
                .container {
                    max-width: 650px;
                }
            }
        </style>
        <script type="text/javascript">
            var _iub = _iub || [];
            _iub.csConfiguration = {"lang": "it", "siteId": 1636253, "cookiePolicyId": 77217510, "cookiePolicyUrl": "https://macelleriadellantonio.it/Bortoleto/file/PrivacyPolicy.pdf", "banner": {"acceptButtonDisplay": true, "customizeButtonDisplay": true, "position": "float-bottom-center", "consentOnScroll": true}};
        </script><script type="text/javascript" src="//cdn.iubenda.com/cs/iubenda_cs.js" charset="UTF-8" async></script>
        <!-- Facebook Pixel Code -->
        <script>
            !function (f, b, e, v, n, t, s)
            {
                if (f.fbq)
                    return;
                n = f.fbq = function () {
                    n.callMethod ?
                            n.callMethod.apply(n, arguments) : n.queue.push(arguments)
                };
                if (!f._fbq)
                    f._fbq = n;
                n.push = n;
                n.loaded = !0;
                n.version = '2.0';
                n.queue = [];
                t = b.createElement(e);
                t.async = !0;
                t.src = v;
                s = b.getElementsByTagName(e)[0];
                s.parentNode.insertBefore(t, s)
            }(window, document, 'script',
                    'https://connect.facebook.net/en_US/fbevents.js');
            fbq('init', '467659847403449');
            fbq('track', 'PageView');
        </script>
    <noscript><img height="1" width="1" style="display:none" src="https://www.facebook.com/tr?id=467659847403449&ev=PageView&noscript=1"/></noscript>
    <!-- End Facebook Pixel Code -->
</head>
<body class="foo white-text" id="topPage" data-spy="scroll" data-target=".sidebar" style='background-color: white;'>
    <a style="bottom: 20px;" href="#topPage" id="myBtn45" title="Torna in cima" class="rightGray"><i class="fas fa-angle-up"></i></a>

    <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            Menu
            <i class="fa fa-bars"></i>
        </button>
        <a id="nav-logo-img" class="navbar-brand" href="<c:url value="/#Bortoleto"/>">
            <img width="90vh" src="/Bortoleto/img/logo2.png" alt="Logo">
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
                        <a class="dropdown-item" href="<c:url value="/macelleria.jsp#"/>">Per iniziare</a>
                        <a class="dropdown-item" href="<c:url value="/macelleria.jsp#la-nostra-storia"/>">La nostra Storia</a>
                        <a class="dropdown-item" href="<c:url value="/macelleria.jsp#i-nostri-prodotti"/>">I Nostri Prodotti</a>
                        <a class="dropdown-item" href="<c:url value="/macelleria.jsp#raggiungici-macelleria"/>">Raggiungici</a>
                        <a class="dropdown-item" href="<c:url value="/macelleria.jsp#contattaci-macelleria"/>">Contattaci</a>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <div class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Il Ristorante</div>
                    <div id="" class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="<c:url value="/ristorante.jsp#"/>">Per iniziare</a>
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

    <!--####################################################################
    INIZIO CONTENUTO
    #####################################################################-->
    <div id="parallaxN2" class="imgPara image-liquid image-holder--original parallax-window" data-parallax="scroll" data-image-src="/console/img/ico/meat-background.jpg">
        <div class="effetto1">
            <div style="height: 30rem;">
                <div class="container cPara" style="">
                    <div class="customPaddingPara">
                        <h2 class="customStylePara">Le idee de 'l Bortoleto</h2>
                    </div>
                </div>
                <div class="scrollIcon">
                    <a style="color: white;" href="#ricetta" aria-label="Scorri in basso"><i class="fas fa-chevron-down"></i></a>
                    <h5>Scorri</h5>
                </div>
            </div>
        </div>
    </div>

    <section class="post-content-area single-post-area" id="ricetta">
        <div class='container'>
            <div class="row mt-5">
                <div class="col-lg-8 posts-list">
                    <c:choose>
                        <c:when test="${empty param.id || ricetta == null}">
                            <div class="text-center mt-5 mb-5 container">
                                <i style="color: #ff3547;" class="far fa-frown fa-4x mb-3 animated rotateIn"></i>
                                <h3 style="margin-top: 2rem; color: black;">Non abbiamo trovato quello che stai cercando</h3>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <nav id="breadcrumb">
                                <ol class="cd-breadcrumb custom-separator" itemscope itemtype="https://schema.org/BreadcrumbList">
                                    <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                        <a itemprop="item" href="<c:url value="/#Bortoleto"/>"><span itemprop="name">Home</span></a>
                                        <meta itemprop="position" content="1" />
                                    </li>
                                    <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                        <a itemprop="item" href="<c:url value="/idee.jsp"/>"><span itemprop="name">Idee in Cucina</span></a>
                                        <meta itemprop="position" content="2" />
                                    </li>
                                    <li class="current" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                        <a href="<c:url value="/idea.jsp?id=${ricetta.id}&nome=${ricetta.nome.replace(' ','-')}"/>" itemprop="item" ><em><span itemprop="name">${ricetta.nome}</span></em></a>
                                        <meta itemprop="position" content="3" />
                                    </li>
                                </ol>
                            </nav>
                            <div class="single-post row">
                                <div class="col-lg-3  col-md-3 meta-details container-sticky" style="text-align: right;  margin-top: 35px;">
                                    <div class="sticky-top visible-md" style="top: 6rem;padding-top:5rem;">
                                        <ul class="tags realTags key black-text textOverflow">
                                            <c:forEach items="${ricettedao.getAllProdsOfIdea(ricetta.id)}" var="tag" >
                                                <c:set var="prodIdea" value="${productdao.getProduct(tag)}" />
                                                <li>
                                                    <a class="tagLink" href="<c:url value="/idee.jsp?prod=${prodIdea.id}&nome=${prodIdea.nome.replace(' ', '-')}"/>">#${StringUtils.capitalize(prodIdea.nome.toLowerCase())}</a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                        <div class="user-details row">
                                            <p style="padding-left: 0px;" class="personalized user-name col-lg-12 col-md-12 col-6">${ricetta.getTempoFormat()}<i class="far fa-clock ml-2" style="color: black;"></i></p>
                                            <p style="padding-left: 0px;" class="personalized user-name col-lg-12 col-md-12 col-6">${ricetta.difficolta}<i class="far fa-smile ml-2" style="color: black;"></i></p> 
                                            <p style="padding-left: 0px;" class="personalized user-name col-lg-12 col-md-12 col-6">${ricetta.creatore}<i class="far fa-user ml-2" style="color: black;"></i></p>
                                            <p style="padding-left: 0px;" class="right-small personalized date col-lg-12 col-md-12 col-6">${ricetta.data.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))}<i class="far fa-calendar-alt ml-2" style="color: black;"></i></p>                                            
                                            <p style="padding-left: 0px;" class="personalized comments col-lg-12 col-md-12 col-6"><a href="#commenti">${commenti.size()} Commenti</a> <i class="far fa-comment" style="color: black;"></i></p>
                                            <p style="padding-left: 0px;" class="right-small personalized view col-lg-12 col-md-12 col-6">${ricetta.views} Letture<i class="far fa-eye ml-2" style="color: black;"></i></p>
                                            <ul class="social-links col-lg-12 col-md-12 col-12 center-small">
                                                <li><a aria-label="Condividi su Facebook" target="_blank" rel="noopener" href="https://www.facebook.com/dialog/share?app_id=320307085338651&display=popup&href=https://macelleriadellantonio.it/<c:url value="/idea.jsp?id=${ricetta.id}&nome=${ricetta.nome.replace(' ', '-')}"/>&redirect_uri=https://macelleriadellantonio.it/<c:url value="/idea.jsp?id=${ricetta.id}&nome=${ricetta.nome.replace(' ', '-')}"/>"><i class="fab fa-facebook-f overGold"></i></a></li>
                                                <li><a aria-label="Condividi su Twitter" target="_blank" rel="noopener" href="https://twitter.com/intent/tweet?url=https://macelleriadellantonio.it/<c:url value="/idea.jsp?id=${ricetta.id}&nome=${ricetta.nome.replace(' ', '-')}"/>&text=${ricetta.nome}"><i class="fab fa-twitter overGold"></i></a></li>
                                            </ul>
                                            <div id="ratingDiv" class="no-padding mb-5 personalized center-small col-lg-12 col-md-12 col-12">
                                                <c:set var="rate" value="${ricettedao.getRate(ricetta.id)}" />
                                                <label class="text-muted">${ricettedao.getNumberRate(ricetta.id)} valutazioni (${rate} <i class="far fa-star"></i>)</label><br>
                                                <fieldset class="rating text-center" style="display: initial;">
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star5" name="rating" value="5" <c:if test="${rate >= 5}">checked</c:if> /><label class = "full" for="star5" title="5 stelle"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star4half" name="rating" value="4.5" <c:if test="${rate >= 4.5 && rate < 5}">checked</c:if>/><label class="half" for="star4half" title="4.5 stelle"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star4" name="rating" value="4" <c:if test="${rate >= 4 && rate < 4.5}">checked</c:if>/><label class = "full" for="star4" title="4 stelle"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star3half" name="rating" value="3.5" <c:if test="${rate >= 3.5 && rate < 4}">checked</c:if>/><label class="half" for="star3half" title="3.5 stelle"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star3" name="rating" value="3" <c:if test="${rate >= 3 && rate < 3.5}">checked</c:if>/><label class = "full" for="star3" title="3 stelle"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star2half" name="rating" value="2.5" <c:if test="${rate >= 2.5 && rate < 3}">checked</c:if>/><label class="half" for="star2half" title="2.5 stelle"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star2" name="rating" value="2" <c:if test="${rate >= 2 && rate < 2.5}">checked</c:if>/><label class = "full" for="star2" title="2 stelle"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star1half" name="rating" value="1.5" <c:if test="${rate >= 1.5 && rate < 2}">checked</c:if>/><label class="half" for="star1half" title="1.5 stelle"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star1" name="rating" value="1" <c:if test="${rate >= 1 && rate < 1.5}">checked</c:if>/><label class = "full" for="star1" title="1 stella"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="starhalf" name="rating" value="0.5" <c:if test="${rate >= 0.5 && rate < 1}">checked</c:if>/><label class="half" for="starhalf" title="0.5 stelle"></label>
                                                    </fieldset><br>                                
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-9 col-md-9 black-text img-margin-bottom-large">
                                        <h1 class="textOverflow personalized mt-20 mb-15" style="min-height: fit-content; margin-top: 0px; margin-bottom: 23px; padding: 0px; font-family: Montserrat, sans-serif; font-weight: 800; font-size: 45px; color: rgb(74, 74, 74);">${ricetta.nome}</h1><br>
                                    <div class="feature-img" style="text-align: center;">
                                        <img class="img-fluid" src="/${ricetta.immagine}" alt="${ricetta.nome}" style="max-height: 500px; border-radius: 10px; box-shadow: 0px 0px 30px rgba(0, 0, 0, 0.64);">
                                    </div>
                                    <div class="invisible-md" style="margin-top: 3rem;">
                                        <ul class="tags realTags key black-text textOverflow">
                                            <c:forEach items="${ricettedao.getAllProdsOfIdea(ricetta.id)}" var="tag" >
                                                <c:set var="prodIdea" value="${productdao.getProduct(tag)}" />
                                                <li>
                                                    <a class="tagLink" href="<c:url value="/idee.jsp?prod=${prodIdea.id}&nome=${prodIdea.nome.replace(' ', '-')}"/>">#${StringUtils.capitalize(prodIdea.nome.toLowerCase())}</a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                        <div class="user-details row">
                                            <p style="padding-left: 0px;" class="personalized user-name col-lg-12 col-md-12 col-6">${ricetta.getTempoFormat()}<i class="far fa-clock ml-2" style="color: black;"></i></p>
                                            <p style="padding-left: 0px;" class="personalized user-name col-lg-12 col-md-12 col-6">${ricetta.difficolta}<i class="far fa-smile ml-2" style="color: black;"></i></p> 
                                            <p style="padding-left: 0px;" class="personalized user-name col-lg-12 col-md-12 col-6">${ricetta.creatore}<i class="far fa-user ml-2" style="color: black;"></i></p>
                                            <p style="padding-left: 0px;" class="right-small personalized date col-lg-12 col-md-12 col-6">${ricetta.data.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))}<i class="far fa-calendar-alt ml-2" style="color: black;"></i></p>                                            
                                            <p style="padding-left: 0px;" class="personalized comments col-lg-12 col-md-12 col-6"><a href="#commenti">${commenti.size()} Commenti</a> <i class="far fa-comment" style="color: black;"></i></p>
                                            <p style="padding-left: 0px;" class="right-small personalized view col-lg-12 col-md-12 col-6">${ricetta.views} Letture<i class="far fa-eye ml-2" style="color: black;"></i></p>
                                            <ul class="social-links col-lg-12 col-md-12 col-12 center-small">
                                                <li><a aria-label="Condividi su Facebook" target="_blank" rel="noopener" href="https://www.facebook.com/dialog/share?app_id=320307085338651&display=popup&href=https://macelleriadellantonio.it/<c:url value="/idea.jsp?id=${ricetta.id}&nome=${ricetta.nome.replace(' ', '-')}"/>&redirect_uri=https://macelleriadellantonio.it/<c:url value="/idea.jsp?id=${ricetta.id}&nome=${ricetta.nome.replace(' ', '-')}"/>"><i class="fab fa-facebook-f overGold"></i></a></li>
                                                <li><a aria-label="Condividi su Twitter" target="_blank" rel="noopener" href="https://twitter.com/intent/tweet?url=https://macelleriadellantonio.it/<c:url value="/idea.jsp?id=${ricetta.id}&nome=${ricetta.nome.replace(' ', '-')}"/>&text=${ricetta.nome}"><i class="fab fa-twitter overGold"></i></a></li>
                                            </ul>
                                            <div id="ratingDiv" class="no-padding mb-5 personalized center-small col-lg-12 col-md-12 col-12">
                                                <c:set var="rate" value="${ricettedao.getRate(ricetta.id)}" />
                                                <label class="text-muted">${ricettedao.getNumberRate(ricetta.id)} valutazioni (${rate} <i class="far fa-star"></i>)</label><br>
                                                <fieldset class="rating text-center" style="display: initial;">
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star5" name="rating" value="5" <c:if test="${rate >= 5}">checked</c:if> /><label class = "full" for="star5" title="5 stelle"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star4half" name="rating" value="4.5" <c:if test="${rate >= 4.5 && rate < 5}">checked</c:if>/><label class="half" for="star4half" title="4.5 stelle"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star4" name="rating" value="4" <c:if test="${rate >= 4 && rate < 4.5}">checked</c:if>/><label class = "full" for="star4" title="4 stelle"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star3half" name="rating" value="3.5" <c:if test="${rate >= 3.5 && rate < 4}">checked</c:if>/><label class="half" for="star3half" title="3.5 stelle"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star3" name="rating" value="3" <c:if test="${rate >= 3 && rate < 3.5}">checked</c:if>/><label class = "full" for="star3" title="3 stelle"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star2half" name="rating" value="2.5" <c:if test="${rate >= 2.5 && rate < 3}">checked</c:if>/><label class="half" for="star2half" title="2.5 stelle"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star2" name="rating" value="2" <c:if test="${rate >= 2 && rate < 2.5}">checked</c:if>/><label class = "full" for="star2" title="2 stelle"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star1half" name="rating" value="1.5" <c:if test="${rate >= 1.5 && rate < 2}">checked</c:if>/><label class="half" for="star1half" title="1.5 stelle"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="star1" name="rating" value="1" <c:if test="${rate >= 1 && rate < 1.5}">checked</c:if>/><label class = "full" for="star1" title="1 stella"></label>
                                                    <input onclick="rate($(this).val(), ${ricetta.id});" type="radio" id="starhalf" name="rating" value="0.5" <c:if test="${rate >= 0.5 && rate < 1}">checked</c:if>/><label class="half" for="starhalf" title="0.5 stelle"></label>
                                                    </fieldset><br>                                
                                                </div>
                                            </div>
                                        </div>
                                    <c:if test="${ricetta.ingredienti ne null && !ricetta.ingredienti.isEmpty() && !ricetta.ingredienti.get(0).equals('')}">
                                        <div class="comments-area" style="box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.17);; padding-bottom: 0; margin-top: 30px;">
                                            <h6><i>Cosa usare:</i></h6>
                                            <p class="personalized excert">
                                                <c:forEach items="${ricetta.ingredienti}" var="ingrediente">
                                                <p><i class="fas fa-check mr-2 ml-4" style="color: rgba(8, 105, 8, 0.72);"></i>${ingrediente}</p>
                                                </c:forEach>
                                            </p><br>
                                        </div>
                                    </c:if>
                                    <h5 class="mt-5"><i>Cosa fare</i></h5>
                                    <div class="personalized excert description" style="overflow-wrap: break-word;">
                                        ${ricetta.procedimento}
                                    </div>
                                </div>
                            </div>


                            <c:if test="${!ricettedao.getAllProdsOfIdea(ricetta.id).isEmpty()}">
                                <!-- Prodotti legati all'idea -->
                                <h4 class="Cherry_Swash center15 black-text">Quello che abbiamo usato</h4>
                                <div id="carousel-example-multi1" class="carousel slide carousel-multi-item v-2 white-text" data-ride="carousel">
                                    <div class="carousel-inner" role="listbox" style="overflow-y: hidden; overflow-x: scroll;">
                                        <div style="margin-top: 1.5rem; display: inline-flex;" class="carousel-item active">
                                            <c:forEach items="${ricettedao.getAllProdsOfIdea(ricetta.id)}" var="prod" >
                                                <c:set var="ricettaProd" value="${productdao.getProduct(prod)}" />
                                                <div class="col-md-4 zoomSlide">
                                                    <a data-toggle="tooltip" title="Acquista ${ricettaProd.nome}" target="_blank" rel="noopener" href="<c:url value="/prodotto.jsp?id=${ricettaProd.id}&nome=${ricettaProd.nome.replace(' ', '-')}&cat=${ricettaProd.categoria.replace(' ', '-')}" />">
                                                        <div class="card mb-2" style="border-radius: 5%;">
                                                            <div class="image-liquid image-holder--original card-img-top lazy" data-src="/${ricettaProd.immagine}" style="height: 15rem;" alt="${ricettaProd.nome}">
                                                                <div class="overlay1">
                                                                    <div class="text1"><i class="fas fa-cart-plus" style="font-size: 3rem;"></i></div>
                                                                </div>
                                                            </div>                                            
                                                            <div class="card-body">
                                                                <h4 class="card-title font-weight-bold black-text">${ricettaProd.nome}</h4>
                                                            </div>
                                                        </div>
                                                    </a>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <c:set var="blogs" value="${blogdao.getBlogsOfIdeaProd(ricetta.id, request)}" />
                            <c:if test="${blogs ne null && !blogs.isEmpty()}">
                                <h4 class="Cherry_Swash center15 black-text" style='margin-top: 5rem;'>Approfondisci l'argomento con un po' di cultura</h4>
                                <div id="carousel-example-multi" class="carousel slide carousel-multi-item v-2 white-text" data-ride="carousel">
                                    <div class="carousel-inner" role="listbox" style="overflow-y: hidden; overflow-x: scroll;">                                        
                                        <div style="margin-top: 1.5rem; display: inline-flex;" class="carousel-item active">
                                            <c:forEach items="${blogs}" var="blog" >
                                                <div class="col-md-4 zoomSlide">
                                                    <a target="blank" href="<c:url value="/articolo.jsp?id=${blog.id}&nome=${blog.nome.replace(' ', '-')}"/>">
                                                        <div class="card mb-2" style="border-radius: 5%;">
                                                            <div class="image-liquid image-holder--original card-img-top lazy" data-src="/${blog.immagine}" style="height: 15rem;" alt="${blog.nome}"></div>                                            
                                                            <div class="card-body">
                                                                <h4 class="card-title font-weight-bold black-text">${blog.nome}</h4>
                                                            </div>
                                                        </div>
                                                    </a>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <hr class="mt-5 mb-5" style="border: 3px solid rgb(121, 85, 72); width: 50%; border-radius: 100%;">
                            </c:if>

                            <div class="navigation-area">
                                <div class="row">
                                    <c:set value="${ricettedao.getRecipe(param.id - 1)}" var="prev" />
                                    <div class="col-lg-6 col-md-6 col-12 nav-left flex-row d-flex justify-content-start align-items-center">
                                        <c:if test="${prev != null}">                                            
                                            <div class="thumb">
                                                <a href="<c:url value="/idea.jsp?id=${prev.id}&nome=${prev.nome.replace(' ', '-')}"/>"><img style="width: 150px;" class="lazy img-fluid" data-src="/${prev.immagine}" alt="${prev.nome}"></a>
                                            </div>
                                            <div class="detials">
                                                <p class="personalized">Precedente</p>
                                                <a href="<c:url value="/idea.jsp?id=${prev.id}&nome=${prev.nome.replace(' ', '-')}"/>">
                                                    <h4 class="personalized">${prev.nome}</h4>
                                                </a>
                                            </div>                                            
                                        </c:if>
                                    </div>
                                    <c:set value="${ricettedao.getRecipe(param.id + 1)}" var="next" />
                                    <div class="col-lg-6 col-md-6 col-12 nav-right flex-row d-flex justify-content-end align-items-center">
                                        <c:if test="${next != null}">                                            
                                            <div class="detials">
                                                <p class="personalized">Successiva</p>
                                                <a href="<c:url value="/idea.jsp?id=${next.id}&nome=${next.nome.replace(' ', '-')}"/>">
                                                    <h4 class="personalized">${next.nome}</h4>
                                                </a>
                                            </div>
                                            <div class="thumb">
                                                <a href="<c:url value="/idea.jsp?id=${next.id}&nome=${next.nome.replace(' ', '-')}"/>"><img style="width: 150px;" class="lazy img-fluid" data-src="/${next.immagine}" alt="${next.immagine}"></a>
                                            </div>                                            
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <div class="comments-area" id="commenti">
                                <h4 class="personalized">${commenti.size()} Commenti</h4>
                                <div class="comment-list">
                                    <c:forEach items="${commenti}" var="commento" >
                                        <div class="single-comment justify-content-between d-flex">
                                            <div class="user justify-content-between d-flex">
                                                <div class="desc">
                                                    <h5 class="personalized"><a href="#">${commento.nome}</a></h5>
                                                    <p class="personalized date">${commento.data.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm"))}</p>
                                                    <p class="personalized comment">
                                                        ${commento.testo}
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="comment-form">
                                <h4 class="personalized mb-3">Lascia un commento</h4>
                                <form method="POST" action="/Bortoleto/postRicettaComment">
                                    <div class="form-group">
                                        <label class="black-text" for="nome">Nome</label>
                                        <input type="text" class="form-control" id="nome" name="nome" placeholder="Il tuo nome" required>
                                    </div>
                                    <div class="form-group">
                                        <label class="black-text" for="commento">Commento</label>
                                        <textarea class="form-control mb-10" rows="5" id="commento" name="commento" placeholder="Commento" required></textarea>
                                    </div>
                                    <input type="hidden" name="idRicetta" value="${ricetta.id}">
                                    <input type="hidden" name="titoloRicetta" value="${ricetta.nome.replace(' ', '-')}">
                                    <hr style="border: 3px solid rgb(121, 85, 72); width: 50%; border-radius: 100%;"/>
                                    <div id="recaptcha"><div class="g-recaptcha" data-sitekey="6Ld8YaAUAAAAAKDIu30P3tuRfUuPw-XgFHd9_J5U" data-callback="enableBtn"></div></div>
                                    <input id="postButton" type="submit" class="btn primary-btn" value="PUBBLICA COMMENTO" disabled>
                                </form>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-lg-4 sidebar-widgets">
                    <div class="widget-wrap">
                        <div class="single-sidebar-widget black-text">
                            <a href="<c:url value="/idee.jsp#ricette"/>"><h4><i class="fas fa-arrow-left mr-2"></i>Torna indietro</h4></a>
                        </div>
                        <div class="single-sidebar-widget search-widget">
                            <form class="search-form" action="<c:url value="/idee.jsp#ricetta"/>" method="get">
                                <input id="myInput2" class="search_input" type="text" placeholder="Cerca..." name="search">
                                <button type="submit"><i class="fas fa-search"></i></button>
                            </form>
                        </div>
                        <c:if test="${!viewed.isEmpty()}">
                            <div class="single-sidebar-widget popular-post-widget">
                                <h4 class="personalized popular-title">Idee più lette</h4>
                                <div class="popular-post-list">
                                    <c:forEach items="${viewed}" var="v" >
                                        <div class="single-post-list d-flex flex-row align-items-center">
                                            <div class="thumb">
                                                <img style="width: 150px;" class="lazy img-fluid" data-src="/${v.immagine}" alt="${v.nome}">
                                            </div>
                                            <div class="details">
                                                <a href="<c:url value="/idea.jsp?id=${v.id}&nome=${v.nome.replace(' ', '-')}"/>">
                                                    <h6>${v.nome}</h6>
                                                </a>
                                                <p class="personalized">${v.data.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))}</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                        <div class="single-sidebar-widget post-category-widget">
                            <h4 class="category-title">Categorie</h4>
                            <ul class="cat-list">
                                <li>
                                    <a href="<c:url value="/idee.jsp"/>" class="d-flex justify-content-between">
                                        <p>Tutte</p>
                                        <p>${ricette.size()}</p>
                                    </a>
                                </li>
                                <li>
                                    <a href="<c:url value="/idee.jsp?cat=1" />" class="d-flex justify-content-between">
                                        <p>Le nostre idee</p>
                                        <p>${ricettedao.getTypeSize('1')}</p>
                                    </a> 
                                </li>
                                <li>
                                    <a href="<c:url value="/idee.jsp?cat=2" />" class="d-flex justify-content-between">
                                        <p>Le vostre idee</p>
                                        <p>${ricettedao.getTypeSize('2')}</p>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <c:if test="${!ricettedao.getAllProdottiIdea().isEmpty()}">
                            <div class="single-sidebar-widget tag-cloud-widget">
                                <h4 class="tagcloud-title">Tags</h4>
                                <ul>
                                    <c:forEach items="${ricettedao.getAllProdottiIdea()}" var="tag" >
                                        <c:set var="prodIdea" value="${productdao.getProduct(ricettedao.getProdFormProdIdea(tag))}" />
                                        <li>
                                            <a href="<c:url value="/idee.jsp?prod=${prodIdea.id}&nome=${prodIdea.nome.replace(' ', '-')}"/>">${StringUtils.capitalize(prodIdea.nome.toLowerCase())}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:if>
                        <div class="single-sidebar-widget newsletter-widget">
                            <h4 class="newsletter-title">Newsletter</h4>
                            <p>
                                Resta sempre aggiornato sui nuovi articoli del blog e su tutte le interessanti idee per la cucina che verranno aggiunte da noi o da VOI! 
                            </p>
                            <form method="POST" id="emailSubscribe2">
                                <div class="form-group d-flex flex-row">
                                    <div class="col-autos">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text"><i class="fa fa-envelope" aria-hidden="true"></i>
                                                </div>
                                            </div>
                                            <input type="email" class="form-control" id="emailSub2" name='email' placeholder="La tua email"/>
                                        </div>
                                    </div>
                                    <input type="submit" id="sendButtonSubB2" class="bbtns" value="Iscriviti">
                                    <div class="status" id="statusSub2" style='color: black;'></div>
                                    <div class="spinner-border text-success invisible marginAuto" id="loadingSub2" role="status">
                                        <span class="sr-only">Loading...</span>
                                    </div>
                                </div>
                            </form>
                            <p class="text-bottom">
                                Puoi rimuovere l'iscrizione in qualsiasi momento!<br>
                                <span>(<a href="/Bortoleto/subscribe/unSubscribe.jsp" target="_blank">Disiscrivimi</a>)</span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<footer id="footer" class="container-fluid text-center">

</footer>


<!--####################################################################
FINE CONTENUTO -- INIZIO MODALI
#####################################################################-->
<!-- MODAL -->
<!-- FINE MODAL -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script defer src="https://use.fontawesome.com/releases/v5.7.2/js/all.js" integrity="sha384-0pzryjIRos8mFBWMzSSZApWtPl/5++eIfzYmTgBBmXYdhvxPc+XcFEk+zJwDgWbP" crossorigin="anonymous"></script>
<!-- MDB core JavaScript -->
<script src="/Bortoleto/js/parallax.js"></script>
<script type="text/javascript" src="/Bortoleto/js/mdb.min.js">async;</script>
<script src="/Bortoleto/js/vari-min.js" async></script>
<script src="/Bortoleto/js/modernizr-min.js" async></script>
<script src="/Bortoleto/js/main-min.js" async></script>  
<script src="/Bortoleto/js/nav.js"></script>    
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script type="text/javascript" src="/Bortoleto/js/jquery.lazy.min.js"></script> 
<script>
</script>
<script>
    // When the user scrolls down 20px from the top of the document, show the button
    window.onscroll = function () {
        scrollFunction();
    };

    function scrollFunction() {
        if (document.body.scrollTop > 400 || document.documentElement.scrollTop > 400) {
            document.getElementById("myBtn45").style.display = "block";
        } else {
            document.getElementById("myBtn45").style.display = "none";
        }
    }
</script>
<script>
    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id))
            return;
        js = d.createElement(s);
        js.id = id;
        js.src = "https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.0";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
</script>
<script>
    function enableBtn() {
        document.getElementById("postButton").disabled = false;
    }
</script>
<script>
    //Rate Ricetta
    function rate(val, ricetta) {
        $.ajax({
            type: "POST",
            url: "/Bortoleto/rateRicetta",
            data: {ricetta: ricetta, val: val},
            cache: false,
            success: function (dt, status, request) {
                if (request.getResponseHeader('already_' + ricetta) === null || request.getResponseHeader('already_' + ricetta) !== "true") {
                    $('#ratingDiv').html("<h4 class='black-text text-center' style='font-family: \"Coming Soon\";'>Grazie per il tuo parere</h4>");
                } else {
                    $('#ratingDiv').html("<h4 class='black-text text-center' style='font-family: \"Coming Soon\";'>Grazie, ma ci hai già fornito il tuo parere per questa idea</h4>");
                }
            },
            error: function () {
                alert("Errore rate ricetta");
            }
        });
    }
</script>
<script>
    $("#emailSubscribe2").on("submit", function () {
        event.preventDefault();
        var email = "";
        if ($('#emailSub2').val() !== undefined) {
            email = $('#emailSub2').val();
        }
        $('#sendButtonSubB2').remove();
        $('#loadingSub2').removeClass("invisible");
        $.ajax({
            type: "POST",
            url: "emailSub",
            data: {email: email},
            cache: false,
            success: function (response) {
                $('#statusSub2').html("<h2>Ottimo!</h2>");
                $('#loadingSub2').addClass("invisible");
            },
            error: function () {
                $('#statusSub2').html("<h2>Ouch! Qualcosa è andato storto. Riprova tra qualche minuto, o scrivi a <a href='mailto:info@macelleriadellantonio.it'><i>info@macelleriadellantonio.it</i></a></h2>");
                $('#loadingSub2').addClass("invisible");
            }
        });
    });
</script>
<script>
    /* footer */
    $(function () {
        $("#footer").load("/Bortoleto/ajax/footer.html");
    });

    /* navbar */
    $(function () {
        $("#main-nav").load("/Bortoleto/ajax/navbar.html");
    });

    $(function () {
        $('.lazy').lazy();
    });
</script>
<!-- Twitter universal website tag code -->
<script>
    !function (e, t, n, s, u, a) {
        e.twq || (s = e.twq = function () {
            s.exe ? s.exe.apply(s, arguments) : s.queue.push(arguments);
        }, s.version = '1.1', s.queue = [], u = t.createElement(n), u.async = !0, u.src = '//static.ads-twitter.com/uwt.js',
                a = t.getElementsByTagName(n)[0], a.parentNode.insertBefore(u, a))
    }(window, document, 'script');
    // Insert Twitter Pixel ID and Standard Event data below
    twq('init', 'o2zav');
    twq('track', 'PageView');
</script>
<!-- End Twitter universal website tag code -->
</body>
</html>
