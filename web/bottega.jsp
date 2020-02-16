<%-- 
    Document   : bottega
    Created on : 1-feb-2019, 16.10.19
    Author     : Roberto97
--%>

<%@page import="database.entities.Prodotto"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="cons" class="varie.Costanti" scope="session"/>
<c:set var="request" value="<%=request%>"/> <!-- Request lo chiamo con una scriplets e lo salvo in una variabile perchè serve per diversi metodi java -->
<c:set var="response" value="<%=response%>"/> <!-- Response lo chiamo con una scriplets e lo salvo in una variabile perchè serve per diversi metodi java -->
<c:set value="${productdao.getAllProductsOfCart(request)}" var="prodottiCart" />
<c:set value="${productdao.getTotalOfCart(request)}" var="subTotaleCart" />
<c:set value="${pagamentodao.getSpeseSpedizione(subTotaleCart, ritiroAttribute, request)}" var="spedizioneCart" />
<c:set value="${pagamentodao.getTot(subTotaleCart, spedizioneCart)}" var="totaleCart" />
${consoledao.incrementViews("bottega", request, 0)}
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
        
        <meta property="og:url"           content="https://macelleriadellantonio.it<c:url value="/bottega.jsp"/>" />
        <meta property="og:type"          content="website" />
        <meta property="og:title"         content="Bottega online - Acquista specialità artigianali del Trentino" />
        <meta property="og:description"   content="Acquista online i prodotti della Macelleria Dellantonio 'l Bortoleto. Salumi e formaggi artigianali della Val di Fiemme, Trentino Alto Adige" />
        <meta property="og:image"         content="/Bortoleto/img/logo2.png" alt="Salumi online"/>
        <meta property="og:site_name" content="Macelleria Ristorante Dellantonio 'L Bortoleto">
        <meta property="fb:app_id"         content="320307085338651" />

        <link rel="icon" href="/Bortoleto/img/favicon.ico" sizes="16x16"  alt="Salumi online">
        <title>Bottega online - Acquista specialità artigianali del Trentino</title>
        <meta name="Description" content="Acquista online i prodotti della Macelleria Dellantonio 'l Bortoleto. Salumi e formaggi artigianali della Val di Fiemme, Trentino Alto Adige">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="theme-color" content="#312e2e">

        <!-- bootstrap include -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="/Bortoleto/css/mdb.min.css" rel="stylesheet">
        <!-- fine bootstrap include -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">

        <!--include css -->
        <link rel="stylesheet" href="/Bortoleto/css/Cards-min.css" type="text/css">
        <link rel="stylesheet" href="/Bortoleto/css/style-min.css">
        <link rel="stylesheet" href="/Bortoleto/css/parallax.css">
        <link rel="stylesheet" href="/Bortoleto/css/font-min.css">
        <link rel="stylesheet" href="/Bortoleto/css/bottegaCSS-min.css">
        <link rel="stylesheet" href="/Bortoleto/css/navbar-min.css">
        <link rel="stylesheet" href="/Bortoleto/css/vari-min.css">
        <link rel="stylesheet" href="/Bortoleto/css/prodotto-min.css">
        <style>
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

