<%-- 
    Document   : home2
    Created on : 4-lug-2019, 16.40.57
    Author     : Roberto97
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="request" value="<%=request%>"/>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="year" value="${now}" pattern="yyyy" />
${consoledao.incrementViews("home", request, 0)}
<!DOCTYPE html>
<html lang="en" id="html">
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

        <!-- OpenGraph metaTags -->
        <meta property="og:url"           content="https://macelleriadellantonio.it/Bortoleto/" />
        <meta property="og:type"          content="website" />
        <meta property="og:title"         content="Ristorante Macelleria 'L Bortoleto" />
        <meta property="og:description"   content="Ristorante Macelleria 'L Bortoleto. Qualità e tradizione delle specialità Trentine dal 1901. Predazzo Val di Fiemme (Trentino)." />
        <meta property="og:image"         content="/Bortoleto/img/logo2.png" alt="Ristorante Macelleria"/>
        <meta property="og:site_name" content="Ristorante Macelleria Dellantonio 'L Bortoleto">

        <!-- Microdati per Facebook Pixel -->
        <meta property="fb:app_id"         content="320307085338651" />

        <!-- MetaDati per Google e Sito Web-->
        <link rel="icon" href="/Bortoleto/img/favicon.ico" sizes="16x16" alt="Macelleria Dellantonio favicon">
        <title>Ristorante Macelleria 'L Bortoleto</title>
        <meta name="Description" content="Ristorante Macelleria 'L Bortoleto. Qualità e tradizione delle specialità Trentine dal 1901. Predazzo Val di Fiemme (Trentino).">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="theme-color" content="#31353d">

        <!-- CSS include -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
        <!--miei css -->
        <link href="css/mdb.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/Cards-min.css" type="text/css">
        <link rel="stylesheet" href="css/style-min.css">
        <link rel="stylesheet" href="css/font-min.css">
        <link rel="stylesheet" href="css/vari-min.css">
        <link rel="stylesheet" href="css/animations-min.css">
        <link rel="stylesheet" href="css/macelleriaCSS-min.css">
        <link href="css/mouseScroll.css" rel="stylesheet">
        <link href="css/home-min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/navbar-min.css">
        <!-- fine include css -->

        <style>      
            .divNotify{
                width: 100%;
                position: fixed;
                z-index: 1111;
                bottom: 0;
            }
            .alert{    
                position: relative;
                padding: .75rem 1.25rem;
                margin-bottom: 1rem;
                border: 1px solid transparent;
                border-radius: .25rem;
                z-index: 1111;
                bottom: 20px;
                background-color: gray;
                width: 75%;
                margin: auto;
            }
            .row.is-flex {
                display: flex;
                flex-wrap: wrap;
            }
            .row.is-flex > [class*='col-'] {
                display: flex;
                flex-direction: column;
            }
            .is-flex .box {
                background: none;
                position: static;
            }

        </style>

        <!-- Script per la cookie policy -->
        <script type="text/javascript">
            var _iub = _iub || [];
            _iub.csConfiguration = {"lang": "it", "siteId": 1636253, "cookiePolicyId": 77217510, "cookiePolicyUrl": "https://macelleriadellantonio.it/Bortoleto/file/PrivacyPolicy.pdf", "banner": {"acceptButtonDisplay": true, "customizeButtonDisplay": true, "position": "float-bottom-center", "consentOnScroll": true}};
        </script><script type="text/javascript" src="//cdn.iubenda.com/cs/iubenda_cs.js" charset="UTF-8" async></script>

        <!-- Markup JSON-LD generato da Assistente per il markup dei dati strutturati di Google. -->
        <script type="application/ld+json">
            [ {
            "@context" : "http://schema.org",
            "@type" : "LocalBusiness",
            "name" : "'L Bortoleto",
            "image" : "/Bortoleto/img/logo2.png",
            "telephone" : "0462501231",
            "email" : "info@macelleriadellantonio.it",
            "address" : {
            "@type" : "PostalAddress",
            "streetAddress" : "Via Cesare Battisti 2",
            "addressLocality" : "Predazzo",
            "addressRegion" : "TN",
            "addressCountry" : "Predazzo",
            "postalCode" : "38037"
            },
            "url" : "https://macelleriadellantonio.it/Bortoleto/"
            }, {
            "@context" : "http://schema.org",
            "@type" : "LocalBusiness",
            "name" : "'L Bortoleto",
            "image" : "/Bortoleto/img/logo2.png",
            "telephone" : "0462500261",
            "email" : "ristorantebortoleto@gmail.com",
            "address" : {
            "@type" : "PostalAddress",
            "streetAddress" : "Via Cavour 2",
            "addressLocality" : "Predazzo",
            "addressRegion" : "TN",
            "addressCountry" : "Predazzo",
            "postalCode" : "38037"
            },
            "url" : "https://macelleriadellantonio.it/Bortoleto/"
            } ]
        </script>

        <!-- MailChimp -->
        <script id="mcjs">!function (c, h, i, m, p) {
                m = c.createElement(h), p = c.getElementsByTagName(h)[0], m.async = 1, m.src = i, p.parentNode.insertBefore(m, p)
            }(document, "script", "https://chimpstatic.com/mcjs-connected/js/users/fc0d39903de646248e86c6e77/0858107de1b109770a0de8df4.js");</script>

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
        <noscript>
    <img height="1" width="1" style="display:none" src="https://www.facebook.com/tr?id=467659847403449&ev=PageView&noscript=1" alt="Facebook"/>
    </noscript>
    <!-- End Facebook Pixel Code -->
