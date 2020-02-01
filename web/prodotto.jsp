<%-- 
    Document   : prodotto
    Created on : 4 gen 2020, 10:23:17
    Author     : Roberto97
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="database.jdbc.JDBCCategoryDAO"%>
<%@page import="database.daos.CategoryDAO"%>
<%@page import="database.entities.Prodotto"%>
<%@page import="database.factories.DAOFactory"%>
<%@page import="database.jdbc.JDBCProductDAO"%>
<%@page import="database.daos.ProductDAO"%>

<%
    /* Devo farlo perchè altrimenti facebook e google non vedono i parametri nei metadati e nel testo da quanto si usa l'url rewriting */
    DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
    if (daoFactory == null) {
        throw new ServletException("Impossible to get dao factory for user storage system");
    }
    ProductDAO productDAO = new JDBCProductDAO(daoFactory.getConnection());
    CategoryDAO categoryDAO = new JDBCCategoryDAO(daoFactory.getConnection());

    Prodotto prod = productDAO.getProductByName(request.getParameter("nome").replace("-", " "));
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="request" value="<%=request%>"/> <!-- Request lo chiamo con una scriplets e lo salvo in una variabile perchè serve per diversi metodi java -->
<c:set var="response" value="<%=response%>"/> <!-- Response lo chiamo con una scriplets e lo salvo in una variabile perchè serve per diversi metodi java -->
<c:set value="${productdao.getAllProductsOfCart(request)}" var="prodottiCart" />
<c:set value="${productdao.getTotalOfCart(request)}" var="subTotaleCart" />
<c:set value="${pagamentodao.getSpeseSpedizione(subTotaleCart, ritiroAttribute, request)}" var="spedizioneCart" />
<c:set value="${pagamentodao.getTot(subTotaleCart, spedizioneCart)}" var="totaleCart" />
<c:set var="confCat" value="${categorydao.getConfCategories()}"/>
<c:set var="freshCat" value="${categorydao.getFreshCategories()}"/>
<c:set value='<%=prod%>' var="prod"/>
<c:choose>
    <c:when test="${prod.categoria ne param.cat.replace('-', ' ') || prod.nome ne param.nome.replace('-', ' ') || prod.id ne param.id}">
        <c:set var="prod" value="${null}" />
        <c:set var="cat" value="${null}" />
    </c:when>
    <c:otherwise>
        <c:set value="${ricettedao.getRecipeOfProduct(prod.id)}" var="ideeProdotto" />
        <c:set value="${blogdao.getIDTag(prod.nome)}" var="blogProdotto" />
        <c:set value='<%=categoryDAO.getByName(request.getParameter("cat").replace("-", " "))%>' var="cat"/>
        <c:set value="<%= productDAO.getNumberRate(prod.getId())%>" var="numeroReviews" />
        <c:set value="<%= productDAO.getRate(prod.getId())%>" var="valoreReviews" />
        <c:set value="<%= productDAO.getProductVariant(prod.getId())%>" var="array" />
        ${consoledao.incrementViews("bottega", request, param.id)}
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

        <meta property="og:url"           content="https://macelleriadellantonio.it/Bortoleto/prodotto/${prod.id}/${prod.categoria.replace(' ','-')}/${prod.nome.replace(' ','-')}" />
        <meta property="og:type"          content="website" />
        <meta property="og:title"         content="${prod.nome}" />
        <meta property="og:description"   content="${prod.descrizione}" />        
        <meta property="og:image"         content="https://macelleriadellantonio.it/Bortoleto/${prod.immagine}" />
        <meta property="og:site_name" content="Macelleria Ristorante Dellantonio 'L Bortoleto">

        <!-- Microdati per Facebook Pixel -->
        <meta property="fb:app_id"         content="320307085338651" />
        <meta property="product:brand" content="'L Bortoleto">
        <c:choose>
            <c:when test="${prod.disponibile eq true}">
                <meta property="product:availability" content="in stock">
            </c:when>
            <c:otherwise>
                <meta property="product:availability" content="out of stock">
            </c:otherwise>
        </c:choose>                 
        <meta property="product:condition" content="new">
        <meta property="product:price:amount" content="${prod.costo.toString().replace(',', '.')}">
        <meta property="product:type" content="${prod.categoria}">
        <meta property="product:category" content="${prod.categoria}">
        <meta property="product:price:currency" content="EUR">
        <meta property="product:retailer_item_id" content="${prod.id}">
        <meta property="google_product_category" content="4628">

        <!-- MetaDati per Google e Sito Web-->
        <link rel="icon" href="/Bortoleto/img/favicon.ico" sizes="16x16"  alt="Salumi online">
        <title>${prod.nome} - ${prod.categoria} | Bortoleto</title>
        <meta name="Description" content="${prod.descrizione}">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="theme-color" content="#312e2e">


        <!-- CSS include -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">
        <link href="/Bortoleto/css/mdb.min.css" rel="stylesheet">
        <!--miei css -->
        <link rel="stylesheet" href="/Bortoleto/css/style-min.css">
        <link rel="stylesheet" href="/Bortoleto/css/font-min.css">
        <link rel="stylesheet" href="/Bortoleto/css/bottegaCSS-min.css">
        <link rel="stylesheet" href="/Bortoleto/css/navbar-min.css">
        <link rel="stylesheet" href="/Bortoleto/css/vari-min.css">
        <link rel="stylesheet" href="/Bortoleto/css/prodotto-min.css">
        <style>
        </style>

        <!-- Script per la cookie policy -->
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
            fbq('track', 'PageView', {
                content_ids: '${prod.id}',
                content_type: 'product',
                product_type: '${prod.categoria}',
                content_category: '${prod.categoria}'
            });
        </script>
    <noscript><img height="1" width="1" style="display:none"
                   src="https://www.facebook.com/tr?id=467659847403449&ev=PageView&noscript=1"
                   /></noscript>
    <!-- End Facebook Pixel Code -->
</head>

