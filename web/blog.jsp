<%-- 
    Document   : blog
    Created on : 7-apr-2019, 15.28.17
    Author     : Roberto97
--%>

<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="request" value="<%=request%>"/>
<%@ page import="varie.Costanti" %>
<c:set value="<%=varie.Costanti.SPACES_COOKIE%>" var="SPACES_COOKIE" />
<c:set value="${catblogdao.getAllCatBlog()}" var="catblog" />
<c:set value="${blogdao.getAllBlogs()}" var="blogs" />
<c:set value="${blogdao.getMostViewedBlog()}" var="viewed" />
<c:set value="https://lh3.googleusercontent.com/Wqst0ZKSX3p3hdhouVcMzVdGOSdkHRYe4iXuSO5CdAdGGChBOSyTx9KfS7hWpSty6n1dPHaXGMMRBn3I-NCiwWEFQXWHoIwhaRpI1EtCyNOYrpCy1cny8DGVSr8OjpHzDHfH5Yhdqg=w2400" var="blurIMG"/>
${consoledao.incrementViews("blog", request, 0)}
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

        <meta property="og:url"           content="https://macelleriadellantonio.it<c:url value="/blog.jsp"/>" />
        <meta property="og:type"          content="website" />
        <meta property="og:title"         content="Il Blog de 'L Bortoleto - Storie di qualità delle specialità Trentine" />
        <meta property="og:description"   content="Scopri novità e aneddoti interessanti sulla storia e la qualità delle specialità gastronomiche Trentine che realizziamo - Blog de 'L Bortoleto" />
        <meta property="og:image"         content="/Bortoleto/img/logo2.png" />
        <meta property="fb:app_id"         content="320307085338651" />

        <link rel="icon" href="/Bortoleto/img/favicon.ico" sizes="16x16" >
        <title>Il Blog de 'L Bortoleto - Storie di qualità delle specialità Trentine</title>
        <meta name="Description" content="Scopri novità e aneddoti interessanti sulla storia e la qualità delle specialità gastronomiche Trentine che realizziamo - Blog de 'L Bortoleto">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="theme-color" content="#31353d">        

        <!-- bootstrap include -->
        <link rel="stylesheet nofollow" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet nofollow" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="/Bortoleto/css/mdb.min.css" rel="stylesheet nofollow">
        <link rel="stylesheet nofollow" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
        <!-- fine bootstrap include -->

        <!--include css -->
        <link rel="stylesheet nofollow" href="/Bortoleto/css/Cards-min.css" type="text/css">
        <link rel="stylesheet nofollow" href="/Bortoleto/css/style-min.css">
        <link rel="stylesheet nofollow" href="/Bortoleto/css/prodotto-min.css">
        <link rel="stylesheet nofollow" href="/Bortoleto/css/parallax.css">
        <link rel="stylesheet nofollow" href="/Bortoleto/css/font-min.css">
        <link rel="stylesheet nofollow" href="/Bortoleto/css/blog-min.css">
        <link rel="stylesheet nofollow" href="/Bortoleto/css/vari-min.css">
        <link rel="stylesheet nofollow" href="/Bortoleto/css/navbar-min.css">
        <!-- fine include css -->    
        <style> 
            html, body{
                overflow-x: unset;
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
    <div id="parallaxN2" style="margin-bottom: 5rem;" class="imgPara image-liquid image-holder--original parallax-window" data-parallax="scroll" data-image-src="/console/img/immagini_sito/blog/header-blog.jpg">
        <div class="effetto1">
            <div style="height: 30rem;">
                <div class="container cPara" style="">
                    <div class="customPaddingPara">
                        <h1 class="customStylePara">Il Blog de 'l Bortoleto</h1>
                        <p>Scopri novità e aneddoti interessanti sulla storia e la qualità delle specialità gastronomiche Trentine che realizziamo</p>
                    </div>
                </div>
                <div class="scrollIcon">
                    <a style="color: white;" href="#blog">
                        <i class="fas fa-chevron-down"></i>
                        <h5>Scorri</h5>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class='container' id="blog">
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
                                    <li><a style="cursor: pointer;" onclick="filter('PiuVisti');">Più letti</a></li>
                                    <li><a style="cursor: pointer;" onclick="filter('MenoVisti');">Meno Letti</a></li>
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
            <div id="Posts" class="col-lg-8">
                <c:choose>
                    <c:when test="${param.search != null}">
                        <h3 id="search_Result" class="black-text text-center">
                            Risultati della ricerca: '${param.search}'   
                            <a href="<c:url value="/blog.jsp"/>" style="cursor: pointer;">
                                <i class="red-text fas fa-times"></i>
                            </a>
                        </h3><br>
                        <c:set value="false" var="checkSearch" /> 
                        <c:forEach items="${blogs}" var="blog" >
                            <c:set var="commenti" value="${commblogdao.getAllCommOfBlog(blog.id).size()}" />
                            <c:if test="${blog.nome.toLowerCase().contains(param.search.replace('+', ' ').toLowerCase()) || blog.categoria.toLowerCase().contains(param.search.replace('+', ' ').toLowerCase())}">
                                <div class="row mb-4 Post">
                                    <div class="col-lg-4  col-md-4 meta-details" style="text-align: right;  margin-top: 35px;">
                                        <ul class="tags key" style="padding-left: 0px;">
                                            <li><a href="<c:url value="/blog.jsp?cat=${blog.categoria.replace(' ', '-')}"/>" class="categoriaArt tagLink">${blog.categoria}</a><i class="fas fa-stream ml-2" style="color: black;"></i></li>
                                        </ul>
                                        <ul class="tags realTags key black-text textOverflow">
                                            <c:forEach items="${blogdao.getAllTextTagsOfBlog(blog.id)}" var="tag" >
                                                <li>
                                                    <a class="tagLink" href="<c:url value="/blog.jsp?tag=${tag.replace(' ', '-')}"/>">#${StringUtils.capitalize(tag.toLowerCase())}</a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                        <div class="user-details row detailPost">
                                            <p style="padding-left: 0px;" class="user-name col-lg-12 col-md-12 col-6"><a style="color: #757777;">${blog.creatore}</a><i class="far fa-user" style="color: black;"></i></p>
                                            <p style="padding-left: 0px;" class="date col-lg-12 col-md-12 col-6"><a style="color: #757777;">${blog.data.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))}</a> <i class="far fa-calendar-alt" style="color: black;"></i></span></p>
                                            <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6"><a style="color: #757777;">${commenti} Commenti</a> <i class="far fa-comment" style="color: black;"></i></p>
                                            <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6"><a style="color: #757777;">${blog.views} Letture</a> <i class="far fa-eye" style="color: black;"></i></p>
                                        </div>
                                    </div>
                                    <div class="col-lg-8 col-md-8 ">
                                        <div class="feature-img text-center">
                                            <img class="lazy img-fluid blogIMG" data-src="/${blog.immagine}" alt="${blog.nome}">
                                        </div>
                                        <a class="posts-title" href="<c:url value="/articolo.jsp?id=${blog.id}&nome=${blog.nome.replace(' ', '-')}"/>">
                                            <h2 class="textOverflow nomeArt mt-3">${blog.nome}</h2>
                                        </a>
                                        <p class="excert textOverflow">
                                            ${blog.descrizione}
                                        </p>
                                        <a href="<c:url value="/articolo.jsp?id=${blog.id}&nome=${blog.nome.replace(' ', '-')}"/>" class="primary-btn btn btn-outline-brown mb-5" style="padding-top: 0; padding-bottom: 0;">Leggi l'articolo</a>
                                    </div>
                                </div>
                                <c:set value="true" var="checkSearch" />   
                            </c:if>
                        </c:forEach>
                        <c:if test="${checkSearch == false}">
                            <h4 id="noProd" class="black-text text-center">Non ci sono articoli che corrispondono alla ricerca: '${param.search}'</h4>
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
                                <c:set var="cat" value="${catblogdao.getCatByName(param.cat.replace('-', ' '))}" />
                                <nav id="breadcrumb">
                                    <ol class="cd-breadcrumb custom-separator" itemscope itemtype="https://schema.org/BreadcrumbList">
                                        <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                            <a itemprop="item" href="<c:url value="/#Bortoleto"/>"><span itemprop="name">Home</span></a>
                                            <meta itemprop="position" content="1" />
                                        </li>
                                        <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                            <a itemprop="item" href="<c:url value="/blog.jsp"/>"><span itemprop="name">Il Blog</span></a>
                                            <meta itemprop="position" content="2" />
                                        </li>
                                        <li class="current" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                            <a itemprop="item" href="<c:url value="/blog.jsp?cat=${param.cat}"/>"><span itemprop="name">${param.cat.replace('-', ' ')}</span></a>
                                            <meta itemprop="position" content="3" />
                                        </li>
                                    </ol>
                                </nav>
                                <h2>${param.cat}</h2>
                                <c:choose>
                                    <c:when test="${blogdao.hasVisibileBlogs(cat.id_cat) eq true}">
                                        <c:set value="${blogdao.getAllBlogsOfCategory(cat.id_cat)}" var="blogs" />
                                        <h2 class="mt-5 mb-5 black-text"><i class="fas fa-stream mr-2" style="color: black;"></i>${cat.nome}</h2>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set value="${null}" var="cat" />
                                            <c:set value="${null}" var="blogs" />
                                        </c:otherwise>
                                    </c:choose>
                                <!-- blogs = getAllBlogOfCategory() 
                                if blogs is void -> no category found
                                -->
                            </c:when>
                            <c:when test="${param.tag != null}">
                                <c:set value="${param.tag.replace('-', ' ')}" var="tag" />
                                <c:set value="${blogdao.getAllBlogsWithTag(blogdao.getIDTag(param.tag.replace('-', ' ')))}" var="blogs" />
                                <nav id="breadcrumb">
                                    <ol class="cd-breadcrumb custom-separator" itemscope itemtype="https://schema.org/BreadcrumbList">
                                        <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                            <a itemprop="item" href="<c:url value="/#Bortoleto"/>"><span itemprop="name">Home</span></a>
                                            <meta itemprop="position" content="1" />
                                        </li>
                                        <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                            <a itemprop="item" href="<c:url value="/blog.jsp"/>"><span itemprop="name">Il Blog</span></a>
                                            <meta itemprop="position" content="2" />
                                        </li>
                                        <li class="current" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                            <a itemprop="item" href="<c:url value="/blog.jsp?tag=${param.tag}"/>"><span itemprop="name">${tag}</span></a>
                                            <meta itemprop="position" content="3" />
                                        </li>
                                    </ol>
                                </nav>
                                <h2 class="mt-5 mb-5 black-text"><i class="fas fa-tag mr-2" style="color: black;"></i>${tag}</h2>
                                <!-- blog = getAllBlogWithTag() -->
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${blogs == null || blogs.isEmpty()}">
                                <h4 class="mt-5 mb-5 black-text">Nessun articolo trovato</h4>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${blogs}" var="blog" >
                                    <c:set var="commenti" value="${commblogdao.getAllCommOfBlog(blog.id).size()}" />
                                    <div class="row mb-4 Post">
                                        <div class="col-lg-4  col-md-4 meta-details" style="text-align: right;  margin-top: 35px;">
                                            <ul class="tags key black-text" style="padding-left: 0px;">
                                                <li>
                                                    <a class="tagLink" href="<c:url value="/blog.jsp?cat=${blog.categoria.replace(' ', '-')}"/>" class="categoriaArt">${blog.categoria}</a>
                                                    <i class="fas fa-stream ml-2" style="color: black;"></i>
                                                </li>
                                            </ul>

                                            <ul class="tags realTags key black-text textOverflow mt-2">
                                                <c:forEach items="${blogdao.getAllTextTagsOfBlog(blog.id)}" var="tag" >
                                                    <li>
                                                        <a class="tagLink" href="<c:url value="/blog.jsp?tag=${tag.replace(' ', '-')}"/>">#${StringUtils.capitalize(tag.toLowerCase())}</a>
                                                    </li>
                                                </c:forEach>

                                            </ul>
                                            <div class="user-details row detailPost">
                                                <p style="padding-left: 0px;" class="user-name col-lg-12 col-md-12 col-6"><a style="color: #757777;">${blog.creatore}</a><i class="far fa-user" style="color: black;"></i></p>
                                                <p style="padding-left: 0px;" class="date col-lg-12 col-md-12 col-6"><a style="color: #757777;">${blog.data.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))}</a> <i class="far fa-calendar-alt" style="color: black;"></i></span></p>
                                                <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6"><a style="color: #757777;">${commenti} Commenti</a> <i class="far fa-comment" style="color: black;"></i></p>
                                                <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6"><a style="color: #757777;">${blog.views} Letture</a> <i class="far fa-eye" style="color: black;"></i></p>
                                            </div>
                                        </div>
                                        <div class="col-lg-8 col-md-8 ">
                                            <div class="feature-img text-center">
                                                <img class="lazy img-fluid blogIMG" data-src="/${blog.immagine}" alt="${blog.nome}">
                                            </div>
                                            <a class="posts-title" href="<c:url value="/articolo.jsp?id=${blog.id}&nome=${blog.nome.replace(' ', '-')}"/>">
                                                <h2 class="textOverflow nomeArt mt-3">${blog.nome}</h2>
                                            </a>
                                            <div class="excert textOverflow" style="color: #000000 !important">
                                                ${blog.descrizione}
                                            </div>
                                            <a href="<c:url value="/articolo.jsp?id=${blog.id}&nome=${blog.nome.replace(' ', '-')}"/>" class="primary-btn btn btn-outline-brown mb-5" style="padding-top: 0; padding-bottom: 0;">Leggi l'articolo</a>
                                        </div>
                                    </div>  
                                </c:forEach>
                                <h3 id="noProd" class="black-text text-center invisible">Non ci sono articoli che corrispondono alla ricerca</h3>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="col-lg-4 sidebar-widgets">
                <div class="widget-wrap">
                    <div class="single-sidebar-widget">
                        <a href='<c:url value="/blog.jsp"/>'><h5><i class="fas fa-arrow-left mr-2"></i>Torna a tutti gli articoli</h5></a>
                    </div>
                    <div class="single-sidebar-widget search-widget">
                        <form class="search-form" action="<c:url value="/blog.jsp#blog"/>">
                            <input id="myInput2" onkeyup="myFunction2();" class="search_input" type="text" placeholder="Cerca post..." name="search">
                            <button type="submit" id="searchButton" aria-label="Cerca articoli"><i class="fas fa-search"></i></button>
                        </form>
                    </div>
                    <c:if test="${!viewed.isEmpty()}">
                        <div class="single-sidebar-widget popular-post-widget">
                            <h4 class="personalized popular-title">Articoli più letti</h4>
                            <div class="popular-post-list">
                                <c:forEach items="${viewed}" var="v" >
                                    <div class="single-post-list d-flex flex-row align-items-center">
                                        <div class="thumb">
                                            <img style="width: 150px;" class="img-fluid" src="/${v.immagine}" alt="${v.nome}">
                                        </div>
                                        <div class="details">
                                            <a href="<c:url value="/articolo.jsp?id=${v.id}&nome=${v.nome.replace(' ', '-')}"/>">
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
                        <h4 class="category-title">Catgorie di articoli</h4>
                        <ul class="cat-list">
                            <li>
                                <a href="/Bortoleto/Il-Blog" class="d-flex justify-content-between">
                                    <p>Tutti</p>
                                    <p>${blogs.size()}</p>
                                </a>
                            </li> 
                            <c:forEach items="${catblog}" var="cat" >
                                <c:if test="${blogdao.hasVisibileBlogs(cat.id_cat) eq true}">
                                    <li>
                                        <a href="<c:url value="/blog.jsp?cat=${cat.nome.replace(' ', '-')}"/>" class="d-flex justify-content-between">
                                            <p>${cat.nome}</p>
                                            <p>${catblogdao.getNumberOfBlog(cat.nome)}</p>
                                        </a>
                                    </li> 
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>
                    <c:if test="${!blogdao.getAllTags().isEmpty()}">
                        <div class="single-sidebar-widget tag-cloud-widget">
                            <h4 class="tagcloud-title">Tags</h4>
                            <ul>
                                <c:forEach items="${blogdao.getAllTags()}" var="tag" >
                                    <li>
                                        <a href="<c:url value="/blog.jsp?tag=${blogdao.getTagName(tag).replace(' ', '-')}"/>">${StringUtils.capitalize(blogdao.getTagName(tag).toLowerCase())}</a>
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
                                        <input type="email" class="form-control" id="emailSub2" name='email' <c:if test="${email ne null}">value="${email.replace(SPACES_COOKIE, " ")}"</c:if> placeholder="La tua email" required/>
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
            table = document.getElementById("Posts");
            tr = table.getElementsByClassName("Post");
            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByClassName("nomeArt")[0];
                td1 = tr[i].getElementsByClassName("categoriaArt")[0];
                if (td || td1) {
                    txtValue = td.textContent || td.innerText;
                    txtValue1 = td1.textContent || td1.innerText;
                    $("#search_Result").removeClass('invisible');
                    if (txtValue.toUpperCase().indexOf(filter) > -1 || txtValue1.toUpperCase().indexOf(filter) > -1) {
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
            var table = document.getElementById("Posts");
            var tr = table.getElementsByClassName("Post");
            for (var i = 0; i < tr.length; i++) {
                tr[i].style.display = "";
            }
            $("#search_Result").addClass('invisible');
            $("#noProd").addClass('invisible');
        }

        function filter(id) {

            var cate = null, search = null, tag = null;
            cate = '${param.cat}';
            search = '${param.search}';
            tag = '${param.tag}';

            if (cate !== null && cate.trim() === '') {
                cate = null;
            }
            if (search !== null && search.trim() === '') {
                search = null;
            }
            if (tag !== null && tag.trim() === '') {
                tag = null;
            }
            switch (id) {

                case("PiuVisti"):
                    $.ajax({
                        type: "POST",
                        url: "/Bortoleto/ajax/blogOrder.jsp",
                        data: {order: id, cat: cate, search: search, tag: tag},
                        cache: false,
                        success: function (response) {
                            $('#Posts').html(response);
                        },
                        error: function () {
                            alert("Errore update Order Type");
                        }
                    });
                    break;
                case("MenoVisti"):
                    $.ajax({
                        type: "POST",
                        url: "/Bortoleto/ajax/blogOrder.jsp",
                        data: {order: id, cat: cate, search: search, tag: tag},
                        cache: false,
                        success: function (response) {
                            $('#Posts').html(response);
                        },
                        error: function () {
                            alert("Errore update Order Type");
                        }
                    });
                    break;
                case("PiuRecenti"):
                    $.ajax({
                        type: "POST",
                        url: "/Bortoleto/ajax/blogOrder.jsp",
                        data: {order: id, cat: cate, search: search, tag: tag},
                        cache: false,
                        success: function (response) {
                            $('#Posts').html(response);
                        },
                        error: function () {
                            alert("Errore update Order Type");
                        }
                    });
                    break;
                case("MenoRecenti"):
                    $.ajax({
                        type: "POST",
                        url: "/Bortoleto/ajax/blogOrder.jsp",
                        data: {order: id, cat: cate, search: search, tag: tag},
                        cache: false,
                        success: function (response) {
                            $('#Posts').html(response);
                        },
                        error: function () {
                            alert("Errore update Order Type");
                        }
                    });
                    break;
            }
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
                url: "/Bortoleto/emailSub",
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
