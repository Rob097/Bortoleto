<%-- 
    Document   : articolo
    Created on : 18-apr-2019, 18.32.21
    Author     : Roberto97
--%>

<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="request" value="<%=request%>"/>
<c:set value="${catblogdao.getAllCatBlog()}" var="catblog"/>
<c:set value="${blogdao.getAllBlogs()}" var="blogs"/>
<c:set value="${blogdao.getMostViewedBlog()}" var="viewed"/>
<c:if test="${param.id ne null && param.nome ne null && param.id ne '' && param.nom ne '' && param.nome eq blogdao.getBlogById(param.id).nome.replace(' ', '-')}">
    <c:set value="${blogdao.getBlogById(param.id)}" var="blog"/>
    <c:set value="${commblogdao.getAllCommOfBlog(blog.id)}" var="commenti"/>
    ${blogdao.incrementViews(blog.id, blog.views, request)}
    ${consoledao.incrementViews("blog", request, param.id)}
</c:if>
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
        
        <meta property="og:url"           content="https://macelleriadellantonio.it<c:url value="/articolo.jsp?id=${blog.id}&nome=${blog.nome.replace(' ', '-')}"/>">
        <meta property="og:type"          content="website">
        <meta property="og:title"         content="${blog.nome}">
        <meta property="og:description"   content="${blog.descrizione}">
        <meta property="og:image"         content="https://www.macelleriadellantonio.it/console/${blog.immagine}">
        <meta property="fb:app_id"        content="320307085338651">

        <link rel="icon" href="/Bortoleto/img/favicon.ico" sizes="16x16" >
        <title>${blog.nome}</title>
        <meta name="Description" content="${blog.descrizione}">
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
            .overGold:hover{
                color: #b4505a;
                transition: 0.3s;
            }
            .mwfc{
                max-width: fit-content;
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
    <div id="parallaxN2" class="imgPara image-liquid image-holder--original parallax-window" data-parallax="scroll" data-image-src="https://lh3.googleusercontent.com/qn-cGonjNTsmXcCpTuCHvVF2-ii8N5OOqnjKdPQOT9iTX93xNmyhPUUH5jtVZsXOhuVu2CAT8HpRFb258aOErpE7Kph-TftmfpvVd93MdsLDFbVBi76j22MiM92wliBTqE_jTK6E8vy7Ilck0Td0mRepKvbmgRCK1Nlz_z2VSRb6StTYUW6b5XUL5W7sEHSZZqKxyC2Q_qV97HQ4rA2i2kWhexD6eC88byii6ku3r67dUfY70fKhqLGK5Tn7Y3jLaf_K0uNFmr5vqHu5-cow_egftD5Wn9upI-B_HJ7ZdIdA_78o7DdmBY2rKjJsp6rdVH7dMiMIuxv3WLmhbpkfalAIVDjb3Y3EfLYOtdPQopdETR7uX5B47PNoFMi1I_bNo_ZLWB0e3owNu14kANdaybjIjdeGRE_s2K1fyIRXMK7s12BdfefrcPJJz3Gw74Z8XfhfJALqxVXsC9HXSyxk65L-5XHfZzsqQ26LPl6NtmCroAJQ9M6Pi6f68-ydHd3s9HzaV0HIcly19YYAE7rH35bJcy1l5WndpoC7ZvEBNoPj3xv7yrGBmU0tqh07H4oTfdxwqzfzLj_0ltqfHmKtax3NUrUrWC9chvN9vkGxC6GmZIkJoke_IcD87WdrGFfM25o4dTx8GYzz9a6rv0sJ_kUpzsX2zmw=w1560-h763-no">
        <div class="effetto1">
            <div style="height: 30rem;">
                <div class="container cPara" style="">
                    <div class="customPaddingPara">
                        <h1 class="customStylePara">Il Blog de 'l Bortoleto</h1>
                    </div>
                </div>
                <div class="scrollIcon">
                    <a style="color: white;" href="#articolo" aria-label="Scorri in basso"><i class="fas fa-chevron-down"></i></a>
                    <h5>Scorri</h5>
                </div>
            </div>
        </div>
    </div>

    <section class="post-content-area single-post-area" id="articolo">
        <div class='container'>
            <div class="row mt-5">
                <div class="col-lg-8 posts-list">
                    <c:choose>
                        <c:when test="${empty param.id || blog == null}">
                            <div class="text-center mt-5 mb-5 container">
                                <i style="color: #ff3547;" class="far fa-frown fa-4x mb-3 animated rotateIn"></i>
                                <h4 style="margin-top: 2rem; color: black;">Questo articolo non esiste</h4>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="single-post row">
                                <div class="col-lg-12 img-margin-bottom-large">
                                    <div class="feature-img" style="text-align: center;">
                                        <img class="lazy img-fluid" data-src="/${blog.immagine}" alt="${blog.nome}" style="max-height: 500px; border-radius: 10px; box-shadow: 0px 0px 30px rgba(0, 0, 0, 0.64);">
                                    </div>
                                </div>
                                <div class="col-lg-3  col-md-3 meta-details" style="text-align: right;  margin-top: 35px;">
                                    <ul class="tags" style="padding: 0;">
                                        <li><a href="<c:url value="/blog.jsp?cat=${blog.categoria.replace(' ', '-')}"/>" class="categoriaArt">${blog.categoria}</a><i class="fas fa-stream ml-2" style="color: black;"></i></li>
                                    </ul>
                                    <ul class="tags realTags key black-text textOverflow">
                                        <c:forEach items="${blogdao.getAllTextTagsOfBlog(blog.id)}" var="tag" >
                                            <li>
                                                <a class="tagLink" href="<c:url value="/blog.jsp?tag=${tag.replace(' ', '-')}"/>">#${StringUtils.capitalize(tag.toLowerCase())}</a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                    <div class="user-details row">
                                        <p class="personalized user-name col-lg-12 col-md-12 col-6">${blog.creatore}<i class="far fa-user ml-2" style="color: black;"></i></p>
                                        <p class="right-small personalized date col-lg-12 col-md-12 col-6">${blog.data.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))}<i class="far fa-calendar-alt ml-2" style="color: black;"></i></p>                                            
                                        <p class="personalized comments col-lg-12 col-md-12 col-6"><a href="#commenti">${commenti.size()} Commenti</a> <i class="far fa-comment" style="color: black;"></i></p>
                                        <p class="right-small personalized view col-lg-12 col-md-12 col-6">${blog.views} Letture<i class="far fa-eye ml-2" style="color: black;"></i></p>
                                        <ul class="social-links col-lg-12 col-md-12 col-12 center-small mb-5">
                                            <li><a aria-label="Condividi su Facebook" target="_blank" rel="noopener" href="https://www.facebook.com/dialog/share?app_id=320307085338651&display=popup&href=https://macelleriadellantonio.it/<c:url value="/articolo.jsp?id=${blog.id}&nome=${blog.nome.replace(' ', '-')}"/>&redirect_uri=https://macelleriadellantonio.it/<c:url value="/articolo.jsp?id=${blog.id}&nome=${blog.nome.replace(' ', '-')}"/>"><i class="fab fa-facebook-f overGold"></i></a></li>
                                            <li><a aria-label="Condividi su Twitter" target="_blank" rel="noopener" href="https://twitter.com/intent/tweet?url=https://macelleriadellantonio.it/<c:url value="/articolo.jsp?id=${blog.id}&nome=${blog.nome.replace(' ', '-')}"/>&text=${blog.nome}"><i class="fab fa-twitter overGold"></i></a></li>
                                        </ul>
                                        <div id="ratingDiv" class="no-padding mb-5 personalized center-small col-lg-12 col-md-12 col-12">
                                            <c:set var="rate" value="${blogdao.getRate(blog.id)}" />
                                            <label class="text-muted">${blogdao.getNumberRate(blog.id)} valutazioni (${rate} <i class="far fa-star"></i>)</label><br>
                                            <fieldset class="rating text-center" style="display: initial;">
                                                <input onclick="rate($(this).val(), ${blog.id});" type="radio" id="star5" name="rating" value="5" <c:if test="${rate >= 5}">checked</c:if> /><label class = "full" for="star5" title="5 stelle"></label>
                                                <input onclick="rate($(this).val(), ${blog.id});" type="radio" id="star4half" name="rating" value="4.5" <c:if test="${rate >= 4.5 && rate < 5}">checked</c:if>/><label class="half" for="star4half" title="4.5 stelle"></label>
                                                <input onclick="rate($(this).val(), ${blog.id});" type="radio" id="star4" name="rating" value="4" <c:if test="${rate >= 4 && rate < 4.5}">checked</c:if>/><label class = "full" for="star4" title="4 stelle"></label>
                                                <input onclick="rate($(this).val(), ${blog.id});" type="radio" id="star3half" name="rating" value="3.5" <c:if test="${rate >= 3.5 && rate < 4}">checked</c:if>/><label class="half" for="star3half" title="3.5 stelle"></label>
                                                <input onclick="rate($(this).val(), ${blog.id});" type="radio" id="star3" name="rating" value="3" <c:if test="${rate >= 3 && rate < 3.5}">checked</c:if>/><label class = "full" for="star3" title="3 stelle"></label>
                                                <input onclick="rate($(this).val(), ${blog.id});" type="radio" id="star2half" name="rating" value="2.5" <c:if test="${rate >= 2.5 && rate < 3}">checked</c:if>/><label class="half" for="star2half" title="2.5 stelle"></label>
                                                <input onclick="rate($(this).val(), ${blog.id});" type="radio" id="star2" name="rating" value="2" <c:if test="${rate >= 2 && rate < 2.5}">checked</c:if>/><label class = "full" for="star2" title="2 stelle"></label>
                                                <input onclick="rate($(this).val(), ${blog.id});" type="radio" id="star1half" name="rating" value="1.5" <c:if test="${rate >= 1.5 && rate < 2}">checked</c:if>/><label class="half" for="star1half" title="1.5 stelle"></label>
                                                <input onclick="rate($(this).val(), ${blog.id});" type="radio" id="star1" name="rating" value="1" <c:if test="${rate >= 1 && rate < 1.5}">checked</c:if>/><label class = "full" for="star1" title="1 stella"></label>
                                                <input onclick="rate($(this).val(), ${blog.id});" type="radio" id="starhalf" name="rating" value="0.5" <c:if test="${rate >= 0.5 && rate < 1}">checked</c:if>/><label class="half" for="starhalf" title="0.5 stelle"></label>
                                                </fieldset><br>                                
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-9 col-md-9">
                                        <h1 class="personalized mt-20 mb-20" style="min-height: fit-content; margin-top: 0px; margin-bottom: 23px; padding: 0px; font-family: Montserrat, sans-serif; font-weight: 800; font-size: 45px; color: rgb(74, 74, 74);">${blog.nome}</h1>
                                    <div class="personalized excert" style="font-family: 'Roboto', sans-serif !important; text-align: justify;">
                                        ${blog.testo}
                                    </div>
                                </div>
                            </div>
                            <c:set var="collegamenti" value="false"/>
                            <c:choose>
                                <c:when test="${blogdao.getProductTagsOfBlog(blog.id) eq null || blogdao.getProductTagsOfBlog(blog.id).isEmpty()}">
                                    <c:choose>
                                        <c:when test="${blogdao.getCategoryTagsOfBlog(blog.id) eq null || blogdao.getCategoryTagsOfBlog(blog.id).isEmpty()}">

                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="collegamenti" value="true"/>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="collegamenti" value="true"/>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${collegamenti eq true}">
                                <div id="carousel-example-multi" class="carousel slide carousel-multi-item v-2 white-text" data-ride="carousel">

                                    <div class="carousel-inner" role="listbox" style="overflow-y: hidden; overflow-x: scroll;">
                                        <h4 class="Cherry_Swash center15 black-text">Legati all'articolo</h4>

                                        <div style="margin-top: 1.5rem; display: inline-flex;" class="carousel-item active">
                                            <c:forEach items="${blogdao.getProductTagsOfBlog(blog.id)}" var="prod" >
                                                <c:set var="simile" value="${productdao.getProduct(prod)}" />
                                                <div class="col-md-4 zoomSlide">
                                                    <a target="blank" href="<c:url value="/prodotto.jsp?id=${simile.id}&nome=${simile.nome.replace(' ', '-')}&cat=${simile.categoria.replace(' ', '-')}" />">
                                                        <div class="card mb-2" style="border-radius: 5%;">
                                                            <div class="image-liquid image-holder--original card-img-top" style=" background-image: url('/${simile.immagine}');height: 15rem;" alt="${simile.nome}"></div>                                            
                                                            <div class="card-body">
                                                                <h4 class="card-title font-weight-bold black-text">${simile.nome}</h4>
                                                            </div>
                                                        </div>
                                                    </a>
                                                </div>
                                            </c:forEach>
                                            <c:forEach items="${blogdao.getCategoryTagsOfBlog(blog.id)}" var="cat" >
                                                <c:set var="simile" value="${categorydao.getById(cat)}" />
                                                <div class="col-md-4 zoomSlide">
                                                    <a target="blank" href="<c:url value="/categoria.jsp?id=${simile.id}&nome=${simile.nome.replace(' ', '-')}" />">
                                                        <div class="card mb-2" style="border-radius: 5%;">
                                                            <div class="image-liquid image-holder--original card-img-top" style=" background-image: url('/${simile.immagine}');height: 15rem;" alt="${simile.nome}"></div>                                            
                                                            <div class="card-body">
                                                                <h4 class="card-title font-weight-bold black-text">${simile.nome}</h4>
                                                            </div>
                                                        </div>
                                                    </a>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <hr class="mt-5 mb-5" style="border: 3px solid rgb(121, 85, 72); width: 50%; border-radius: 100%;">
                            <div class="navigation-area">
                                <div class="row">
                                    <c:set value="${blogdao.getPrevOrNextById(false, param.id - 1)}" var="prev" />
                                    <div class="col-lg-6 col-md-6 col-12 nav-left flex-row d-flex justify-content-start align-items-center">
                                        <c:if test="${prev != null}">                                            
                                            <div class="thumb">
                                                <a href="<c:url value="/articolo.jsp?id=${prev.id}&nome=${prev.nome.replace(' ', '-')}"/>"><img style="width: 150px;" class="lazy img-fluid" data-src="/${prev.immagine}" alt="${prev.nome}"></a>
                                            </div>
                                            <div class="detials" style="max-width: inherit;">
                                                <p class="personalized">Articolo precedente</p>
                                                <a href="<c:url value="/articolo.jsp?id=${prev.id}&nome=${prev.nome.replace(' ', '-')}"/>">
                                                    <h4 class="personalized">${prev.nome}</h4>
                                                </a>
                                            </div>                                            
                                        </c:if>
                                    </div>
                                    <c:set value="${blogdao.getPrevOrNextById(true, param.id + 1)}" var="next" />
                                    <div class="col-lg-6 col-md-6 col-12 nav-right flex-row d-flex justify-content-end align-items-center">
                                        <c:if test="${next != null}">                                            
                                            <div class="detials" style="max-width: inherit;">
                                                <p class="personalized">Articolo successivo</p>
                                                <a href="<c:url value="/articolo.jsp?id=${next.id}&nome=${next.nome.replace(' ', '-')}"/>">
                                                    <h4 class="personalized">${next.nome}</h4>
                                                </a>
                                            </div>
                                            <div class="thumb">
                                                <a href="<c:url value="/articolo.jsp?id=${next.id}&nome=${next.nome.replace(' ', '-')}"/>"><img style="width: 150px;" class="lazy img-fluid" data-src="/${next.immagine}" alt="${next.nome}"></a>
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
                                                        ${commento.commento}
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="comment-form">
                                <h4 class="personalized mb-3">Lascia un commento</h4>
                                <form method="POST" action="/Bortoleto/postBlogComment">
                                    <div class="form-group">
                                        <label class="black-text" for="nome">Nome</label>
                                        <input type="text" class="form-control" id="nome" name="nome" placeholder="Il tuo nome" required="">
                                    </div>
                                    <div class="form-group">
                                        <label class="black-text" for="commento">Commento</label>
                                        <textarea class="form-control mb-10" rows="5" id="commento" name="commento" placeholder="Commento" required=""></textarea>
                                    </div>
                                    <input type="hidden" name="idBlog" value="${blog.id}">
                                    <input type="hidden" name="titoloBlog" value="${blog.nome.replace(' ', '-')}">
                                    <div id="recaptcha"><div class="g-recaptcha" data-sitekey="6Ld8YaAUAAAAAKDIu30P3tuRfUuPw-XgFHd9_J5U" data-callback="enableBtn"></div></div>
                                    <input id="postButton" type="submit" class="btn primary-btn" value="PUBBLICA COMMENTO" disabled>
                                </form>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-lg-4 sidebar-widgets">
                    <div class="widget-wrap">
                        <div class="single-sidebar-widget">
                            <a href='<c:url value="/blog.jsp"/>'><h1><i class="fas fa-arrow-left mr-2"></i>Torna a tutti gli articoli</h1></a>
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
                                    <a href="<c:url value="/blog.jsp"/>" class="d-flex justify-content-between">
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

        function rate(val, prod) {
            $.ajax({
                type: "POST",
                url: "/Bortoleto/rateBlog",
                data: {blog: prod, val: val},
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