<body id="topPage" class="foo" data-spy="scroll" data-target=".sidebar">

    <!-- Markup JSON-LD generato da Assistente per il markup dei dati strutturati di Google. -->
    <div>
        <div itemtype="http://schema.org/Product" itemscope>
            <meta itemprop="mpn" content="${prod.id}" />
            <meta itemprop="name" content="${prod.nome}" />
            <link itemprop="image" href="https://macelleriadellantonio.it/Bortoleto/${prod.immagine}" />
            <meta itemprop="description" content="${prod.descrizione}" />
            <div itemprop="offers" itemtype="http://schema.org/Offer" itemscope>
                <link itemprop="url" href="https://macelleriadellantonio.it/Bortoleto/prodotto/${prod.id}/${prod.categoria.replace(' ','-')}/${prod.nome.replace(' ','-')}" />
                <meta itemprop="availability" content="https://schema.org/InStock" />
                <meta itemprop="priceCurrency" content="EUR" />
                <meta itemprop="itemCondition" content="https://schema.org/NewCondition" />
                <meta itemprop="price" content="${prod.costo.toString().replace(',', '.')}" />
                <meta itemprop="priceValidUntil" content="2022-12-31" />
                <div itemprop="seller" itemtype="http://schema.org/Organization" itemscope>
                    <meta itemprop="name" content="Macelleria Dellantonio 'L Bortoleto" />
                </div>
            </div>
            <c:if test="${numeroReviews ne 0}">
                <div itemprop="aggregateRating" itemtype="http://schema.org/AggregateRating" itemscope>
                    <meta itemprop="reviewCount" content="${numeroReviews}" />
                    <meta itemprop="ratingValue" content="${valoreReviews}" />
                </div>
            </c:if>
            <meta itemprop="sku" content="${prod.id}" />
            <div itemprop="brand" itemtype="http://schema.org/Thing" itemscope>
                <meta itemprop="name" content="Bortoleto" />
            </div>
        </div>
    </div>            
    <!-- Fine MetaDati snippet Google -->

    <!-- Codici facebook per il share Button -->
    <div id="fb-root"></div>
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/it_IT/sdk.js#xfbml=1&version=v5.0&appId=320307085338651&autoLogAppEvents=1"></script>
    <!-- Fine codici facebook -->    

    <!-- Scroll to top  -->
    <a href="#topPage" id="myBtn45" title="Torna in cima" class="rightGray"><i class="fas fa-angle-up"></i></a>


    <!-- Ricerca di prodotti -->
    <div class="div-search-icon">
        <a class="search_icon" aria-label="Cerca Prodotti"><i class="fa fa-search"></i></a>
    </div>
    <div class="search-box search-elem">
        <button class="close-search">x</button>
        <div class="inner-1 text-center">
            <label class="consigliati-h4 white-text" for="cerca">Cerca un prodotto</label><br>
            <select data-width="300px" onchange="$('#loading-search-product').css('display', 'block'); location = this.value;" class="selectpicker" id="cerca" name="cerca" data-live-search="true">
                <option disabled selected value> -- Cerca un Prodotto -- </option>
                <c:forEach items="${categorydao.getAllCategories()}" var="categoria" >
                    <option value="<c:url value="/categoria.jsp?id=${categoria.id}&nome=${categoria.nome.replace(' ', '-')}" />" style="font-weight: 700;">${categoria.nome}</option>
                    <c:forEach items="${productdao.getAllProductsOfCategory(categoria.nome)}" var="pr" >
                        <option data-tokens="${pr.nome} ${categoria.nome} ${pr.nome}" value="<c:url value="/prodotto.jsp?id=${pr.id}&nome=${pr.nome.replace(' ', '-')}&cat=${pr.categoria.replace(' ', '-')}" />">${pr.nome}</option>
                    </c:forEach>
                </c:forEach>
            </select>
            <div id="loading-search-product" style='display: none;'>
                <img src='/Bortoleto/img/91.gif' />
            </div>
        </div>
    </div> 
    <!-- Fine Ricerca di Prodotti -->

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            Menu
            <i class="fa fa-bars"></i>
        </button>
        <a id="nav-logo-img" class="navbar-brand" href="<c:url value="/#Bortoleto"/>">
            <img width="90vh" src="/Bortoleto/img/logo2.png" alt="Logo">
        </a>
        <a id="nav-logo-title" class="navbar-brand js-scroll-trigger" href="/Bortoleto/">'L Bortoleto</a>
        <a id='fav-modal-trigger' data-toggle="modal" data-target="#fluidModalBottomDangerDemo" class="menu-cart-button hs-cart" style='right: 50px !important;'>
            <i style="color: red !important;" class="fas fa-heart nav-ico"></i>
            <div class="count-bg nav-counter-div">
                <span id="prefSize" class="cart-count nav-counter-span">${productdao.getAllProductsOfSession(preferiti).size()}</span>
            </div>
        </a>
        <a id='cart-modal-trigger' class="menu-cart-button hs-cart">
            <i class="fas fa-shopping-cart nav-ico"></i>
            <div class="count-bg nav-counter-div">
                <span id="cartSize" class="cart-count nav-counter-span">${productdao.getCartSize(request)}</span>
            </div>
        </a>

        <div class="collapse navbar-collapse" id="navbarResponsive" style="">
            <ul class="navbar-nav text-uppercase ml-auto text-center">
                <li class="nav-item dropdown">
                    <div class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Home</div>
                    <div id="" class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="<c:url value="/#chi-siamo"/>">Chi Siamo</a>
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
    <div id="cd-shadow-layer"></div>
    <div id="cd-cart"></div>
    <!-- Fine Navbar e overlay e carrello -->

    <!-- Esplora categorie dropdown -->
    <div class="container sticky-top">
        <ul id="dropCat" class="dropdown nav">    
            <div class="btn btn-secondary nav-link dropdown-toggle categorieDrop" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="background-color: #ffffff !important; font-weight: 900; color: black !important; margin: auto auto;">
                Categorie
            </div>

            <div class="dropdown-menu scrollable-menu" aria-labelledby="dropdownMenuLink" style="padding: 0; height: fit-content; max-height: 400px;">

                <div class="row">
                    <div class="col-md-4">
                        <div class="nav flex-column nav-pills pills-nav-link-box" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                            <c:if test="${!productdao.getFreshProducts().isEmpty()}">
                                <h5><a style="color: white; margin-left: 0;" href="/Bortoleto/alimenti-freschi/">Alimenti Freschi</a><span>${categorydao.getFreshCategories().size()}</span></h5>
                                <a class="nav-link active ml-0" id="v-pills-primo-tab" data-toggle="pill" role="tab" aria-controls="v-pills-primo" aria-selected="true"></a>
                                <c:forEach items="${freshCat}" var="categoria" >
                                    <c:if test="${!productdao.getAllProductsOfCategory(categoria.nome).isEmpty()}" >
                                        <a class="nav-link" id="v-pills-${categoria.nome.replace(" ", "-")}-tab" data-toggle="pill" data-target="#v-pills-${categoria.nome.replace(" ", "-")}" role="tab" aria-controls="v-pills-${categoria.nome.replace(" ", "-")}" aria-selected="false">${categoria.nome}<span style="right: 1.5rem; position: absolute;">${productdao.getAllProductsOfCategory(categoria.nome).size()}</span></a>
                                        </c:if>    
                                    </c:forEach>
                                </c:if>
                                <c:if test="${!productdao.getConfProducts().isEmpty()}">
                                <h5><a style="color: white; margin-left: 0;" href="/Bortoleto/dal-Trentino/">Prodotti da Noi</a><span>${categorydao.getConfCategories().size()}</span></h5>
                                <a class="nav-link active ml-0" id="v-pills-primo-tab" data-toggle="pill" role="tab" aria-controls="v-pills-primo" aria-selected="true"></a>
                                <c:forEach items="${confCat}" var="categoria" >
                                    <c:if test="${!productdao.getAllProductsOfCategory(categoria.nome).isEmpty()}" >
                                        <a class="nav-link" id="v-pills-${categoria.nome.replace(" ", "-")}-tab" data-toggle="pill" data-target="#v-pills-${categoria.nome.replace(" ", "-")}" role="tab" aria-controls="v-pills-${categoria.nome.replace(" ", "-")}" aria-selected="false">${categoria.nome}<span style="right: 1.5rem; position: absolute;">${productdao.getAllProductsOfCategory(categoria.nome).size()}</span></a>
                                        </c:if>    
                                    </c:forEach>
                                </c:if>
                        </div>   
                    </div>
                    <div class="col-md-8">
                        <div class="tab-content" id="v-pills-tabContent">
                            <div class="tab-pane fade show active" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
                                <p>Scegli una categoria</p>
                            </div>
                            <c:if test="${!productdao.getFreshProducts().isEmpty()}">
                                <c:forEach items="${freshCat}" var="categoria" >
                                    <c:if test="${!productdao.getAllProductsOfCategory(categoria.nome).isEmpty()}" >
                                        <div class="tab-pane fade" id="v-pills-${categoria.nome.replace(" ", "-")}" role="tabpanel" aria-labelledby="v-pills-${categoria.nome.replace(" ", "-")}-tab">
                                            <div class="row">
                                                <c:forEach items="${productdao.getAllProductsOfCategory(categoria.nome)}" var="pr" >
                                                    <div class="col-lg-4 col-md-6">
                                                        <a rel="nofollow" href="<c:url value="/prodotto.jsp?id=${pr.id}&nome=${pr.nome.replace(' ', '-')}&cat=${pr.categoria.replace(' ', '-')}" />">
                                                            <img style="max-width: 140px; margin: 10px; border-radius: 5px;" src="/${pr.immagine}" />
                                                            <p style="font-family: 'Montserrat', sans-serif;">${pr.nome}</p>
                                                        </a>
                                                    </div>
                                                </c:forEach>
                                                <div class="col-lg-4 col-md-6">
                                                    <a rel="nofollow" href="<c:url value="/categoria.jsp?id=${categoria.id}&nome=${categoria.nome.replace(' ', '-')}" />">
                                                        <i class="fas fa-arrow-right" style="color: black; font-size: 140px;"></i>
                                                        <p style="font-family: 'Montserrat', sans-serif;">Vai alla categoria</p>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                            <c:if test="${!productdao.getConfProducts().isEmpty()}">
                                <c:forEach items="${confCat}" var="categoria" >
                                    <c:if test="${!productdao.getAllProductsOfCategory(categoria.nome).isEmpty()}" >
                                        <div class="tab-pane fade" id="v-pills-${categoria.nome.replace(" ", "-")}" role="tabpanel" aria-labelledby="v-pills-${categoria.nome.replace(" ", "-")}-tab">
                                            <div class="row">
                                                <c:forEach items="${productdao.getAllProductsOfCategory(categoria.nome)}" var="pr" >
                                                    <div class="col-lg-4 col-md-6">
                                                        <a rel="nofollow" href="<c:url value="/prodotto.jsp?id=${pr.id}&nome=${pr.nome.replace(' ', '-')}&cat=${pr.categoria.replace(' ', '-')}" />">
                                                            <img style="max-width: 140px; margin: 10px; border-radius: 5px;" src="/${pr.immagine}" />
                                                            <p style="font-family: 'Montserrat', sans-serif;">${pr.nome}</p>
                                                        </a>
                                                    </div>
                                                </c:forEach>
                                                <div class="col-lg-4 col-md-6">
                                                    <a rel="nofollow" href="<c:url value="/categoria.jsp?id=${categoria.id}&nome=${categoria.nome.replace(' ', '-')}" />">
                                                        <i class="fas fa-arrow-right" style="color: black; font-size: 140px;"></i>
                                                        <p style="font-family: 'Montserrat', sans-serif;">Vai alla categoria</p>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </ul>
    </div>
    <!-- Fine Esplora categorie dropdown -->

    <!-- Inizio corpo della pagina -->
    <div class="container">
        <c:choose>
            <c:when test="${prod ne null && prod.categoria eq cat.nome && prod.nome eq param.nome.replace('-', ' ')}">
                <section id="above-the-fold" class="mt-5">
                    <p class="sottotitoli" style="text-align: center; margin: 1rem auto 0 auto;">${cat.nome}</p>
                    <h1 class='consigliati-h4'>${prod.nome}</h1>
                    <nav id="breadcrumb">
                        <ol class="cd-breadcrumb custom-separator" itemscope itemtype="https://schema.org/BreadcrumbList">
                            <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                <a itemprop="item" href="<c:url value="/#Bortoleto"/>"><span itemprop="name">Home</span></a>
                                <meta itemprop="position" content="1" />
                            </li>
                            <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                <a itemprop="item" href="<c:url value="/bottega.jsp"/>"><span itemprop="name">Bottega Online</span></a>
                                <meta itemprop="position" content="2" />
                            </li>
                            <c:choose>
                                <c:when test="${cat.freschi}">
                                    <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                        <a itemprop="item" href="/Bortoleto/alimenti-freschi/"><span itemprop="name">Alimenti Freschi</span></a>
                                        <meta itemprop="position" content="3" />
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                        <a itemprop="item" href="/Bortoleto/dal-Trentino/"><span itemprop="name">Dal Trentino</span></a>
                                        <meta itemprop="position" content="3" />
                                    </li>
                                </c:otherwise>
                            </c:choose>
                            <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                <a itemprop="item" href="<c:url value="/categoria.jsp?id=${cat.id}&nome=${cat.nome.replace(' ', '-')}"/>"><span itemprop="name">${prod.categoria}</span></a>
                                <meta itemprop="position" content="4" />
                            </li>
                            <li class="current" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                <a href="<c:url value="/prodotto.jsp?id=${prod.id}&nome=${prod.nome.replace(' ','-')}&cat=${prod.categoria.replace(' ','-')}"/>" itemprop="item" ><em><span itemprop="name">${prod.nome}</span></em></a>
                                <meta itemprop="position" content="5" />
                            </li>
                        </ol>
                    </nav>

                    <div id="prodotto" class="modal-product" style="margin-bottom: 6rem;">
                        <!-- Start product images -->
                        <div id="prodotto-immagine" class="product-images mb-5">
                            <div class="main-image images" style="width: fit-content; margin: auto auto;">
                                <img style="border-radius: 5px; max-height: 600px;" alt="big images" src="/${prod.immagine}">
                            </div>
                            <div class="mt-5">
                                <h4 class="styled">Descrizione</h4>
                                <p class="description">${prod.descrizione}</p>
                            </div>
                        </div>
                        <!-- end product images -->
                        <div id="prodotto-informazioni" class="product-info">
                            <div class="htc__product__details__inner">  
                                <div class="pro__detl__title">
                                    <h2 style="font-weight: bold; margin: 10px 0 10px 0;">${prod.nome}</h2><br>
                                    <h2 style="font-size: 25px;">${prod.categoria}</h2>
                                </div>
                                <div id="ratingDiv">
                                    <c:set var="rate" value="${valoreReviews}" />
                                    <label style="color: rgba(162, 171, 171, 1)!important;">${numeroReviews} valutazioni (${rate} <i class="far fa-star"></i>)</label><br>
                                    <fieldset class="rating text-center" style="display: initial;">
                                        <input onclick="rate($(this).val(), ${prod.id});" type="radio" id="star5" name="rating" value="5" <c:if test="${rate >= 5}">checked</c:if> /><label class = "full" for="star5" title="5 stelle"></label>
                                        <input onclick="rate($(this).val(), ${prod.id});" type="radio" id="star4half" name="rating" value="4.5" <c:if test="${rate >= 4.5 && rate < 5}">checked</c:if>/><label class="half" for="star4half" title="4.5 stelle"></label>
                                        <input onclick="rate($(this).val(), ${prod.id});" type="radio" id="star4" name="rating" value="4" <c:if test="${rate >= 4 && rate < 4.5}">checked</c:if>/><label class = "full" for="star4" title="4 stelle"></label>
                                        <input onclick="rate($(this).val(), ${prod.id});" type="radio" id="star3half" name="rating" value="3.5" <c:if test="${rate >= 3.5 && rate < 4}">checked</c:if>/><label class="half" for="star3half" title="3.5 stelle"></label>
                                        <input onclick="rate($(this).val(), ${prod.id});" type="radio" id="star3" name="rating" value="3" <c:if test="${rate >= 3 && rate < 3.5}">checked</c:if>/><label class = "full" for="star3" title="3 stelle"></label>
                                        <input onclick="rate($(this).val(), ${prod.id});" type="radio" id="star2half" name="rating" value="2.5" <c:if test="${rate >= 2.5 && rate < 3}">checked</c:if>/><label class="half" for="star2half" title="2.5 stelle"></label>
                                        <input onclick="rate($(this).val(), ${prod.id});" type="radio" id="star2" name="rating" value="2" <c:if test="${rate >= 2 && rate < 2.5}">checked</c:if>/><label class = "full" for="star2" title="2 stelle"></label>
                                        <input onclick="rate($(this).val(), ${prod.id});" type="radio" id="star1half" name="rating" value="1.5" <c:if test="${rate >= 1.5 && rate < 2}">checked</c:if>/><label class="half" for="star1half" title="1.5 stelle"></label>
                                        <input onclick="rate($(this).val(), ${prod.id});" type="radio" id="star1" name="rating" value="1" <c:if test="${rate >= 1 && rate < 1.5}">checked</c:if>/><label class = "full" for="star1" title="1 stella"></label>
                                        <input onclick="rate($(this).val(), ${prod.id});" type="radio" id="starhalf" name="rating" value="0.5" <c:if test="${rate >= 0.5 && rate < 1}">checked</c:if>/><label class="half" for="starhalf" title="0.5 stelle"></label>

                                        </fieldset><br>                                
                                    </div>
                                    <div class="pro__details">
                                    <c:if test="${ideeProdotto ne null && !ideeProdotto.isEmpty()}">
                                        <a href="#ideeProdotto"><img style="vertical-align: text-top; margin-right: 5px;" src="/Bortoleto/img/cappello-chef.png" />Scopri curiose idee su come usare questo prodotto</a><br>
                                        </c:if>
                                        <c:if test="${blogProdotto ne null && blogProdotto != 0}">
                                        <br><a href="#blogProdotto"><img style="vertical-align: text-top; margin-right: 5px;" src="/Bortoleto/img/libro.png" />Lo sapevi che...</a>
                                        </c:if>
                                </div>
                                <c:choose>
                                    <c:when test="${prod.disponibile eq true}">
                                        <c:set var="array" value="${productdao.getProductVariant(prod.id)}"/>
                                        <div class="row">
                                            <div class="col-8">
                                                <ul class="pro__dtl__prize">
                                                    <li><span>Prezzo: </span></li>
                                                    <li><span>Peso: </span></li>                                                    
                                                        <c:if test="${array ne null && !array.isEmpty()}">
                                                            <c:forEach items="${array}" var="varianti" >
                                                            <li><span>${varianti.get(0).variant}: </span></li>
                                                            </c:forEach>
                                                        </c:if>
                                                    <li><span>Quantità: </span></li>
                                                </ul>
                                            </div>
                                            <div class="col-4">
                                                <ul class="pro__dtl__prize">
                                                    <c:choose>
                                                        <c:when test="${array ne null && !array.isEmpty()}">
                                                            <div id="boxDati-false">
                                                                <li>€${productdao.getCostOfVariantCombination(array)}</li>
                                                                <li>${productdao.getWeightOfVariantCombinationFull(array)}kg</li>
                                                                    <c:forEach items="${array}" var="varianti" >            
                                                                    <li>
                                                                        <div class="select__color prodict-statas">
                                                                            <div class="div-select">
                                                                                <select onchange="changeVariante(this, ${prod.id}, false);" name="${varianti.get(0).variant.replace(" ", "")}-false" id="${varianti.get(0).variant.replace(" ", "")}-false">
                                                                                    <c:forEach items="${varianti}" var="variante" >
                                                                                        <option value="${variante.id}">${variante.variantName}</option>
                                                                                    </c:forEach>   
                                                                                </select><br>
                                                                            </div>
                                                                        </div>
                                                                    </li>
                                                                </c:forEach>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <li>€${prod.costo}</li>
                                                            <li>${prod.peso}kg</li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    <li>
                                                        <div class="product-action-wrap">
                                                            <div class="product-quantity">
                                                                <form id='myform' method='POST' action='#'>
                                                                    <div class="product-quantity">
                                                                        <div class="cart-plus-minus">
                                                                            <input id="quantitaInput" class="cart-plus-minus-box" type="number" name="qtybutton" min="1" value="1">
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <ul class="pro__dtl__btn">
                                            <li class="buy__now__btn"><a id="addToCart" onclick="addProdVariant(${prod.id});"><i style="margin-right: 1rem;color: inherit;font-size: 15px;" class="fa fa-cart-plus"></i>Aggiungi al Carrello</a></li>
                                            <li class="heart-${prod.id}">
                                                <c:choose>
                                                    <c:when test="${productdao.isPreferito(prod.id, request) eq true}">
                                                        <a title="Rimuovi ${prod.nome} dai preferiti" onclick="removePreferito(${prod.id});">
                                                            <i class="fas fa-heart" style="color: red !important"></i>
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a title="Aggiungi ${prod.nome} ai preferiti" onclick="addPreferito(${prod.id});">
                                                            <i class="fas fa-heart"></i>
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </li>
                                        </ul>
                                    </c:when>
                                    <c:otherwise>
                                        <h4 style="color: white; background-color: #c32707; padding: 0.3em; text-align: center;">ESAURITO</h4>
                                        <ul class="pro__dtl__btn">
                                            <li class="heart-${prod.id}" style="margin: auto auto;">
                                                <c:choose>
                                                    <c:when test="${productdao.isPreferito(prod.id, request) eq true}">
                                                        <a title="Rimuovi ${prod.nome} dai preferiti" onclick="removePreferito(${prod.id});">
                                                            <i class="fas fa-heart" style="color: red !important"></i>
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a title="Aggiungi ${prod.nome} ai preferiti" onclick="addPreferito(${prod.id});">
                                                            <i class="fas fa-heart"></i>
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </li>
                                        </ul>
                                    </c:otherwise>
                                </c:choose>
                                <div class="pro__social__share">
                                    <div style="margin: auto auto;" class="fb-share-button" data-href="https://macelleriadellantonio.it/Bortoleto/prodotto.jsp?id=${prod.id}&nome=${prod.nome}&cat=${prod.categoria}" data-layout="button" data-size="large"><a rel="nofollow" target="_blank" href="https://macelleriadellantonio.it/Bortoleto/prodotto.jsp?id=${prod.id}&nome=${prod.nome}&cat=${prod.categoria}" class="fb-xfbml-parse-ignore">Condividi</a></div>
                                </div>
                            </div>
                        </div><!-- .modal-product -->
                    </div>
                </section>

                <hr style="background-color: #b4505a; border: 3px solid #b4505a; width: 50%; border-radius: 100%;">

                <section id="categoria">  
                    <div class="row">
                        <div class="col-lg-6 mt-5">
                            <div style="height: 100%; width: 100%; white-space: nowrap; width: fit-content; margin: auto auto;">
                                <span style="display: inline-block; height: 100%; vertical-align: middle;"></span>
                                <img style="vertical-align: middle; max-height: 600px;" src="/${cat.immagine}" />
                            </div>
                        </div>
                        <div class="col-lg-6 mt-5">
                            <h2 class="styled" style="text-align: right; margin-bottom: 2rem;">${cat.nome}</h2>
                            <p class="description">
                                ${cat.descrizione}
                            </p>
                            <div style="width: 100%; text-align: center; z-index: 1;">
                                <a href="<c:url value="/categoria.jsp?id=${cat.id}&nome=${cat.nome.replace(' ','-')}" />" target="_blank" rel="noopener" class="btn btnAcquista">Scopri di Più</a>
                            </div>
                        </div>
                    </div>
                </section>

                <c:if test="${productdao.getOtherProductsOfCategory(cat.nome, prod.id) ne null && !productdao.getOtherProductsOfCategory(cat.nome, prod.id).isEmpty()}">
                    <section class="consigliati-box">   
                        <h4 class="consigliati-h4" style="margin: 10rem auto 2rem auto;">Altro da ${cat.nome}</h4>
                        <!-- 4 prodotti da scegliere a random ogni lunedì a mezzanotte -->
                        <div class="row prodotti-box text-center">
                            <c:forEach items="${productdao.getOtherProductsOfCategory(cat.nome, prod.id)}" var="prodotto" >
                                <div class="col-lg-3 col-md-6" style="margin: auto auto;">
                                    <div class="product">
                                        <div class="product__inner">
                                            <div class="pro__thumb">
                                                <a>
                                                    <img src="/${prodotto.immagine}" alt="${prodotto.nome}" class="lazy">
                                                </a>
                                            </div>
                                            <div class="product__hover__info">
                                                <ul class="product__action">
                                                    <c:choose>
                                                        <c:when test="${prodotto.isDisponibile() eq true}">
                                                            <li><a onclick="quickViewProduct(${prodotto.id});" title="Anteprima" class="quick-view modal-view detail-link"><i class="fas fa-search"></i></a></li>
                                                            <li><a title="Aggiungi ${prodotto.nome} al carrello" onclick="addProd(${prodotto.id});
                                                                    animation($(this));"><i class="fas fa-cart-plus"></i></a></li>
                                                            <li class="heart-${prodotto.id}">
                                                                <c:choose>
                                                                    <c:when test="${productdao.isPreferito(prodotto.id, request) eq true}">
                                                                        <a title="Rimuovi ${prodotto.nome} dai preferiti" onclick="removePreferito(${prodotto.id});">
                                                                            <i class="fas fa-heart" style="color: red !important"></i>
                                                                        </a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a title="Aggiungi ${prodotto.nome} ai preferiti" onclick="addPreferito(${prodotto.id});">
                                                                            <i class="fas fa-heart"></i>
                                                                        </a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </li>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <li><a onclick="quickViewProduct(${prodotto.id});" title="Anteprima" class="quick-view modal-view detail-link"><i class="fas fa-search"></i></a></li>
                                                            <li class="heart-${prodotto.id}">
                                                                <c:choose>
                                                                    <c:when test="${productdao.isPreferito(prodotto.id, request) eq true}">
                                                                        <a title="Rimuovi ${prodotto.nome} dai preferiti" onclick="removePreferito(${prodotto.id});">
                                                                            <i class="fas fa-heart" style="color: red !important"></i>
                                                                        </a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a title="Aggiungi ${prodotto.nome} ai preferiti" onclick="addPreferito(${prodotto.id});">
                                                                            <i class="fas fa-heart"></i>
                                                                        </a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </li>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="product__details">
                                            <h3><a href="<c:url value="/prodotto.jsp?id=${prodotto.id}&nome=${prodotto.nome.replace(' ', '-')}&cat=${prodotto.categoria.replace(' ', '-')}"/>">${prodotto.nome}</a></h3>
                                            <ul class="product__price">
                                                <li class="new__price">€ ${prodotto.costo}</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </section>
                </c:if>

                <c:if test="${ideeProdotto ne null && !ideeProdotto.isEmpty()}">
                    <section id="ideeProdotto" style="padding-top: 10rem;">
                        <div class="mt-5 mb-5">
                            <p class="sottotitoli" style="text-align: center; margin: 0 auto 0 auto;">Idee interessanti</p>
                            <h4 class="consigliati-h4">Alcune idee su...<br>“${prod.nome}”</h4>
                            <div id="carousel-example-multi" class="carousel slide carousel-multi-item v-2 white-text" data-ride="carousel">
                                <div class="carousel-inner" role="listbox">
                                    <div id="productElements" style="flex-wrap: unset; color: black; margin-top: 1.5rem; overflow-x: auto; overflow-y: hidden; display: inline-flex;" class="carousel-item active nav nav-tabs" role="tablist"> 
                                        <c:forEach items="${ideeProdotto}" var="idea" >
                                            <div class="col-lg-4 col-md-6" style="margin: auto;">
                                                <div class="product">
                                                    <div class="product__inner">
                                                        <div class="pro__thumb" style="box-shadow: 5px 5px 20px 0px black; border-radius: 5px;">
                                                            <a style="cursor: default;">
                                                                <img data-src="/${idea.immagine}" alt="${idea.nome}" class="lazy" style="border-radius: 5px;">
                                                            </a>
                                                        </div>
                                                    </div>
                                                    <div class="product__details">
                                                        <h2><a target="_blank" style="font-family: 'Montserrat', sans-serif; font-size: 20px;" href="<c:url value="/idea.jsp?id=${idea.id}&nome=${idea.nome.replace(' ', '-')}"/>">${idea.nome}</a></h2>
                                                        <ul class="product__price">
                                                            <li style="color: #757777; font-family: 'Montserrat', sans-serif; font-size: 18px;" class="new__price"><i class="far fa-calendar-alt mr-2"></i>${idea.data.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))}</li>
                                                            <li style="color: #757777; font-family: 'Montserrat', sans-serif; font-size: 18px;" class="new__price"> <i class="far fa-eye mr-2"></i>${idea.views} Letture</li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </c:if>

                <c:if test="${blogProdotto ne null && blogProdotto != 0}">
                    <c:set var="articoli" value="${blogdao.getAllBlogsWithTag(blogProdotto)}" />
                    <section id="blogProdotto" style="padding-top: 10rem;">
                        <p class="sottotitoli" style="text-align: center; margin: 0 auto 0 auto;">Interessanti curiosità</p>
                        <h4 class="consigliati-h4">Parlando di...<br>“${prod.nome}”</h4>
                        <div id="carousel-example-multi" class="carousel slide carousel-multi-item v-2 white-text" data-ride="carousel">
                            <div class="carousel-inner" role="listbox">
                                <div id="productElements" style="flex-wrap: unset; color: black; margin-top: 1.5rem; overflow-x: auto; overflow-y: hidden; display: inline-flex;" class="carousel-item active nav nav-tabs" role="tablist"> 
                                    <c:forEach items="${articoli}" var="articolo" >
                                        <div class="col-lg-4 col-md-6" style="margin: auto;">
                                            <div class="product">
                                                <div class="product__inner">
                                                    <div class="pro__thumb" style="box-shadow: 5px 5px 20px 0px black; border-radius: 5px;">
                                                        <a style="cursor: default;">
                                                            <img data-src="/${articolo.immagine}" alt="${articolo.nome}" class="lazy" style="border-radius: 5px;">
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="product__details">
                                                    <h2><a target="_blank" style="font-family: 'Montserrat', sans-serif; font-size: 20px;" href="<c:url value="/articolo.jsp?id=${articolo.id}&nome=${articolo.nome.replace(' ', '-')}"/>">${articolo.nome}</a></h2>
                                                    <ul class="product__price">
                                                        <li style="color: #757777; font-family: 'Montserrat', sans-serif; font-size: 18px;" class="new__price"><i class="far fa-calendar-alt mr-2"></i>${articolo.data.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))}</li>
                                                        <li style="color: #757777; font-family: 'Montserrat', sans-serif; font-size: 18px;" class="new__price"> <i class="far fa-eye mr-2"></i>${articolo.views} Letture</li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </section>
                </c:if>

            </c:when>
            <c:otherwise>
                <p class="description">Questo prodotto non è disponibile, oppure non esiste</p>
            </c:otherwise>
        </c:choose>
    </div>
    <!-- Fine corpo della pagina -->


    <!-- Footer -->
    <footer id="footer" class="container-fluid text-center footer"></footer>

    <!-- MODAL -->

    <div class="modal fade bottom" id="fluidModalBottomDangerDemo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"  aria-hidden="true">
    </div>

    <!-- QUICKVIEW PRODUCT -->
    <div id="quickview-wrapper">
    </div>
    <!-- END QUICKVIEW PRODUCT -->

    <!-- FINE MODAL -->

    <!-- Include Javascripts -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.7.2/js/all.js" integrity="sha384-0pzryjIRos8mFBWMzSSZApWtPl/5++eIfzYmTgBBmXYdhvxPc+XcFEk+zJwDgWbP" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script>
    <!-- Miei Javasccript -->
    <script type="text/javascript" src="/Bortoleto/js/mdb.min.js">async;</script>
    <script src="/Bortoleto/js/vari-min.js" async></script>
    <script src="/Bortoleto/js/main-min.js" async></script>
    <script src="/Bortoleto/js/nav.js"></script>
    <script type="text/javascript" src="/Bortoleto/js/jquery.lazy.min.js"></script>    
    <script>
    </script>
    <script>
        function myFunction2() {
            // Declare variables 
            var input, filter, table, tr, td, td1, i, txtValue, txtValue1, txtValue2, check = false;
            input = document.getElementById("myInput2");

            filter = input.value.toUpperCase();
            table = document.getElementById("Elementi");
            tr = table.getElementsByClassName("elemento");
            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByClassName("title")[0];
                td1 = tr[i].getElementsByClassName("category")[0];
                if (td || td1) {
                    txtValue = td.textContent || td.innerText;
                    txtValue1 = td1.textContent || td1.innerText;
                    $("#search_Result").removeClass('invisible');
                    $(".category_Title").addClass('invisible');
                    filter = filter.replace(" ", "");
                    txtValue = txtValue.replace(" ", "");
                    txtValue1 = txtValue1.replace(" ", "");
                    txtValue2 = txtValue1 + txtValue;
                    if (txtValue.toUpperCase().indexOf(filter) > -1 || txtValue1.toUpperCase().indexOf(filter) > -1 || txtValue2.toUpperCase().indexOf(filter) > -1) {
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
                $(".category_Title").removeClass('invisible');
            }
        }
        function deleteSearch() {
            $("#myInput2").val("");
            $("#myInput").val("");
            var table = document.getElementById("Elementi");
            var tr = table.getElementsByClassName("elemento");
            for (var i = 0; i < tr.length; i++) {
                tr[i].style.display = "";
            }
            $("#search_Result").addClass('invisible');
            $(".category_Title").removeClass('invisible');
        }
    </script>

    <script>
        var sizePref = '${productdao.getAllProductsOfSession(preferiti).size()}';
        var sizeCart = '${productdao.getCartSize(request)}';
        //Funzioni ajax preferiti

        //Add Preferito
        function addPreferito(id) {
            $.ajax({
                type: "POST",
                url: "/Bortoleto/addPreferito",
                data: {id: id},
                cache: false,
                success: function () {
                    $('.heart-' + id).html('<a title="Rimuovi dai preferiti" onclick="removePreferito(' + id + ');"><i class="fas fa-heart" style="color: red !important"></i></a>');
                    $('#prefSize').html(++sizePref);
                    updatePrefModal();
                    addToPreferFacebookEvent();
                },
                error: function () {
                    alert("Errore add Preferito");
                }
            });
        }
        //Remove Preferito
        function removePreferito(id) {
            $.ajax({
                type: "POST",
                url: "/Bortoleto/removePreferito",
                data: {id: id},
                cache: false,
                success: function () {
                    $('.heart-' + id).html('<a title="Aggiungi ai preferiti" onclick="addPreferito(' + id + ');"><i class="fas fa-heart"></i></a>');
                    if (sizePref > 0)
                        $('#prefSize').html(--sizePref);
                    updatePrefModal();
                },
                error: function () {
                    alert("Errore remove Preferito");
                }
            });
        }
        //Aggiorna preferiti modal
        function updatePrefModal() {
            $.ajax({
                type: "GET",
                url: "/Bortoleto/ajax/preferitiModalContent.jsp",
                cache: false,
                success: function (response) {
                    $('#preferitiModal').html(response);
                },
                error: function () {
                    alert("Errore update Preferiti modal");
                }
            });
        }

    </script>
    <script>
        //Funzioni ajax carrello

        //Add prodotto al carrello
        function addProd(id) {
            $.ajax({
                type: "POST",
                url: "/Bortoleto/addProd",
                data: {id: id},
                cache: false,
                success: function (response) {
                    updateCartSize();
                    $('#cd-cart').html(response);
                    updatePrefModal();
                },
                error: function () {
                    alert("Errore add Prod");
                }
            });
        }

        //Aggiungi prodotto al carrello con varianti
        function addProdVariant(id) {
            var quantita = $('#quantitaInput').val();
            var variant = "";
        <c:choose>
            <c:when test="${array ne null && !array.isEmpty()}">
                <c:forEach items="${array}" var="varianti" >
            variant += $('#${varianti.get(0).variant.replace(" ", "")}-false option:selected').val() + "_";
                </c:forEach>
            variant = variant.substring(0, variant.length - 1);
            </c:when>
            <c:otherwise>
            variant = null;
            </c:otherwise>
        </c:choose>
            if (variant !== null && variant.length < 1) {
                alert("Devi selezionare i valori");
            } else {
                $('#addToCart').html("<img style='width: 10%;' src='/Bortoleto/img/91.gif' />");
                $.ajax({
                    type: "POST",
                    url: "/Bortoleto/addProd",
                    data: {id: id, quantita: quantita, variant: variant},
                    cache: false,
                    success: function (response) {
                        updateCartSize();
                        $('#cd-cart').html(response);
                        updatePrefModal();
                        /*addToCartFacebookEvent();*/
                        $('#addToCart').html("<img style='width: 10%;' src='data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTguMS4xLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4PSIwcHgiIHk9IjBweCIgdmlld0JveD0iMCAwIDE3LjgzNyAxNy44MzciIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDE3LjgzNyAxNy44Mzc7IiB4bWw6c3BhY2U9InByZXNlcnZlIiB3aWR0aD0iNTEycHgiIGhlaWdodD0iNTEycHgiPgo8Zz4KCTxwYXRoIGQ9Ik0xNi4xNDUsMi41NzFjLTAuMjcyLTAuMjczLTAuNzE4LTAuMjczLTAuOTksMEw2LjkyLDEwLjgwNGwtNC4yNDEtNC4yNyAgIGMtMC4yNzItMC4yNzQtMC43MTUtMC4yNzQtMC45ODksMEwwLjIwNCw4LjAxOWMtMC4yNzIsMC4yNzEtMC4yNzIsMC43MTcsMCwwLjk5bDYuMjE3LDYuMjU4YzAuMjcyLDAuMjcxLDAuNzE1LDAuMjcxLDAuOTksMCAgIEwxNy42Myw1LjA0N2MwLjI3Ni0wLjI3MywwLjI3Ni0wLjcyLDAtMC45OTRMMTYuMTQ1LDIuNTcxeiIgZmlsbD0iIzAwMDAwMCIvPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+Cjwvc3ZnPgo=' />");
                        setTimeout(function () {
                            $('#addToCart').html("<i style='margin-right: 1rem;color: inherit;font-size: 15px;' class='fa fa-cart-plus'></i>Aggiungi al Carrello");
                        }, 2000);
                    },
                    error: function () {
                        $('#addToCart').html("<img style='width: 10%;' src='data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTguMS4xLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4PSIwcHgiIHk9IjBweCIgdmlld0JveD0iMCAwIDI4IDI4IiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCAyOCAyODsiIHhtbDpzcGFjZT0icHJlc2VydmUiIHdpZHRoPSI1MTJweCIgaGVpZ2h0PSI1MTJweCI+CjxnPgoJPGcgaWQ9IngiPgoJCTxnPgoJCQk8cG9seWdvbiBwb2ludHM9IjI4LDIyLjM5OCAxOS41OTQsMTQgMjgsNS42MDIgMjIuMzk4LDAgMTQsOC40MDIgNS41OTgsMCAwLDUuNjAyIDguMzk4LDE0IDAsMjIuMzk4ICAgICAgNS41OTgsMjggMTQsMTkuNTk4IDIyLjM5OCwyOCAgICAiIGZpbGw9IiMwMDAwMDAiLz4KCQk8L2c+Cgk8L2c+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPC9zdmc+Cg==' />");
                        setTimeout(function () {
                            $('#addToCart').html("<i style='margin-right: 1rem;color: inherit;font-size: 15px;' class='fa fa-cart-plus'></i>Aggiungi al Carrello");
                        }, 2000);
                    }
                });
            }
        }
        //Remove prodotto dal carrello
        function removeProd(id, variante) {
            if (variante === null || variante === undefined) {
                $('#remove-' + id).parent().parent().css('background-color', 'rgba(128, 128, 128, 0.5)');
            } else {
                $('#remove-' + id + '-' + variante).parent().css('background-color', 'rgba(128, 128, 128, 0.5)');
            }
            $.ajax({
                type: "POST",
                url: "/Bortoleto/removeProd",
                data: {id: id, variante: variante},
                cache: false,
                success: function (response) {
                    updateCartSize();
                    $('#cd-cart').html(response);
                    updatePrefModal();
                },
                error: function () {
                    alert("Errore remove Prod");
                }
            });
        }
        //Svuota carrello
        function svuotaCarrello() {
            $.ajax({
                type: "POST",
                url: "/Bortoleto/removeAllProd",
                cache: false,
                success: function (response) {
                    updateCartSize();
                    $('#cd-cart').html(response);
                    updatePrefModal();
                },
                error: function () {
                    alert("Errore remove All Prod from cart");
                }
            });
        }
        //Update Quantity
        function updateQuantity(id, variante, quantita) {
            if (quantita > 0) {
                $.ajax({
                    type: "POST",
                    url: "/Bortoleto/updateQuantity",
                    data: {id: id, variante: variante, quantita: quantita},
                    cache: false,
                    success: function (response) {
                        updateCartSize();
                        $('#cd-cart').html(response);
                    },
                    error: function () {
                        alert("Errore update Quantity");
                    }
                });
            }
        }
        //Change Variante
        function changeVariante(element, prod, isQuick) {

            var string = ""; //contiene la concatenazione degli id delle varianti scelte per la combinazione di varianti
            var selects; // nel ciclo foreach seleziona tutti i select delle varianti
            var optionSelected; //nel ciclo foreach prende l'opzione scelta per ogni select delle varianti
        <c:choose>
            <c:when test="${array ne null && !array.isEmpty()}">
                <c:forEach items="${array}" var="varianti" >
            selects = $('#${varianti.get(0).variant.replace(" ", "")}-' + isQuick);
            optionSelected = selects[0].options[selects.prop('selectedIndex')].value;
            string += optionSelected + "_";
                </c:forEach>
            </c:when>
        </c:choose>
            string = string.substring(0, string.length - 1); //rimuovo l'ultimo carattere che è un _
            //immagine di caricamento
            $('#boxDati-' + isQuick).html("<img style='width: 40%;' src='/Bortoleto/img/91.gif' />");

            //Funzione ajax per aggiornare la schermata, il isQuick è un boolean e serve per capire se ci riferiamo al prodotto o al modal QuickView
            $.ajax({
                type: "POST",
                url: "/Bortoleto/ajax/changeVariante.jsp",
                data: {id: element.value, prod: prod, quick: isQuick, varianti: string},
                cache: false,
                success: function (response) {
                    $('#boxDati-' + isQuick).html(response);
                },
                error: function () {
                    $('#boxDati-' + isQuick).css("background-color", "red");
                    $('#boxDati-' + isQuick).html("ERRORE");
                }
            });
        }
        //Update CartSize
        function updateCartSize() {
            $.ajax({
                type: "GET",
                url: "/Bortoleto/ajax/updateCartSize.jsp",
                cache: false,
                success: function (response) {
                    $('#cartSize').html(response);
                },
                error: function () {
                    alert("Errore update cartSize");
                }
            });
        }
        //Update La pagina del carrello
        function updateCartCarrelloPage(val) {
            if (val !== null) {
                val = !val;
            }
            $.ajax({
                type: "GET",
                url: "/Bortoleto/ajax/cartCarrelloPage.jsp?val=" + val,
                cache: false,
                success: function (response) {
                    $('#cartCarrelloPage').html(response);
                    updateCartModalContent();
                },
                error: function () {
                    alert("Errore update cartCarrelloPage");
                }
            });
        }
        //Update Il modal del carrello
        function updateCartModalContent() {
            $.ajax({
                type: "GET",
                url: "/Bortoleto/ajax/carrelloModalContent.jsp",
                cache: false,
                success: function (response) {
                    $('#cd-cart').html(response);
                },
                error: function () {
                    alert("Errore update cartCarrelloPage");
                }
            });
        }
        //Apri il quick modal di un prodotto
        function quickViewProduct(id) {
            $.ajax({
                type: "POST",
                url: "/Bortoleto/ajax/quickViewProduct.jsp",
                data: {id: id},
                cache: false,
                success: function (response) {
                    $('#quickview-wrapper').html(response);
                    $('#' + id + '-Quick-Modal').modal('show');
                },
                error: function () {
                    alert("Errore Quick View Product");
                }
            });
        }
        /* Valuta il prodotto */
        function rate(val, prod) {
            $.ajax({
                type: "POST",
                url: "/Bortoleto/rateProd",
                data: {prod: prod, val: val},
                cache: false,
                success: function (dt, status, request) {
                    if (request.getResponseHeader('already_' + prod) === null || request.getResponseHeader('already_' + prod) !== "true") {
                        $('#ratingDiv').html("<h4 class='black-text text-center' style='font-family: \"Coming Soon\";'>Grazie per il tuo parere</h4>");
                    } else {
                        $('#ratingDiv').html("<h4 class='black-text text-center' style='font-family: \"Coming Soon\";'>Grazie, ma ci hai già fornito il tuo parere per questo prodotto</h4>");
                    }
                },
                error: function () {
                    alert("Errore rate prod");
                }
            });
        }
    </script>
    <script>
        $(function () {
            /* Preferiti modal */
            $("#fluidModalBottomDangerDemo").load("/Bortoleto/ajax/preferitiModalContent.jsp");

            /* Carrello Modal */
            $("#cd-cart").html("<img style='width: 40%;' src='/Bortoleto/img/91.gif' />");
            $("#cd-cart").load("/Bortoleto/ajax/carrelloModalContent.jsp");

            /* footer */
            $("#footer").load("/Bortoleto/ajax/footer.html");
        });
    </script>
    <script>
        function animation(div) {
            var card = div.parent('li').parent('.product__action').parent('.product__hover__info').parent(".product__inner").find('.pro__thumb').find('.lazy').eq(0);
            var cart = $('#cart-modal-trigger');
            var imgtodrag = div;
            if (imgtodrag) {
                var imgclone = card.clone()
                        .offset({
                            top: imgtodrag.offset().top,
                            left: card.offset().left
                        })
                        .css({
                            'border-radius': '100%',
                            'opacity': '1',
                            'position': 'absolute',
                            'height': '150px',
                            'width': '150px',
                            'z-index': '100',
                            'background-size': 'cover',
                            'background-position': 'center center'
                        })
                        .appendTo($('body'))
                        .animate({
                            'top': cart.offset().top + 10,
                            'left': cart.offset().left + 10,
                            'width': 50,
                            'height': 50
                        }, 1000, 'easeInOutExpo');

                setTimeout(function () {
                    cart.css({
                        'animation': 'shake 0.2s cubic-bezier(.37,.07,.19,.93)'
                    });
                    updateCartSize();
                }, 1100);
                cart.css({
                    'animation': 'none'
                });
                imgclone.animate({
                    'width': 0,
                    'height': 0
                }, function () {
                    $(this).detach();
                });
            }
        }

        /* Serve */
        $(function () {
            $('.lazy').lazy();
        });

        /* PEr l'esplora categorie dropdown perchè non si chiuda premendo all'interno */
        $(document).on('click', '#dropCat .dropdown-menu', function (e) {
            e.stopPropagation();
        });

        /* Quantity button */
        $(".cart-plus-minus").append('<div class="dec qtybutton">-</i></div><div class="inc qtybutton">+</div>');
        $(".qtybutton").on("click", function () {
            var $button = $(this);
            var oldValue = $button.parent().find("input").val();
            if ($button.text() == "+") {
                var newVal = parseFloat(oldValue) + 1;
            } else {
                // Don't allow decrementing below zero
                if (oldValue > 1) {
                    var newVal = parseFloat(oldValue) - 1;
                } else {
                    newVal = 1;
                }
            }
            $button.parent().find("input").val(newVal);
        });
    </script>
    <!-- Eventi facebook pixel -->
    <script type="text/javascript">
        $('#addToCart').click(function () {
            fbq('track', 'AddToCart', {
                content_name: '${prod.nome}',
                content_category: '${prod.categoria}',
                currency: 'EUR',
                contents: [
                    {
                        id: '${prod.id}',
                        quantity: $('#quantitaInput').val()
                    }
                ],
                value: ${prod.costo.replace(',','.')},
                content_ids: '${prod.id}',
                product_type: '${prod.categoria}',
                content_type: 'product'
            });
        });

        function addToPreferFacebookEvent() {
            fbq('track', 'AddToWishlist', {
                value: ${prod.costo.replace(',','.')},
                currency: 'EUR',
                content_ids: '${prod.id}',
                content_type: 'product',
                product_type: '${prod.categoria}',
                content_category: '${prod.categoria}'
            });
        }
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