</head>
<body id="topPage">

    <!-- Load Facebook SDK for JavaScript for chat -->
    <div id="fb-root"></div>
    <script>
        window.fbAsyncInit = function () {
            FB.init({
                xfbml: true,
                version: 'v5.0'
            });
        };

        (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id))
                return;
            js = d.createElement(s);
            js.id = id;
            js.src = 'https://connect.facebook.net/it_IT/sdk/xfbml.customerchat.js';
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));</script>
    <!-- Your customer chat code -->
    <div class="fb-customerchat"
         attribution=setup_tool
         page_id="1216082258524051"
         theme_color="#b4505a"
         logged_in_greeting="Ciao! Come possiamo aiutarti?"
         logged_out_greeting="Ciao! Come possiamo aiutarti?">
    </div>

    <!-- Scroll to top  -->
    <a href="#LBortoleto" id="myBtn45" data-toggle="tooltip" title="Torna in cima" class="rightGray"><i class="fas fa-angle-up"></i></a>

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

    <section id="LBortoleto" class="image-liquid image-holder--original parallax-window" data-parallax="scroll" data-image-src="/Bortoleto/img/carne-bortoleto.jpg">
        <div class="effetto1" style="height: 100%;background-color: rgba(0, 0, 0, 0.3);position: relative;">
            <div class="row first" style='margin-left: unset;'>
                <div class="col-12">
                    <svg id="scrittaLogo" width='100%'>                    
                    <text y="70%" fill="none" class="scrittalogo">
                    <tspan x="50%" text-anchor="middle">'L Bortoleto</tspan>
                    </text>                     
                    </svg>
                </div>                       
            </div>
            <div class="second">
                <p class='sottotitolo-sezione-inizio'>Da oltre 110 anni qualità della tradizione trentina.</p>
                <a href="<c:url value="/bottega.jsp" />" class='btn bottone-sezione-inizio'>BOTTEGA ONLINE</a><br>
                <a href="#ristorante-macelleria"><i style="color: white; font-size: 30px;" class="fas fa-long-arrow-alt-down"></i></a>
            </div>
        </div>
    </section>
    <section id='ristorante-macelleria'>
        <div class="et_pb_top_inside_divider ui-sortable-handle divider-custom divider5"></div>
        <div class="container">
            <h4 class="sottotitoli" style="text-align: right;">nel cuore delle dolomiti</h4>       
            <h1 class="styled" style="text-align: right; margin: 0;">Ristorante Macelleria</h1>
            <div class="row">
                <div class="col-lg-6 mt-5">
                    <div class="rwd-video">
                        <iframe src="https://www.youtube.com/embed/9-3If8AhVwM?autoplay=0&loop=1&mute=1" allowfullscreen="" frameborder="0" height="315" width="560" title="Ristorante Macelleria 'l Bortoleto" alt="Ristorante Macelleria 'l Bortoleto">
                        </iframe>
                    </div>
                </div>
                <div class="col-lg-6 mt-5">
                    <p class="description">
                        Le radici della nostra attività, risalenti a più di <em><strong>110 anni fa</strong></em>, hanno origine a 
                        <em><strong>Predazzo</strong></em> in <strong>val di Fiemme</strong> (Trentino).<br>
                        La passione per il nostro lavoro ci ha sempre spronato a realizzare prodotti di altissima qualità e, arrivati alla quinta generazione noi de 'l Bortoleto, 
                        abbiamo deciso di puntare ancor di più sulle <strong>specialità trentine</strong> allargandoci da macelleria a <strong>ristorante-macelleria</strong> 
                        nel centro storico di Predazzo.</p>
                    <p class="description">Con un <strong>ristorante macelleria</strong>, quello che 'l <strong>Bortoleto</strong> vuole offrire è un'esperienza a 360° nelle specialità 
                        trentine attraverso un percorso che tratta la <strong>qualità nel piatto</strong> partendo dalle <em>materie prime km0</em>, dalla <em>stagionalità</em> 
                        degli alimenti e dalla <em>cura nelle lavorazioni</em>, da sempre fondamentale per la nostra azienda.<br />Rappresentiamo una delle poche realtà di <strong>
                            ristorante e macelleria italiana</strong> presenti sul territorio e questo è motivo di orgoglio e di costante impegno per garantire la qualità in ogni momento.
                    </p>
                    <p class="description">In questo sito web potrai facilmente 
                        <a title="Bottega Online" href="https://macelleriadellantonio.it/bottega-online/" target="_blank"><em>acquistare</em></a> 
                        la maggior parte dei nostri prodotti, <a title="Blog" href="https://macelleriadellantonio.it/Il-Blog/" target="_blank"><em>leggere curiosità</em></a> 
                        sulle lavorazioni e sulle materie prime che utilizziamo e 
                        <a title="Idee in Cucina" href="https://macelleriadellantonio.it/Idee-in-Cucina/" target="_blank"><em>scoprire</em></a> 
                        nuovi e curiosi modi per consumare i prodotti che più ti incuriosiranno.
                    </p>
                    <div style="width: 100%; text-align: center; z-index: 1;">
                        <a href="<c:url value="/bottega.jsp" />" target="_blank" rel="noopener" class="btn btnAcquista">bottega online</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="qualita-e-professionalita">
        <div class="et_pb_top_inside_divider ui-sortable-handle divider-custom divider1"></div>
        <h4 class="sottotitoli" style="text-align: center;">genuinità, qualità e professionalità</h4>  
        <h3 class="styled" style="text-align: center; margin: 0;">Facciamo la differenza</h3>

        <div class="container">
            <div class="row mt-5 mb-5" style="color: black;">
                <div class="col-lg-3 col-sm-6 col-12 mb-3">
                    <div class="colonna-differenza">
                        <img style="margin-bottom: 20px; border-radius: 10px;" src="/Bortoleto/img/carne-bortoleto-2.jpg" alt="Carne Bortoleto"/>
                        <h4 class="text-center dif-title">La Carne</h4>
                        <p class="text-justify dif-text">Carne <b>100% locale</b> per garantire la filiera km 0</p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6 col-12 mb-3">
                    <div class="colonna-differenza">
                        <img style="margin-bottom: 20px; border-radius: 10px;" src="https://lh3.googleusercontent.com/_9xxFzu_7b9aCTwjGLPo97BQekEZgacVTc0QOmxR8W4ZeimdgyG5o_pxfjmZgAt6by3nnlarJq3QK3Bqlge7s7uMW5g79wtehuwpEynl3uXqBPe72lwb0O3PCnFXzZh_CtCQWZv3fw=w2400"  alt="Salumi Bortoleto"/>
                        <h4 class="text-center dif-title">I Salumi</h4>
                        <p class="text-justify dif-text">Salumi <b>artigianali</b> di produzione propria</p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6 col-12 mb-3">
                    <div class="colonna-differenza">
                        <img style="margin-bottom: 20px; border-radius: 10px;" src="https://lh3.googleusercontent.com/pjWgsveuneUrnCfNthRdRicB26kwGxL01Y02ylIW6l5Fjc8c1Fs530OmN0EmCJAzsEE8r5FH0FAkc08paawpuI1Dhgrcbd4_1f9U87ssm9nGi3l0UOZhFe0pWC9RdZc7yc3qDKzwZA=w2400"  alt="Formaggi Bortoleto"/>
                        <h4 class="text-center dif-title">I Formaggi</h4>
                        <p class="text-justify dif-text">Formaggi dalle valli di <b>Fiemme e Fassa</b> e dalle principali <b>malghe</b></p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6 col-12 mb-3">
                    <div class="colonna-differenza">
                        <img style="margin-bottom: 20px; border-radius: 10px;" src="https://lh3.googleusercontent.com/fkXKCJwVtcnrEVe0AeqaZFFhzZxRjKxyRUEu-bJdbuYfH7psjeWpPrlqQ6RBxRvisCerGxSOjf1aep-VMypYWjZha_IK1bvK1Jz_WSXn-qBFsrlqKnzxClgf8a91NrscQroUyenNSw=w2400"  alt="Prodotti Bortoleto"/>
                        <h4 class="text-center dif-title">Il Trentino</h4>
                        <p class="text-justify dif-text">Prodotti di eccellenze trentine come la <b>farina di Storo</b>, la <b>pasta Felicetti</b> e molto altro</p>
                    </div>
                </div>
            </div>
            <hr style="border: 3px solid rgb(121, 85, 72); width: 50%; border-radius: 100%;"/>
            <div class="row mt-5 mb-5" style="color: white;">
                <div class="col-lg-3 col-sm-6 col-12 mb-3">
                    <div class="colonna-differenza text-center">
                        <i class="fas fa-hourglass-start exp-ico"></i><br>
                        <p>
                            <span class='numscroller exp-counter' data-min='0' data-max='${year - 1901}' data-delay='4' data-increment='1'>${year - 1901}</span><br>
                            <span class="exp-text">Anni di servizio</span>
                        </p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6 col-12 mb-3">
                    <div class="colonna-differenza text-center">
                        <img style="width: 50%; margin-bottom: 20px;" src="/Bortoleto/img/family.svg" alt="Famiglia"/><br>
                        <p>
                            <span class='numscroller exp-counter' data-min='0' data-max='5' data-delay='4' data-increment='1'>5</span><br>
                            <span class="exp-text">Generazioni</span>
                        </p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6 col-12 mb-3">
                    <div class="colonna-differenza text-center">
                        <img style="width: 50%; margin-bottom: 20px;" src="/Bortoleto/img/butcher.svg"  alt="Persone"/><br>
                        <p>
                            <span class='numscroller exp-counter' data-min='0' data-max='20' data-delay='4' data-increment='1'>20</span><br>
                            <span class="exp-text">Persone nella famiglia 'L Bortoleto</span>
                        </p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6 col-12 mb-3">
                    <div class="colonna-differenza text-center">
                        <img style="width: 50%; margin-bottom: 20px;" src="/Bortoleto/img/shop.svg"  alt="Negozi"/><br>
                        <p>
                            <span class='numscroller exp-counter' data-min='0' data-max='4' data-delay='4' data-increment='1'>4</span><br>
                            <span class="exp-text">Punti in cui ci puoi trovare</span>
                        </p>
                    </div>
                </div>
            </div>
            <hr style="border: 3px solid rgb(121, 85, 72); width: 50%; border-radius: 100%;"/>
            <div class="row mt-5" style="color: white;">
                <div class="col-lg-3 col-sm-6 col-12 mb-3">
                    <div class="colonna-differenza text-center">
                        <i class="fas fa-truck exp-ico"></i><br>
                        <h4 class="text-center dif-title">Consegne veloci</h4>
                        <p>Consegna in 24/48 ore dalla spedizione</p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6 col-12 mb-3">
                    <div class="colonna-differenza text-center">
                        <i class="fas fa-box-open exp-ico"></i><br>
                        <h4 class="text-center dif-title">Spedizioni refrigerate</h4>
                        <p>Spedizioni a temperatura controllata KEATCHEN in tutta Italia</p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6 col-12 mb-3">
                    <div class="colonna-differenza text-center">
                        <i class="fas fa-credit-card exp-ico"></i><br>
                        <h4 class="text-center dif-title">Pagamenti Sicuri</h4>
                        <p>Paga in modo semplice e sicuro con il sistema di pagamento Virtual Pay di Phoenix</p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6 col-12 mb-3">
                    <div class="colonna-differenza text-center">
                        <i class="fas fa-question exp-ico"></i><br>
                        <h4 class="text-center dif-title">Qualche problema?</h4>
                        <p>
                            Per qualsiasi problema o domanda non esitare a contattarci <a href="tel:0462501231" aria-label="Chiama la Sede di Predazzo">telefonicamente</a>
                            o per <a href="mailto:info@macelleriadellantonio.it" aria-label="Scrivi un email">email</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="i-nostri-servizi" style="padding-top: 4rem;">
        <h3 class="styled" style="text-align: center; margin: 0; color: white; margin-bottom: 8rem;">Da dove iniziare...</h3>
        <div class="container">
            <div class="row white-text"style="margin-bottom: 6rem;">
                <div class="col-lg-8" style="margin-bottom: 2rem; text-align: center;">
                    <img src="/Bortoleto/img/logo2.png"  alt="Bottega Online"/>
                </div>
                <div class="col-lg-4 text-center">
                    <h2 class="dif-title mb-5">Bottega Online</h2>
                    <p class="servizi-text">Servizio <strong>semplice</strong> e <strong>sicuro</strong> per poter ordinare comodamente da casa tutti i prodotti sia <strong>confezionati</strong> sia <strong>freschi</strong> con imballaggi certificati <strong>KEATCHEN</strong>.
                        La specialità artigianali Trentine direttamente dalla val di Fiemme a casa tua. In <strong>24 ore</strong>.</p>
                    <div style="width: 100%; text-align: center; z-index: 1;">
                        <a href="<c:url value="/bottega.jsp" />" target="_blank" rel="noopener" class="btn btnAcquista" style="padding: 12px 20px;">ordina ora</a>
                    </div>
                </div>
            </div>

            <div class="row white-text flex-column-reverse flex-lg-row" style="margin-bottom: 6rem;">
                <div class="col-lg-4 text-center">
                    <h2 class="dif-title mb-5">La Macelleria</h2>
                    <p class="servizi-text">La passione per il nostro lavoro ci permette, da ormai <strong>5 generazioni</strong>, di garantire la più alta qualità a tutti i nostri clienti con un servizio <em><strong>familiare</strong> </em>e curato.
                        Un secolo di cura e innovazione portata avanti da una passione comune. <strong><i>Il mangiar bene e sano</i></strong>.</p>
                    <div style="width: 100%; text-align: center; z-index: 1;">
                        <a href="<c:url value="/macelleria.jsp" />" target="_blank" rel="noopener" class="btn btnDiscover">Scopri di più</a>
                    </div>
                </div>
                <div style="margin-bottom: 2rem;" class="col-lg-8 servizi-divImage image-liquid image-holder--original parallax-window"  data-parallax="scroll" data-image-src="/Bortoleto/img/sedi/PredazzoNegozio/negozio1.jpg">

                </div>
            </div>

            <div class="row white-text" style="margin-bottom: 6rem;">
                <div style="margin-bottom: 2rem;" class="col-lg-8 servizi-divImage image-liquid image-holder--original parallax-window"  data-parallax="scroll" data-image-src="/Bortoleto/img/sedi/Ristorante/Ristorante-Bortoleto-Predazzo.jpg">

                </div>
                <div class="col-lg-4 text-center">
                    <h2 class="dif-title mb-5">Il Ristorante</h2>
                    <p class="servizi-text">Ai piedi delle <strong>Dolomiti</strong> offriamo un esperienza gastronomica a km 0 in grado di soddisfare i palati più fini. <strong>Vieni a trovarci</strong> a Predazzo in via Cavour 2 per capire come la <strong>qualità nel piatto</strong> riesce a fare la differenza.</p>
                    <div style="width: 100%; text-align: center; z-index: 1;">
                        <a href="<c:url value="/ristorante.jsp" />" target="_blank" rel="noopener" class="btn btnDiscover">Scopri di più</a>
                    </div>
                </div>
            </div>

            <div class="row white-text flex-column-reverse flex-lg-row" style="margin-bottom: 6rem;">
                <div class="col-lg-4 text-center">
                    <h2 class="dif-title mb-5">Il Blog</h2>
                    <p class="servizi-text">Il lato <strong>professionale</strong> e attendo dietro ad ogni aspetto del nostro lavoro fa si che ogni <strong>scelta</strong> derivi da attente <strong>riflessioni</strong>. Da oggi puoi scoprire come garantiamo la <strong>qualità</strong> partendo dalle <strong>materie prime</strong> e passando per le giuste <strong>lavorazioni</strong> con articoli utili e interessanti.
                    </p>
                    <div style="width: 100%; text-align: center; z-index: 1;">
                        <a href="<c:url value="/blog.jsp" />" target="_blank" rel="noopener" class="btn btnDiscover">Scopri di più</a>
                    </div>
                </div>
                <div style="margin-bottom: 2rem;" class="col-lg-8 servizi-divImage image-liquid image-holder--original parallax-window"  data-parallax="scroll" data-image-src="/Bortoleto/img/sfondo-blog.jpg">

                </div>
            </div>

            <div class="row white-text">
                <div style="margin-bottom: 2rem;" class="col-lg-8 servizi-divImage image-liquid image-holder--original parallax-window"  data-parallax="scroll" data-image-src="/Bortoleto/img/idee-sfondo.jpg">

                </div>
                <div class="col-lg-4 text-center">
                    <h2 class="dif-title mb-5">Idee in Cucina</h2>
                    <p class="servizi-text">Se non sai come poter usare i prodotti che ti offriamo o semplicemente hai voglia di provare <strong>qualcosa di nuovo</strong>, dai uno sguardo alla nostra sezione sulle <strong>idee in cucina</strong>.
                        Hai qualche idea interessante? Faccela sapere, saremo lieti di renderti partecipe!
                    </p>
                    <div style="width: 100%; text-align: center; z-index: 1;">
                        <a href="<c:url value="/idee.jsp" />" target="_blank" rel="noopener" class="btn btnDiscover">Scopri di più</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="social-div">
            <h4 class="sottotitoli" style="text-align: center; color: #bfbfbf;">ci trovi anche su</h4>
            <p class="sottotitoli text-center" style="font-weight: inherit; margin-top: 2rem; color: white;">MACELLERIA</p>
            <ul id="services">
                <li>
                    <div class="facebook">
                        <a target="_blank" rel="nofollow" href="https://www.facebook.com/macelleriadellantonio/">
                            <i class="fab fa-facebook-f" aria-hidden="true"></i>
                        </a>
                    </div>
                    <span>Facebook</span>
                </li>
                <li>
                    <div class="instagram">
                        <a target="_blank" rel="nofollow" href="https://www.instagram.com/macelleriabortoleto/">
                            <i class="fab fa-instagram" aria-hidden="true" alt="macelleria dellantonio instagram"></i>
                        </a>
                    </div>
                    <span>Instagram</span>
                </li>
                <li>
                    <div class="twitter">
                        <a target="_blank" rel="nofollow" href="https://twitter.com/bortoleto_mac">
                            <i class="fab fa-twitter" aria-hidden="true"></i>
                        </a>
                    </div>
                    <span>Twitter</span>
                </li>
                <li>
                    <div class="youtube">
                        <a target="_blank" rel="nofollow" href="https://www.youtube.com/watch?v=9-3If8AhVwM">
                            <i class="fab fa-youtube" aria-hidden="true"></i>
                        </a>
                    </div>
                    <span>YouTube</span>
                </li>
                <li>
                    <div class="linkedin">
                        <a target="_blank" rel="nofollow" href="https://www.linkedin.com/company/macelleria-dellantonio/">
                            <i class="fab fa-linkedin" aria-hidden="true"></i>
                        </a>
                    </div>
                    <span>Linkedin</span>
                </li>
                <li>
                    <div class="pinterest">
                        <a target="_blank" rel="nofollow" href="https://www.pinterest.it/macelleriabortoleto/">
                            <i class="fab fa-pinterest" aria-hidden="true"></i>
                        </a>
                    </div>
                    <span>Pinterest</span>
                </li>
            </ul>
            <p class="sottotitoli text-center" style="font-weight: inherit; margin-top: 2rem; color: white;">RISTORANTE</p>
            <ul id="services">
                <li>
                    <div class="facebook">
                        <a target="_blank" rel="nofollow" href="https://www.facebook.com/LBortoleto/">
                            <i class="fab fa-facebook-f" aria-hidden="true"></i>
                        </a>
                    </div>
                    <span>Facebook</span>
                </li>
                <li>
                    <div class="instagram">
                        <a target="_blank" rel="nofollow" href="https://www.instagram.com/ristorantebortoleto/">
                            <i class="fab fa-instagram" aria-hidden="true"></i>
                        </a>
                    </div>
                    <span>Instagram</span>
                </li>
            </ul>
        </div>
    </section>

    <section id="dicono-di-noi">
        <div class="et_pb_top_inside_divider ui-sortable-handle divider-custom divider2"></div>

        <div class="container">
            <h4 class="sottotitoli" style="text-align: center;">testimonials</h4>  
            <h3 class="styled" style="text-align: center; margin: 0;">Dicono di noi</h3>

            <div class="row mt-5">
                <div class="col-lg-3 col-sm-6 col-12 mb-5">
                    <img src="/Bortoleto/img/stars.png"  alt="Valutazione"/>
                    <h4 class="testimonial-title">Federica Targa</h4>
                    <p class="testimonial-text">
                        “Come sempre la carne è ottima, l'arte del mestiere appare nel modo di tagliarla e offrirla al cliente e la gentilezza e la disponibilità senza confronti ogni giorno.”
                    </p>
                    <span style="color: #1f1f1f;">Macelleria Predazzo, Google</span>                    
                </div>
                <div class="col-lg-3 col-sm-6 col-12 mb-5">
                    <img src="/Bortoleto/img/stars.png" alt="Valutazione"/>
                    <h4 class="testimonial-title">Simone Melegaro</h4>
                    <p class="testimonial-text">
                        “Qualità dei prodotti ottima. Personale gentile e competente.”
                    </p>
                    <span style="color: #1f1f1f;">Macelleria Campitello, Google</span>     
                </div>
                <div class="col-lg-3 col-sm-6 col-12 mb-5">
                    <img src="/Bortoleto/img/stars.png" alt="Valutazione"/>
                    <h4 class="testimonial-title">Mattea Eccher</h4>
                    <p class="testimonial-text">
                        “Bell'ambiente, ottimo rapporto qualità-prezzo, grande disponibilità e attenzione nella proposta anche per i clienti con esigenze particolari (io sono celiaca e vegetariana). Consigliatissimo!”
                    </p>
                    <span style="color: #1f1f1f;"> Ristorante, Facebook</span>     
                </div>
                <div class="col-lg-3 col-sm-6 col-12 mb-5">
                    <img src="/Bortoleto/img/stars.png" alt="Valutazione"/>
                    <h4 class="testimonial-title">Prandi Patrizio</h4>
                    <p class="testimonial-text">
                        “Due cene in pochissimi giorni ma tutte e due eccellenti. Servizio pronto e discreto. Pietanze calde e qualità alta. Vini in lista eccellenti con prezzi onestissimi. Ci rivedremo eccome.”
                    </p>
                    <span style="color: #1f1f1f;">Ristorante, Tripadvisor</span>     
                </div>
            </div>

            <div class="et_pb_top_inside_divider ui-sortable-handle divider-custom divider3"></div>
            <h4 class="sottotitoli" style="text-align: center;">non perderti anche</h4>  
            <h3 class="styled" style="text-align: center; margin: 0 0 20px 0;">Articoli recenti</h3>

            <div class="row">
                <div id="prima-colonna-articoli" class="col-lg-6 col-12 mb-5 bordo-verticale">
                    <h5 class="testimonial-text text-center">L'ultima novità dal nostro blog</h5>
                    <c:set var="lastBlog" value="${blogdao.getLastBlog()}" />
                    <c:if test="${lastBlog ne null}">
                        <div class="box-articoli">
                            <h4 class="articolo-titolo">${lastBlog.nome}</h4>
                            <p class="articolo-categoria">${lastBlog.categoria}</p>
                            <div class="textOverflow">
                                <p class="articolo-testo">${lastBlog.descrizione}</p>
                            </div>                        
                        </div>
                        <div class="articolo-bottone">
                            <a href="<c:url value="/articolo.jsp?id=${lastBlog.id}&nome=${lastBlog.nome.replace(' ', '-')}"/>" target="_blank" rel="noopener" class="btn btnAcquista" style="padding: 12px 20px;">leggi di più</a>
                        </div>
                    </c:if>
                </div>
                <div id="seconda-colonna-articoli" class="col-lg-6 col-12 mb-5">
                    <h5 class="testimonial-text text-center">Un'idea interessante</h5>
                    <c:set var="lastIdea" value="${ricettedao.getLastRecipe()}" />
                    <c:if test="${lastIdea ne null}">
                        <div class="box-articoli">
                            <h4 class="articolo-titolo">${lastIdea.nome}</h4>
                            <p class="articolo-categoria">${lastIdea.creatore}</p>
                            <div class="textOverflow">
                                <p class="articolo-testo">${lastIdea.descrizione}</p>
                            </div>
                        </div>
                        <div class="articolo-bottone">
                            <a href="<c:url value="/idea.jsp?id=${lastIdea.id}&nome=${lastIdea.nome.replace(' ', '-')}"/>" target="_blank" rel="noopener" class="btn btnAcquista" style="padding: 12px 20px;">leggi di più</a>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </section>

    <section id="raggiungici">
        <div class="et_pb_top_inside_divider divider-custom divider4"></div>

        <h3 class="styled" style="text-align: center; margin: 0 0 20px 0; color: white;x">Dove ci puoi trovare</h3>
        <div class="container">
            <div class="mb-5 mt-5" id="map1"></div>
            <div class="row box-mappe mb-5">
                <div class="col-lg-4 col-md-5 col-sm-12" style="margin: 0 auto;">
                    <h3>Macelleria Predazzo</h3>
                    <p>
                        <a rel="nofollow" href="https://www.google.com.br/maps/place/Macelleria+Dellantonio+S.n.c./@46.3125673,11.5998089,17z/data=!3m1!4b1!4m9!1m3!11m2!2s8plO4Vi8KGpSPZrzosvM0xXeNW3bUA!3e1!3m4!1s0x4778640a1b138a65:0xe3b41055e8ff2377!8m2!3d46.3125636!4d11.6019976">Via Cesare Battisti 2</a><br>
                        <a href="tel:0462501231">0462-501231</a><br>
                        <a href="mailto:info@macelleriadellantonio.it">info@macelleriadellantonio</a>
                    </p>
                </div>
                <div class="col-lg-4 col-md-5 col-sm-12" style="margin: 0 auto;">
                    <h3>Macelleria Campitello</h3>
                    <p>
                        <a rel="nofollow" href="https://www.google.com.br/maps/place/macelleria+dellantonio+s.n.c./@46.4764974,11.7387952,17z/data=!3m1!4b1!4m9!1m3!11m2!2s8plO4Vi8KGpSPZrzosvM0xXeNW3bUA!3e1!3m4!1s0x47786a4ba3b3e0d1:0xa84761f876bbe6b4!8m2!3d46.4764937!4d11.7409839">Piaz de Ciampedel 27</a><br>
                        <a href="tel:0462750416">0462-750416</a><br>
                        <a href="mailto:info@macelleriadellantonio.it">info@macelleriadellantonio</a>
                    </p>
                </div>
                <div class="col-lg-4 col-md-5 col-sm-12" style="margin: 0 auto;">
                    <h3>Ristorante</h3>
                    <p>
                        <a rel="nofollow" href="https://www.google.com.br/maps/place/Ristorante+'l+Bortoleto/@46.3108192,11.599008,17z/data=!3m1!4b1!4m5!3m4!1s0x4778633806ab5a6d:0xef49608af9171d85!8m2!3d46.3108155!4d11.6011967">Via Cavour 2</a><br>
                        <a href="tel:0462501261">0462-501261</a><br>
                        <a href="mailto:info@macelleriadellantonio.it">info@macelleriadellantonio</a>
                    </p>
                </div>
            </div>
        </div>

        <div id="contattaci" class="container">
            <h3 class="styled" style="text-align: center; margin: 0 0 20px 0; font-size: 2rem;">Contattaci</h3>
            <form method="POST" class="needs-validation text-center" novalidate id="sendEmailFormMac">
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="nome">Nome</label>
                        <input type="text" class="form-control" id="nome" placeholder="Il tuo nome" required>
                        <div class="invalid-feedback">
                            Il campo relativo al nome non è complilato in modo corretto
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="email">Email</label>
                        <input type="email" class="form-control" id="email" placeholder="La tua email" required>
                        <div class="invalid-feedback">
                            Il campo relativo all'email non è complilato in modo corretto
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-12 mb-3">
                        <label for="oggetto">Oggetto</label>
                        <input type="text" class="form-control" id="oggetto" placeholder="Oggetto" required>
                        <div class="invalid-feedback">
                            Il campo relativo all'oggetto non è complilato in modo corretto
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-12 mb-3">
                        <label for="messaggio">Messaggio</label>
                        <textarea class="form-control" rows="5" placeholder="Messaggio" id="messaggio" name="messaggio" required></textarea>
                        <div class="invalid-feedback">
                            Il campo relativo al messaggio non è complilato in modo corretto
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="send">Invia a:</label>
                    <select class="form-control" id="send" required>
                        <option value="macelleria">Macelleria</option>
                        <option value="ristorante">Ristorante</option>
                    </select>
                </div>
                <div id="recaptcha"><div class="g-recaptcha" data-sitekey="6Ld8YaAUAAAAAKDIu30P3tuRfUuPw-XgFHd9_J5U" data-callback="enableBtn"></div></div>
                <input style="color: white;" id="senderButton" type="submit" class="btn primary-btn" value="Inviaci un'email" disabled>
                <div class="spinner-border text-success invisible" id="loading" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </form>
            <div class="status text-center" id="status"></div>
        </div>

    </section>

    <footer id="footer" class="container-fluid text-center">

    </footer>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.7.2/js/all.js" integrity="sha384-0pzryjIRos8mFBWMzSSZApWtPl/5++eIfzYmTgBBmXYdhvxPc+XcFEk+zJwDgWbP" crossorigin="anonymous"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="js/mdb.min.js">async;</script>
    <script src="js/main-min.js" async></script>
    <script src="js/modernizr-min.js" async></script>
    <script src="js/vari-min.js" async></script>
    <script src="js/nav.js"></script>    
    <script src="js/parallax.js"></script>
    <script src="js/jquery.numscroller-1.0-min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <script>
        AOS.init();
        function aosInit() {
            AOS.init();
        }
        window.addEventListener('load', AOS.refresh);
    </script>
    <script>
        var map1;
        function initMap() {
            //The locations
            var mac = {lat: 46.312831, lng: 11.602077};
            var campMap = {lat: 46.476503, lng: 11.740982};
            var rest = {lat: 46.310828, lng: 11.601196};
            var center = {lat: 46.396439, lng: 11.6774257};
            // The map, centerd
            map1 = new google.maps.Map(
                    document.getElementById('map1'), {zoom: 11, center: center});
            // The marker, positioned at Uluru
            var marker = new google.maps.Marker({position: mac, label: 'MP', map: map1});
            var markerc = new google.maps.Marker({position: campMap, label: 'MC', map: map1});
            var marker1 = new google.maps.Marker({position: rest, label: 'R', map: map1});

            marker.addListener("click", function () {
                window.open("https://www.google.com.br/maps/place/Macelleria+Dellantonio+S.n.c./@46.3125673,11.5998089,17z/data=!3m1!4b1!4m9!1m3!11m2!2s8plO4Vi8KGpSPZrzosvM0xXeNW3bUA!3e1!3m4!1s0x4778640a1b138a65:0xe3b41055e8ff2377!8m2!3d46.3125636!4d11.6019976");
            });
            markerc.addListener("click", function () {
                window.open("https://www.google.com.br/maps/place/macelleria+dellantonio+s.n.c./@46.4764974,11.7387952,17z/data=!3m1!4b1!4m9!1m3!11m2!2s8plO4Vi8KGpSPZrzosvM0xXeNW3bUA!3e1!3m4!1s0x47786a4ba3b3e0d1:0xa84761f876bbe6b4!8m2!3d46.4764937!4d11.7409839");
            });
            marker1.addListener("click", function () {
                window.open("https://www.google.com.br/maps/place/Ristorante+'l+Bortoleto/@46.3108192,11.599008,17z/data=!3m1!4b1!4m5!3m4!1s0x4778633806ab5a6d:0xef49608af9171d85!8m2!3d46.3108155!4d11.6011967");
            });
        }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAdJPQRGr1Dh2vWyM2gq8pMgMYsILS_le4&callback=initMap"
            async defer>
    </script>
    <script>
        function enableBtn() {
            document.getElementById("senderButton").disabled = false;
        }
        document.addEventListener('touchstart', {passive: true});
    </script>
    <script>
        var check = false;
        (function () {
            'use strict';

            window.addEventListener('load', function () {
                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                var forms = document.getElementsByClassName('needs-validation');

                // Loop over them and prevent submission
                var validation = Array.prototype.filter.call(forms, function (form) {
                    form.addEventListener('submit', function (event) {
                        if (form.checkValidity() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                            check = false;
                        } else {
                            event.preventDefault();
                            check = true;
                        }
                        form.classList.add('was-validated');
                        sendEmail(event);
                    }, false);
                });
            }, false);
        })();


        function sendEmail(event) {
            event.preventDefault();
            if (check === true) {
                $('#senderButton').remove();
                $('#loading').removeClass("invisible");
                $.ajax({
                    type: "POST",
                    url: "sendEmail",
                    data: {nome: $('#nome').val(), email: $('#email').val(), oggetto: $('#oggetto').val(), messaggio: $('#messaggio').val(), recaptcha: $("#recaptcha").find("#g-recaptcha-response").val(), for : $('#send').val()},
                    cache: false,
                    success: function (response) {
                        $('#status').html("<h2>Grazie! Ti risponderemo appena possibile</h2>");
                        $('#loading').addClass("invisible");
                    },
                    error: function () {
                        $('#status').html("<h2>Ouch! Qualcosa è andato storto. Riprova tra qualche minuto, o scrivi a <a href='mailto:info@macelleriadellantonio.it'><i>info@macelleriadellantonio.it</i></a></h2>");
                        $('#loading').addClass("invisible");
                    }
                });
            }
        }

        jQuery(document).ready(function ($) {
            setTimeout(function () {
                $('.trans--grow').addClass('grow');
            }, 1500);
        });
    </script>
    <script>
        /* footer */
        $(function () {
            $("#footer").load("ajax/footer.html");
        });
    </script>

    <!-- Se è un celllulare touchscreen apple che usa safari disabilita l'immagine di sfondo (non la supportano) -->
    <script type="text/javascript">
        var isSafari = !!navigator.userAgent.match(/Version\/[\d\.]+.*Safari/);
        var isiDevice = /ipad|iphone|ipod/i.test(navigator.userAgent.toLowerCase());
        if (isiDevice) {
            if (isSafari) {
                $('body').css("background-image", "unset");
            }
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