<body id="topPage" class="foo" data-spy="scroll" data-target=".sidebar">
    <a href="#topPage" id="myBtn45" title="Torna in cima" class="rightGray"><i class="fas fa-angle-up"></i></a>
    <!-- Ricerca di prodotti -->
    <div class="div-search-icon">
        <a class="search_icon" aria-label="Cerca Prodotti" data-toggle="tooltip" title="Cerca un Prodotto"><i class="fa fa-search"></i></a>
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
    <div id="cd-shadow-layer"></div>

    <div id="cd-cart">

    </div> <!-- cd-cart --> 

    <!-- Fine navbar -->

    <div id="parallaxN2" style="margin-bottom: 5rem;" class="imgPara image-liquid image-holder--original parallax-window" data-parallax="scroll" data-image-src="/console/img/ico/feature_BG.jpg">
        <div class="effetto1">
            <div style="height: 30rem;">
                <div id="carouselContent" class="carousel slide" data-interval="8500" data-ride="carousel" style="height: 100%; border-radius: 20px; color: white; font-weight: bold;">
                    <div class="carousel-inner" role="listbox">
                        <div class="carousel-item active text-center p-4"><i style="color: #86070f;" class="fas fa-store icon carouselIco"></i>
                            <h1 class="carouselTitle">Bottega Online</h1>
                            <p class="carouselText">Un servizio semplice e intuitivo per acquistare comodamente e in modo sicuro tutti i nostri prodotti da casa tua!</p>
                        </div>
                        <div class="carousel-item text-center p-4"><i style="color: #86070f;" class="fas fa-map-marker-alt icon carouselIco"></i>
                            <h3 class="carouselTitle">Spedizioni alimenti freschi</h3>
                            <p class="carouselText">I nostri prodotti vengono spediti con un sistema brevettato
                                e certificato per garantire il mantenimento delle proprietà organolettiche.<br>                                                                       
                            </p>
                            <a style="color: white !important;" href="http://www.keatchen.it" target="_blank">
                                Scopri di più su come funziona Keatchen!<br>
                                <img alt="KeatchenLogo" style="width: 20%;" src="/console/img/ico/keatchen.jpg"/>
                            </a>
                        </div>
                        <div class="carousel-item text-center p-4"><i style="color: #86070f;" class="fas fa-chalkboard-teacher icon carouselIco"></i>
                            <h3 class="carouselTitle">Scegli la qualità</h3>
                            <p class="carouselText">Tutti i prodotti acquistabili da questo negozio online, così come nei nostri punti vendita, vengono realizzati scegliendo materie di prima qualità e lavorandole con passione e professionalità da ormai 5 generazioni</p>
                        </div>
                        <div class="carousel-item text-center p-4"><i style="color: #86070f;" class="fas fa-shield-alt icon carouselIco"></i>
                            <h3 class="carouselTitle">Pagamenti sicuri</h3>
                            <p class="carouselText">Paga in modo semplice e sicuro con il sistema di pagamento di Phoenix s.p.a.</p>
                        </div>
                        <div class="carousel-item text-center p-4"><i style="color: #86070f;" class="fas fa-heart icon carouselIco"></i>
                            <h3 class="carouselTitle">Salva i tuoi prodotti preferiti</h3>
                            <p class="carouselText">Salva nei preferiti i prodotti che acquisti più spesso e scopri sempre nuove idee nella nuova sezione <i>Idee in cucina</i></p>
                        </div>
                    </div>
                    <a class="carousel-control-prev" data-target="#carouselContent" role="button" data-slide="prev">
                        <span aria-hidden="true"><i style="color: white; font-size: xx-large;" class="fas fa-angle-left"></i></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" data-target="#carouselContent" role="button" data-slide="next">
                        <span aria-hidden="true"><i style="color: white; font-size: xx-large;" class="fas fa-angle-right"></i></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
                <div class="scrollIcon">
                    <a style="color: black;" href="#categorie">
                        <i class="fas fa-chevron-down"></i>
                        <h5>Scorri</h5>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container" style="margin-top: 5rem;">
        <section id="categorie">
            <p class="sottotitoli" style="text-align: center; margin: 5rem auto 0 auto;">Scegli la qualità</p>
            <h4 class='consigliati-h4'>Scegli tra...</h4>
            <div class="row">
                <div class="col-md-6">
                    <a href="<c:url value="/alimenti-freschi.jsp"/>">
                        <div class="categoria-principale-box">
                            <div class='img-cat'>
                                <img src="/Bortoleto/img/carne-bortoleto.jpg" />
                            </div>
                            <h2><%=varie.Costanti.FRESCHI%></h2>
                            <p class="sottotitoli">Carne 100% Locale</p>
                        </div>
                    </a>
                </div>
                <div class="col-md-6">
                    <a href="<c:url value="/dal-trentino.jsp"/>">
                        <div class="categoria-principale-box">
                            <div class='img-cat'>
                                <img src="/console/img/prodotti/confezionati/7.jpg" />
                            </div>
                            <h2><%=varie.Costanti.TRENTINO%></h2>
                            <p class="sottotitoli">Prodotti Artigianalmente</p>
                        </div>
                    </a>
                    <a style="margin-top: 10px; display: flex;" href="<c:url value="/idee.jsp"/>">
                        <div class='idee-img-ad-box'></div>
                    </a>
                </div>
            </div>
        </section>

        <c:set var="suggestedProds" value="<%=varie.Costanti.suggeriti%>"/>
        <c:if test="${suggestedProds ne null}">
            <section id="consigliati" class="consigliati-box">
                <p class="sottotitoli" style="text-align: center; margin: 10rem auto 0 auto;">I migliori della settimana</p>
                <h4 class="consigliati-h4">Oggi ti Consigliamo</h4>

                <!-- 4 prodotti da scegliere a random ogni lunedì a mezzanotte -->
                <div class="row prodotti-box text-center">
                    <c:forEach items="${suggestedProds}" var="prodotto" >
                        <div class="col-lg-3 col-md-6">
                            <div class="product">
                                <div class="product__inner">
                                    <div class="pro__thumb">
                                        <a style="cursor: default;">
                                            <img src="/${prodotto.immagine}" alt="${prodotto.nome}" class="lazy">
                                        </a>
                                    </div>
                                    <div class="product__hover__info">
                                        <ul class="product__action">
                                            <c:choose>
                                                <c:when test="${prodotto.isDisponibile() eq true}">
                                                    <li><a onclick="quickViewProduct(${prodotto.id});" title="Anteprima" class="quick-view modal-view detail-link"><i class="fas fa-search"></i></a></li>
                                                    <li><a title="Aggiungi ${prodotto.nome} al carrello" onclick="addProd(${prodotto.id}); animation($(this));"><i class="fas fa-cart-plus"></i></a></li>
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
    </div>
    <!--container.//-->



    <!-- Footer -->

    <footer id="footer" class="container-fluid text-center footer">

    </footer>

    <!-- MODAL -->

    <div class="modal fade bottom" id="fluidModalBottomDangerDemo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"  aria-hidden="true">
    </div>

    <!-- QUICKVIEW PRODUCT -->
    <div id="quickview-wrapper">
    </div>
    <!-- END QUICKVIEW PRODUCT -->
    <!-- FINE MODAL -->

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.7.2/js/all.js" integrity="sha384-0pzryjIRos8mFBWMzSSZApWtPl/5++eIfzYmTgBBmXYdhvxPc+XcFEk+zJwDgWbP" crossorigin="anonymous"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="/Bortoleto/js/mdb.min.js">async;</script>
    <script src="/Bortoleto/js/vari-min.js" async></script>
    <script src="/Bortoleto/js/modernizr-min.js" async></script>
    <script src="/Bortoleto/js/main-min.js" async></script>
    <script src="/Bortoleto/js/parallax.js"></script>
    <script src="/Bortoleto/js/nav.js"></script>
    <script type="text/javascript" src="/Bortoleto/js/jquery.lazy.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script>
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
        $(function () {
            $(".HeartAnimation").click(function () {
                $(this).toggleClass("animate");
            });
        });</script>

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
        //Remove Preferito
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
        //Remove prodotto al carrello
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
        //Update CartSize
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
        //Update CartSize
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
        //Update Quantity
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
        /* Preferiti modal */
        $(function () {
            $("#fluidModalBottomDangerDemo").load("/Bortoleto/ajax/preferitiModalContent.jsp");
        });
        /* Carrello Modal */
        $(function () {
            $("#cd-cart").load("/Bortoleto/ajax/carrelloModalContent.jsp");
        });
        /* footer */
        $(function () {
            $("#footer").load("/Bortoleto/ajax/footer.html");
        });</script>
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
        ;
        $(function () {
            $('.lazy').lazy();
        });
        $(document).on('click', '#dropCat .dropdown-menu', function (e) {
            e.stopPropagation();
        });
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
