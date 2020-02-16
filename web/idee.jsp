<%-- 
    Document   : blog
    Created on : 7-apr-2019, 15.28.17
    Author     : Roberto97
--%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="request" value="<%=request%>"/>
<c:set var="response" value="<%=response%>"/>
<c:set value="${ricettedao.getAllRecipes()}" var="ricette" />
<c:set value="${ricettedao.getMostViewedRecipes()}" var="viewed" />
<c:set value="https://lh3.googleusercontent.com/Wqst0ZKSX3p3hdhouVcMzVdGOSdkHRYe4iXuSO5CdAdGGChBOSyTx9KfS7hWpSty6n1dPHaXGMMRBn3I-NCiwWEFQXWHoIwhaRpI1EtCyNOYrpCy1cny8DGVSr8OjpHzDHfH5Yhdqg=w2400" var="blurIMG"/>
${consoledao.incrementViews("idee", request, 0)}
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

        <meta property="og:url"           content="https://macelleriadellantonio.it<c:url value="/idee.jsp"/>" />
        <meta property="og:type"          content="website" />
        <meta property="og:title"         content="Le idee de 'l Bortoleto" />
        <meta property="og:description"   content="Scopri sempre interessanti consigli e idee su come preparare i prodotti de 'l Bortoleto" />
        <meta property="og:image"         content="/Bortoleto/img/logo2.png" />
        <meta property="fb:app_id"         content="320307085338651" />

        <link rel="icon" href="/Bortoleto/img/favicon.ico" sizes="16x16" >
        <title>Le idee de 'l Bortoleto</title>
        <meta name="Description" content="Scopri sempre interessanti consigli e idee su come preparare i prodotti de 'l Bortoleto">
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
            html, body{
                overflow-x: unset;
            }
            .divNotify{
                width: 100%;
                position: fixed;
                z-index: 1111;
            }
            .alert{    
                position: relative;
                padding: .75rem 1.25rem;
                margin-bottom: 1rem;
                border: 1px solid transparent;
                border-radius: .25rem;
                z-index: 1111;
                top: 20px;
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
    <c:choose>
        <c:when test="${response.getHeader('NOTIFICA') ne null && response.getHeader('STATO') ne null && response.getHeader('STATO') eq 'positivo'}">
            <div class="divNotify">
                <div class="container alert alert-success" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="alert-heading">Ottimo!</h4>
                    <p>${response.getHeader('NOTIFICA')}</p>
                    <hr>
                    <p class="mb-0">Per qualsiasi informazione o chiarimento non esitare a contattarci a <b>info@macelleriadellantonio.it</b></p>            
                </div>
            </div>
        </c:when>
        <c:when test="${response.getHeader('NOTIFICA') ne null && response.getHeader('STATO') ne null && response.getHeader('STATO') eq 'negativo'}">
            <div class="divNotify">
                <div class="container alert alert-danger" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="alert-heading">Ouch!</h4>
                    <p>${response.getHeader('NOTIFICA')}</p>
                    <hr>
                    <p class="mb-0">Per qualsiasi informazione o chiarimento non esitare a contattarci a <b>info@macelleriadellantonio.it</b></p>            
                </div>
            </div>
        </c:when>
    </c:choose>
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
    <div id="parallaxN2" style="margin-bottom: 5rem;" class="imgPara image-liquid image-holder--original parallax-window" data-parallax="scroll" data-image-src="/Bortoleto/img/idee-sfondo.jpg">
        <div class="effetto1">
            <div style="height: 30rem;">
                <div class="container cPara">
                    <div class="customPaddingPara">
                        <h1 class="customStylePara">Le idee de 'l Bortoleto</h1>
                        <p>Scopri sempre interessanti consigli e idee su come preparare i prodotti de 'L Bortoleto</p>
                    </div>
                </div>
                <div class="scrollIcon">
                    <a style="color: white;" href="#ricette">
                        <i class="fas fa-chevron-down"></i>
                        <h5>Scorri</h5>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class='container' id="ricette">
        <div class="row mt-5">
            <div class="col-lg-8">

                <div class="row mb-4 Post">
                    <div class="col-lg-3  col-md-3"></div>
                    <div class="col-lg-9 col-md-9">
                        <div class="input-group text-center">
                            <div class="input-group-btn search-panel" style="margin: auto auto;">
                                <button type="button" class="primary-btn btn btn-outline-brown dropdown-toggle" data-toggle="dropdown">
                                    <span id="search_concept">Ordina per</span> <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu" style="width: max-content;">
                                    <li><a style="cursor: pointer;" onclick="filter('PiuVisti');">Più lette</a></li>
                                    <li><a style="cursor: pointer;" onclick="filter('MenoVisti');">Meno Lette</a></li>
                                    <li><a style="cursor: pointer;" onclick="filter('PiuRecenti');">Più recenti</a></li>
                                    <li><a style="cursor: pointer;" onclick="filter('MenoRecenti');">Meno recenti</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>  
            </div>
            <div class="col-lg-4"></div>
        </div>
        <div class="row mt-1">                
            <div id="Ricette" class="col-lg-8">
                <c:choose>
                    <c:when test="${param.search != null}">
                        <h3 id="search_Result" class="black-text text-center">
                            Risultati della ricerca:  
                            <a href="<c:url value="/idee.jsp"/>" style="cursor: pointer;">
                                <i class="red-text fas fa-times"></i>
                            </a>
                        </h3><br>
                        <c:set value="false" var="checkSearch" /> 
                        <c:forEach items="${ricette}" var="ricetta" >
                            <c:set value="${ricettedao.getComments(ricetta.id)}" var="commenti" />
                            <c:if test="${ricetta.nome.toLowerCase().contains(param.search.replace('+', ' '))}">
                                <div class="row mb-4 Ricetta">
                                    <div class="col-lg-3  col-md-3 meta-details" style="text-align: right;  margin-top: 35px;">
                                        <ul class="tags realTags key black-text textOverflow">
                                            <c:forEach items="${ricettedao.getAllProdsOfIdea(ricetta.id)}" var="tag" >
                                                <c:set var="prodIdea" value="${productdao.getProduct(tag)}" />
                                                <li>
                                                    <a class="tagLink" href="<c:url value="/idee.jsp?prod=${prodIdea.id}&nome=${prodIdea.nome.replace(' ', '-')}"/>">#${StringUtils.capitalize(prodIdea.nome.toLowerCase())}</a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                        <div class="user-details row detailPost" style="color: #757777;">
                                            <p style="padding-left: 0px;" class="creator user-name col-lg-12 col-md-12 col-6">${ricetta.creatore}<i class="far fa-user ml-2" style="color: black;"></i></p>
                                            <p style="padding-left: 0px;" class="date col-lg-12 col-md-12 col-6">${ricetta.data.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))}<i class="far fa-calendar-alt ml-2" style="color: black;"></i></span></p>
                                            <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6">${commenti.size()} Commenti<i class="far fa-comment ml-2" style="color: black;"></i></p>
                                            <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6">${ricetta.views} Letture<i class="far fa-eye" style="color: black;"></i></p>
                                            <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6">${ricetta.tempo} Minuti<i class="far fa-clock ml-2" style="color: black;"></i></p>
                                            <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6">${ricetta.difficolta}<i class="far fa-smile ml-2" style="color: black;"></i></p> 
                                        </div>
                                    </div>
                                    <div class="col-lg-9 col-md-9 ">
                                        <div class="feature-img text-center">
                                            <img class="lazy img-fluid blogIMG" data-src="/${ricetta.immagine}" alt="${ricetta.nome}">
                                        </div>
                                        <a class="posts-title" href="<c:url value="/idea.jsp?id=${ricetta.id}&nome=${ricetta.nome.replace(' ', '-')}"/>">
                                            <h2 class="textOverflow nomeRic mt-3">${ricetta.nome}</h2>
                                        </a>
                                        <p class="excert textOverflow">
                                            ${ricetta.descrizione}
                                        </p>
                                        <a href="<c:url value="/idea.jsp?id=${ricetta.id}&nome=${ricetta.nome.replace(' ', '-')}"/>" class="primary-btn btn btn-outline-brown mb-5" style="padding-top: 0; padding-bottom: 0;">scopri di più</a>
                                    </div>
                                </div>
                                <c:set value="true" var="checkSearch" />   
                            </c:if>
                        </c:forEach>
                        <c:if test="${checkSearch == false}">
                            <h4 id="noProd" class="black-text text-center">Non ci sono ricette che corrispondono alla ricerca</h4>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <h3 id="search_Result" class="black-text text-center invisible">
                            Risultati della ricerca:  
                            <a onclick='deleteSearch();' style="cursor: pointer;">
                                <i class="red-text fas fa-times"></i>
                            </a>
                        </h3><br>
                        <c:choose>
                            <c:when test="${param.cat != null}">
                                <c:set value="${ricettedao.getByType(param.cat)}" var="ricette" /> 
                                <c:choose>
                                    <c:when test="${param.cat.equals('1')}">
                                        <h2 class="mt-5 mb-5 black-text"><i class="fas fa-stream mr-3" style="color: black;"></i>Le nostre idee</h2>
                                    </c:when>
                                    <c:when test="${param.cat.equals('2')}">
                                        <h2 class="mt-5 mb-5 black-text"><i class="fas fa-stream mr-3" style="color: black;"></i>Le vostre idee</h2>
                                        <a class="invisible-sm" onclick="sendRicetta();"><h1 class="mt-2 mb-5" style="color: #065906;"><i class="fas fa-pen-alt mr-2" style="color: #065906;"></i>Inviaci una tua idea</h1></a>
                                    </c:when>
                                </c:choose>
                            </c:when>
                            <c:when test="${param.prod != null}">
                                <c:choose>
                                    <c:when test="${param.prod != 0 && productdao.getProduct(param.prod).nome.toLowerCase() eq param.nome.replace('-', ' ').toLowerCase()}">
                                        <c:set value="${ricettedao.getRecipeOfProduct(param.prod)}" var="ricette" /> 
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
                                                    <a href="<c:url value="/idee.jsp?prod=${productdao.getProduct(param.prod).id}&nome=${param.nome}"/>" itemprop="item" ><em><span itemprop="name">${param.nome.replace("-"," ")}</span></em></a>
                                                    <meta itemprop="position" content="3" />
                                                </li>
                                            </ol>
                                        </nav>
                                        <h3 class="mt-5 mb-5 black-text">
                                            <i class="fas fa-stream mr-3" style="color: black;"></i>
                                            ${productdao.getProduct(param.prod).nome}
                                        </h3>   
                                    </c:when>
                                    <c:otherwise>
                                        <c:set value="${null}" var="ricette" />
                                    </c:otherwise>
                                </c:choose>   
                            </c:when>
                        </c:choose>

                        <c:choose>
                            <c:when test="${ricette == null || ricette.isEmpty()}">
                                <h3 class="mt-5 mb-5 black-text">Tante teste, tante idee! Contribuisci anche tu!</h3>
                                <a onclick="sendRicetta();"><h1 class="mt-2 mb-5" style="color: #065906;"><i class="fas fa-pen-alt mr-2" style="color: #065906;"></i>Inviaci una tua idea</h1></a>
                            </c:when>                                
                            <c:otherwise>
                                <c:forEach items="${ricette}" var="ricetta" >
                                    <c:set value="${ricettedao.getComments(ricetta.id)}" var="commenti" />
                                    <div class="row mb-4 Ricetta">
                                        <div class="col-lg-3  col-md-3 meta-details" style="text-align: right;  margin-top: 35px;">
                                            <ul class="tags realTags key black-text textOverflow">
                                                <c:forEach items="${ricettedao.getAllProdsOfIdea(ricetta.id)}" var="tag" >
                                                    <c:set var="prodIdea" value="${productdao.getProduct(tag)}" />
                                                    <li>
                                                        <a class="tagLink" href="<c:url value="/idee.jsp?prod=${prodIdea.id}&nome=${prodIdea.nome.replace(' ', '-')}"/>">#${StringUtils.capitalize(prodIdea.nome.toLowerCase())}</a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                            <div class="user-details row detailPost" style="color: #757777;">
                                                <p style="padding-left: 0px;" class="creator user-name col-lg-12 col-md-12 col-6">${ricetta.creatore}<i class="far fa-user ml-2" style="color: black;"></i></p>
                                                <p style="padding-left: 0px;" class="date col-lg-12 col-md-12 col-6">${ricetta.data.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))} <i class="far fa-calendar-alt ml-2" style="color: black;"></i></span></p>
                                                <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6">${commenti.size()} Commenti <i class="far fa-comment ml-2" style="color: black;"></i></p>
                                                <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6">${ricetta.views} Letture <i class="far fa-eye ml-2" style="color: black;"></i></p>
                                                <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6">${ricetta.tempo} Minuti<i class="far fa-clock ml-2" style="color: black;"></i></p>
                                                <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6">${ricetta.difficolta}<i class="far fa-smile ml-2" style="color: black;"></i></p> 
                                            </div>
                                        </div>
                                        <div class="col-lg-9 col-md-9 ">
                                            <div class="feature-img text-center">
                                                <img class="lazy img-fluid blogIMG" data-src="/${ricetta.immagine}" alt="${ricetta.nome}">
                                            </div>
                                            <a class="posts-title" href="<c:url value="/idea.jsp?id=${ricetta.id}&nome=${ricetta.nome.replace(' ', '-')}"/>">
                                                <h2 class="textOverflow nomeRic mt-3">${ricetta.nome}</h2>
                                            </a>
                                            <p class="excert textOverflow">
                                                ${ricetta.descrizione}
                                            </p>
                                            <a href="<c:url value="/idea.jsp?id=${ricetta.id}&nome=${ricetta.nome.replace(' ', '-')}"/>" class="primary-btn btn btn-outline-brown mb-5" style="padding-top: 0; padding-bottom: 0;">scopri di più</a>
                                        </div>

                                    </div>  
                                </c:forEach>
                                <h4 id="noProd" class="black-text text-center invisible">Non ci sono ricette che corrispondono alla ricerca</h4>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="col-lg-4 sidebar-widgets">
                <div class="widget-wrap">
                    <div class="single-sidebar-widget">
                        <a href='<c:url value="/idee.jsp"/>'><h1><i class="fas fa-arrow-left mr-2"></i>Torna a tutte</h1></a>
                    </div>
                    <c:if test="${param.cat != null}">
                        <c:if test="${param.cat.equals('2')}">
                            <div class="single-sidebar-widget black-text" id="sendRicettaLink">
                                <a onclick="sendRicetta();"><h3 style="color: #065906;"><i class="fas fa-pen-alt mr-2" style="color: #065906;"></i>Inviaci una tua idea</h3></a>
                            </div>
                        </c:if>        
                    </c:if>
                    <div class="single-sidebar-widget search-widget">
                        <form class="search-form" action="<c:url value="/idee.jsp#ricetta"/>">
                            <input id="myInput2" onkeyup="myFunction2();" class="search_input" type="text" placeholder="Cerca..." name="search">
                            <button type="submit"><i class="fas fa-search"></i></button>
                        </form>
                    </div>
                    <c:if test="${!viewed.isEmpty()}">
                        <div class="single-sidebar-widget popular-post-widget">
                            <h4 class="personalized popular-title">Più lette</h4>
                            <div class="popular-post-list">
                                <c:forEach items="${viewed}" var="v" >
                                    <div class="single-post-list d-flex flex-row align-items-center">
                                        <div class="thumb">
                                            <img style="width: 150px;" class="img-fluid" src="/${v.immagine}" alt="${v.nome}">
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
                        <h4 class="category-title">Catgorie</h4>
                        <ul class="cat-list">
                            <li>
                                <a href="<c:url value="/idee.jsp?cat=0" />" class="d-flex justify-content-between">
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
        function myFunction2() {
            // Declare variables 
            var input, filter, table, tr, td, td1, i, txtValue, txtValue1, check = false;
            input = document.getElementById("myInput2");

            filter = input.value.toUpperCase();
            table = document.getElementById("Ricette");
            tr = table.getElementsByClassName("Ricetta");
            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByClassName("nomeRic")[0];
                if (td || td1) {
                    txtValue = td.textContent || td.innerText;
                    $("#search_Result").removeClass('invisible');
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                        check = true;
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
            if (check === false) {
                $("#noProd").removeClass('invisible');
            } else {
                $("#noProd").addClass('invisible');
            }
            if (filter === "") {
                $("#search_Result").addClass('invisible');
            }
        }
        function deleteSearch() {
            $("#myInput2").val("");
            var table = document.getElementById("Ricette");
            var tr = table.getElementsByClassName("Ricetta");
            for (var i = 0; i < tr.length; i++) {
                tr[i].style.display = "";
            }
            $("#search_Result").addClass('invisible');
            $("#noProd").addClass('invisible');
        }

        function filter(id) {
            var cate = null, search = null, prod = null;
            if ('${param.cat}' !== '') {
                cate = '${param.cat}';
            }
            if ('${param.search}' !== '') {
                search = '${param.search}';
            }
            if ('${param.prod}' !== '') {
                prod = '${param.prod}';
            }
            switch (id) {
                case("PiuVisti"):
                    $.ajax({
                        type: "POST",
                        url: "/Bortoleto/ajax/recipesOrder.jsp",
                        data: {order: id, cat: cate, search: search, prod: prod},
                        cache: false,
                        success: function (response) {
                            $('#Ricette').html(response);
                        },
                        error: function () {
                            alert("Errore update Order Type");
                        }
                    });
                    break;
                case("MenoVisti"):
                    $.ajax({
                        type: "POST",
                        url: "/Bortoleto/ajax/recipesOrder.jsp",
                        data: {order: id, cat: cate, search: search, prod: prod},
                        cache: false,
                        success: function (response) {
                            $('#Ricette').html(response);
                        },
                        error: function () {
                            alert("Errore update Order Type");
                        }
                    });
                    break;
                case("PiuRecenti"):
                    $.ajax({
                        type: "POST",
                        url: "/Bortoleto/ajax/recipesOrder.jsp",
                        data: {order: id, cat: cate, search: search, prod: prod},
                        cache: false,
                        success: function (response) {
                            $('#Ricette').html(response);
                        },
                        error: function () {
                            alert("Errore update Order Type");
                        }
                    });
                    break;
                case("MenoRecenti"):
                    $.ajax({
                        type: "POST",
                        url: "/Bortoleto/ajax/recipesOrder.jsp",
                        data: {order: id, cat: cate, search: search, prod: prod},
                        cache: false,
                        success: function (response) {
                            $('#Ricette').html(response);
                        },
                        error: function () {
                            alert("Errore update Order Type");
                        }
                    });
                    break;
            }
        }

        //Back Ricetta
        function backRicetta(id) {
            var cate = '0', search = '', prod = '';
            if ('${param.cat}' !== '') {
                cate = '${param.cat}';
            }
            if ('${param.search}' !== '') {
                search = '${param.search}';
            }
            if ('${param.prod}' !== '') {
                prod = '${param.prod}';
            }
            $.ajax({
                type: "POST",
                url: "/Bortoleto/ajax/recipesOrder.jsp",
                data: {order: id, cat: cate, search: search, prod: prod},
                cache: false,
                success: function (response) {
                    $('#Ricette').html(response);
                    $('#sendRicettaLink').html('<a onclick="sendRicetta();"><h1 style="color: #065906;"><i class="fas fa-pen-alt mr-2" style="color: #065906;"></i>Inviaci una tua idea</h1></a>');
                },
                error: function () {
                    alert("Errore sendRicetta");
                }
            });
        }
        //Send Ricetta
        function sendRicetta() {
            $.ajax({
                type: "GET",
                url: "/Bortoleto/ajax/sendRecipe.jsp",
                cache: false,
                success: function (response) {
                    $('#Ricette').html(response);
                    $('#sendRicettaLink').html('<a onclick="backRicetta(\'PiuRecenti\');"><h1 class="black-text"><i class="fas fa-arrow-left mr-2"></i>Torna indietro</h1></a>');
                },
                error: function () {
                    alert("Errore sendRicetta");
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

        <c:if test="${response.getHeader('NOTIFICA') ne null}">
        $('.alert').alert();
        $(".alert").delay(6000).slideUp(250, function () {
            $(this).alert('close');
        });
        </c:if>
    </script>
    <script>
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
