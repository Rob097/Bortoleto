<%-- 
    Document   : macelleria
    Created on : 15-mar-2019, 17.55.27
    Author     : Roberto97
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="request" value="<%=request%>"/>
${consoledao.incrementViews("macelleria", request, 0)}
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

        <meta property="og:url"           content="https://macelleriadellantonio.it<c:url value="/macelleria.jsp"/>" />
        <meta property="og:type"          content="website" />
        <meta property="og:title"         content="Macelleria Dellantonio - Predazzo e Campitello | Trentino" />
        <meta property="og:description"   content="Macelleria Dellantonio Predazzo val di Fiemme e Campitello val di Fassa. Antica macelleria km 0 del Trentino. Scopri la carne e i salumi del Trentino Alto Adige" />
        <meta property="og:image"         content="/Bortoleto/img/logo2.png" alt="Macelleria"/>
        <meta property="og:site_name" content="Macelleria Ristorante Dellantonio 'L Bortoleto">
        <meta property="fb:app_id"         content="320307085338651" />

        <link rel="icon" href="/Bortoleto/img/favicon.ico" sizes="16x16"  alt="Macelleria">
        <title>Macelleria Dellantonio - Predazzo e Campitello | Trentino</title>
        <meta name="Description" content="Macelleria Dellantonio Predazzo val di Fiemme e Campitello val di Fassa. Antica macelleria km 0 del Trentino. Scopri la carne e i salumi del Trentino Alto Adige">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="theme-color" content="#31353d">

        <!-- bootstrap include -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <!-- fine bootstrap include -->
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

        <link href="css/mdb.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/parallax.css">
        <link rel="stylesheet" href="css/font-min.css">
        <link rel="stylesheet" href="css/vari-min.css">
        <link rel="stylesheet" href="css/style-min.css">
        <link rel="stylesheet" href="css/Cards-min.css" type="text/css">
        <link rel="stylesheet" href="css/prodotto-min.css">
        <link rel="stylesheet" href="css/macelleriaCSS-min.css">
        <link rel="stylesheet" href="css/navbar-min.css">

        <style> 
            #eapps-instagram-feed-1 {
                width: auto !important;
            }
            body{
                background-image: url("/Bortoleto/img/dolomiti-macelleria.jpg");
                background-color: transparent !important;
                background-position: center center;
                background-repeat: no-repeat;
                background-size: cover;
                background-attachment: fixed;
                background-blend-mode: color;
            }
            @media (max-width: 991px){
                body{
                    background-size: 172vh;
                }
            }
            #content {
                background-image: -webkit-linear-gradient(315deg,rgba(255, 255, 240, 0.85) 0%,#ffffff);
            }
        </style>
        <script type="text/javascript">
            var _iub = _iub || [];
            _iub.csConfiguration = {"lang": "it", "siteId": 1636253, "cookiePolicyId": 77217510, "cookiePolicyUrl": "https://macelleriadellantonio.it/Bortoleto/file/PrivacyPolicy.pdf", "banner": {"acceptButtonDisplay": true, "customizeButtonDisplay": true, "position": "float-bottom-center", "consentOnScroll": true}};
        </script><script type="text/javascript" src="//cdn.iubenda.com/cs/iubenda_cs.js" charset="UTF-8" async></script>

        <!-- Markup JSON-LD generato da Assistente per il markup dei dati strutturati di Google. -->
        <script type="application/ld+json">
            {
            "@context" : "http://schema.org",
            "@type" : "LocalBusiness",
            "name" : "'L Bortoleto Macelleria Dellantonio",
            "image" : "/Bortoleto/img/logo2.png",
            "telephone" : "0462501231",
            "email" : "info@macelleriadellantonio.it",
            "address" : {
            "@type" : "PostalAddress",
            "streetAddress" : "Via Cesare Battisti 2",
            "addressLocality" : "PREDAZZO",
            "addressRegion" : "TN",
            "postalCode" : "38037"
            },
            "openingHoursSpecification" : {
            "@type" : "OpeningHoursSpecification",
            "dayOfWeek" : {
            "@type" : "DayOfWeek",
            "name" : "LUN - SAB"
            }
            },
            "url" : "https://macelleriadellantonio.it/Bortoleto/La-Macelleria",
            "logo": "/Bortoleto/img/logo2.png",
            "review" : {
            "@type" : "Review",
            "author" : {
            "@type" : "Person",
            "name" : "Federica Targa"
            },
            "datePublished" : "2019-04-28",
            "reviewRating" : {
            "@type" : "Rating",
            "ratingValue" : "5"
            },
            "reviewBody" : "Come sempre la carne è ottima, l'arte del mestiere appare nel modo di tagliarla e offrirla al cliente e la gentilezza e la disponibilità senza confronti ogni giorno."
            }
            }
        </script>


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
<body style="" id="topPage">
    <!-- Load Facebook SDK for JavaScript -->
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
    <a href="#topPage" id="myBtn45" title="Torna in cima" class="rightGray"><i class="fas fa-angle-up"></i></a>

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

    <div id="carousel-example-1z" class="carousel slide carousel-fade" data-ride="carousel" style="height: 100%;">

        <!--Indicators-->
        <ol class="carousel-indicators">
            <li data-target="#carousel-example-1z" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-1z" data-slide-to="1"></li>
            <li data-target="#carousel-example-1z" data-slide-to="2"></li>
        </ol>
        <!--/.Indicators-->

        <!--Slides-->
        <div class="carousel-inner" role="listbox" style="height: 100%;">

            <!--First slide-->
            <div class="carousel-item active" style="height: 100%;">
                <div class="view" style="background-image: url('https://lh3.googleusercontent.com/Qfpukrg2L5m_JGZ3tvX3skJbly1GCSUndEN-I3GJIqqNK90-d15pArC0ZxgwJDiRZh312e1QCQPnLN_RO0raBQHrPDcJCTwy1rV6vNkHyBZbyYC_EGVbBDMzY_CFbGa4DbxGcGfVvg=w2400'); height: 100%; width: 100%; background-size: cover; background-position: center center; background-repeat: no-repeat;">
                </div>
                <div class="carousel-caption capBox">                        
                    <h3 class="h3-responsive" style="font-weight: 900;">Bottega di Predazzo</h3>
                    <p>Via Cesare Battisti 2</p><br>

                    <div class="scrollIcon" style="bottom: 10rem;">
                        <a style="color: black;" href="#sections">
                            <i class="fas fa-chevron-down"></i>
                            <h5>Scorri</h5>
                        </a>
                    </div>
                </div>
            </div>
            <!--/First slide-->

            <!--Second slide-->
            <div class="carousel-item" style="height: 100%;">
                <div class="view" style="background-image: url('https://lh3.googleusercontent.com/ixN4bzXDDBzJpoHGooHd3Ryo5f1FTKoJgQV4Bs-lgGo6_k8zwVq9r3RCuTrSwtZ2eIWzc8ysfoZT398MDcOV0cJYh1vhhA9Yuo42G8Rmy_qTlluZIp68fVjN3IVZoK8HJIPZNX-ngg=w2400'); background-repeat: no-repeat; background-size: cover; width: 100%; height: 100%; background-position: center center;">
                </div>
                <div class="carousel-caption capBox">
                    <h3 class="h3-responsive" style="font-weight: 900;">Bottega di Campitello</h3>
                    <p>Piaz de Ciampedel 28</p><br>
                </div>
            </div>
            <!--/Second slide-->

            <!--Third slide-->
            <div class="carousel-item" style="height: 100%;">
                <div class="view" style="background-image: url('https://lh3.googleusercontent.com/B49sL65bzYSo4tJrSB3--_ObqsXncjul0XIRqollfPF_eQ-qG4jgUsvVqf1DGi8uZdLw3g9EYReCkbyKsYkRaGdTTHYfl2qHl756vohNQtbHQCT_dXqaQip8cMfNcdAav-wAoh39Vg=w2400'); background-repeat: no-repeat; background-size: cover; width: 100%; height: 100%; background-position: center center;">
                </div>
                <div class="carousel-caption capBox">
                    <h3 class="h3-responsive" style="font-weight: 900;">Macello e laboratorio</h3>
                    <p>Via Dell Is-Cion</p><br>
                </div>
            </div>
            <!--/Third slide-->

        </div>
        <!--/.Slides-->

        <!--Controls-->
        <a class="carousel-control-prev" href="#carousel-example-1z" role="button" data-slide="prev">
            <span aria-hidden="true"><i style="font-size: xx-large;" class="fas fa-angle-left"></i></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carousel-example-1z" role="button" data-slide="next">
            <span aria-hidden="true"><i style="font-size: xx-large;" class="fas fa-angle-right"></i></span>
            <span class="sr-only">Next</span>
        </a>
        <!--/.Controls-->

    </div>
    <!--/.Carousel Wrapper-->


    <div id="content">
        <div id="sections" class="container mb-5">                    
            <div class="mt-5 mb-5 text-center">
                <h2 class="bortoTitle" data-aos="fade-right" data-aos-duration="2000">'L Bortoleto</h2>
                <h2 class="macTitle" data-aos="fade-right" data-aos-duration="2000">Macelleria</h2>
            </div>

            <div style="text-align: right; margin: 8rem auto 10rem auto;">
                <h4 class="sottotitoli">Conosciamoci</h4>
                <h1 class="styled">Macelleria Dellantonio</h1>

                <div class="row mt-5 mb-5">
                    <div class="col-lg-5" style="width: fit-content; margin: 2rem auto 4rem auto;">
                        <img style="width: 30rem;" src="/Bortoleto/img/spiedini.jpg" />
                    </div>
                    <div class="col-lg-7">
                        <p class="description">
                            La <strong>macelleria Dellantonio</strong> di Predazzo è un'<strong>antica macelleria</strong> della val di Fiemme in Trentino. 
                            Sono infatti più di <strong>110</strong> anni che la macelleria a <strong>Predazzo</strong> e in tutta la valle rappresenta un punto di riferimento 
                            sia per i residenti sia per i tantissimi turisti che, ogni anno, la scelgono per gustare la carne e i <strong>salumi del Trentino Alto Adige</strong>.
                        </p>
                        <p class="description">La passione nel nostro lavoro ci ha sempre spronato a realizzare prodotti di <em><strong>altissima qualità</strong></em> della tradizione Trentina. 
                            <br>Con il passare degli anni abbiamo rivoluzionato le nostre sedi e i servizi che offriamo quotidianamente ai nostri clienti. Oltre alla macelleria, i nostri prodotti comprendono anche 
                            la <strong>salumeria</strong>, infatti è proprio qui che la passione, le materie prime a <strong>km0</strong> e la centenaria esperienza ci permettono di realizzare 
                            salumi tradizionali del Trentino Alto Adige di altissima qualità. <br />Per questo motivo dal 2020 la nostra <strong>macelleria tipica Trentina</strong> di 
                            <strong>Campitello</strong> in val di Fassa è stata trasformata per permettere a tutti di capire da vicino il nostro concetto di qualità e di professionalità.
                        </p>
                        <p class="description">Noi della macelleria Dellantonio, sia in <strong>val di Fiemme</strong> sia in <strong>val di Fassa</strong>, siamo orgogliosi di offrire un servizio di qualità con materie prime km0.<br />
                            <a title="Vai alla mappa" href="#raggiungici-macelleria">Vieni a trovarci</a> per scoprire tu stesso la qualità della carne e dei <strong>salumi del Trentino Alto Adige</strong>!
                        </p>
                    </div>
                </div>
            </div>

            <div id="la-nostra-storia" class='row' style="margin-top: 5rem; margin-bottom: 5rem;">
                <div class='col-lg-8'>
                    <div id="parallaxN1" class="image-liquid image-holder--original parallax-window" data-parallax="scroll" data-image-src="/console/img/immagini_sito/storia/1901.JPG" style="height: 700px; width: 100%; position: relative; border-radius: 0; background-repeat: no-repeat; background-size: cover; background-position: center center;">
                        <div class="">
                            <div style="height: 700px;">
                            </div>
                        </div>
                    </div>  
                </div> 
                <div class='col-lg-4' style="z-index: 1;">
                    <div class="largeBox dxLB" data-aos="fade-up-right" data-aos-duration="2000">
                        <h2 style='font-weight: 900;'>La nostra storia</h2>
                        <a class="buttonS" href="#content" onclick="callStory();" >Scopri di più</a>
                    </div>
                </div>
            </div>
            <div id="i-nostri-prodotti" class='row flex-column-reverse flex-lg-row' style="margin-top: 5rem;">
                <div class='col-lg-4' style="z-index: 1;">
                    <div class="largeBox sxLB" data-aos="fade-down-right" data-aos-duration="2000"> 
                        <h2 style='font-weight: 900;'>I nostri prodotti</h2>
                        <a class="buttonS" href="#content" onclick="callProducts();" >Scopri di più</a>
                    </div>
                </div>
                <div class='col-lg-8'>
                    <div id="parallaxN2" class="image-liquid image-holder--original parallax-window" data-parallax="scroll" data-image-src="https://lh3.googleusercontent.com/UiyL4l-QB267-M566GkkFOPKfsvHa7SyHknYt2Hocri0jGB65tVNe5Adrfafjvkll1jN5lUaabti8EekOdrj66aAjRRMTgn5-GsqgJDkQsUNi0_JdeDoIvz-M8HNn5EUVLc2UTcarw=w2400" style="height: 500px; width: 100%; position: relative; border-radius: 0; background-repeat: no-repeat; background-position: center center;">
                        <div class="effetto1">
                            <div style="height: 500px;">
                            </div>
                        </div>
                    </div>  
                </div>
            </div>
        </div>


        <!-- Section: bottegaOnlineDiscover -->
        <section id="bottegaOnlineDiscover">
            <div class="container" style="min-height: 35vh; width: 100%;">
                <h3 class="mt-4" style="margin-bottom: 3rem; font-size: 2rem; font-family: 'Coming Soon'; font-weight: bold;">Scopri la nostra nuova Bottega Online!</h3>
                <div class="row">
                    <div class="col-lg-6 Girl">
                        <div id="bottegaDesc" data-aos="fade-right" data-aos-duration="2000">
                            <p>Facile da utilizzare<i class="ml-3 mr-3 fas fa-arrow-left bottegaDescIco"></i></p>
                            <p>Puoi salvare i prodotti nei preferiti<i class="ml-3 mr-3 fas fa-arrow-left bottegaDescIco"></i></p>
                            <p>Pagamenti sicuri<i class="ml-3 mr-3 fas fa-arrow-left bottegaDescIco"></i></p>
                            <p>Senza Registrazione<i class="ml-3 mr-3 fas fa-arrow-left bottegaDescIco"></i></p>
                            <p>Ritiro in negozio<i class="ml-3 mr-3 fas fa-arrow-left bottegaDescIco"></i></p>
                            <p>Consegna in 24h<i class="ml-3 mr-3 fas fa-arrow-left bottegaDescIco"></i></p>
                        </div>
                        <div id="bottegaLink">
                            <a href="<c:url value="/bottega.jsp"/>" target="_blank" rel="noopener">Cosa aspetti? Provala subito!</a>
                        </div>
                    </div>
                    <div onclick="window.open('img/bottegaBig.gif');" class="col-lg-6" id="bottegaGif" data-aos="fade-up-right" data-aos-duration="2000">
                    </div>
                </div>
            </div>
        </section>
        <!-- Section: bottegaOnlineDiscover -->

        <!-- Section: Testimonials v.2 Facebook review -->
        <section class="effetto1 container text-center my-5" style='margin: auto auto; color: white !important;'>
            <h4 class="sottotitoli" style="text-align: center;">rimani aggiornato</h4>  
            <h3 class="styled" style="text-align: center; margin: 0; color: black;">News</h3>
            <div class="mt-5 row">
                <div class="col-md-6">
                    <iframe src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2Fmacelleriadellantonio%2F&tabs=timeline&width=340&height=500&small_header=false&adapt_container_width=true&hide_cover=false&show_facepile=true&appId=320307085338651" width="auto" height="500" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true" allow="encrypted-media"></iframe>
                </div>
                <div class="col-md-6">
                    <script src="https://apps.elfsight.com/p/platform.js" defer></script>
                    <div class="elfsight-app-9455b5c5-1d00-406a-8e4d-ca51afd6f761"></div>
                </div>
            </div>
        </section>
        <!-- Section: Testimonials v.2 -->

        <!-- Section: Contact Us -->
        <section class="text-center mt-5 pb-5" id="raggiungici-macelleria">

            <h2 class="h1-responsive font-weight-bold my-5">Contatti</h2>
            <a style="display: inline-block;" href="mailto:info@macelleriadellantonio.it"><p class='Architects' style='font-size: 1.5rem; width: fit-content; margin: auto auto;'>info@macelleriadellantonio.it</p></a>
            <div class='row flex-column-reverse flex-lg-row' style='width: 100%; margin: 0;'>
                <div class='col-lg-8'>
                    <div class="mb-5 mt-5" id="map1" data-aos="zoom-out-right" data-aos-duration="2000"></div>
                </div>
                <div class='col-lg-4'>
                    <div class='contactInfo' data-aos="zoom-in-right" data-aos-duration="2000">
                        <h2 style='font-weight: 900;'>PREDAZZO</h2>
                        <a href="tel:0462501231"><p>0462-501231</p></a>
                        <a href='https://www.google.com.br/maps/place/Macelleria+Dellantonio+S.n.c./@46.3125673,11.5998089,17z/data=!3m1!4b1!4m9!1m3!11m2!2s8plO4Vi8KGpSPZrzosvM0xXeNW3bUA!3e1!3m4!1s0x4778640a1b138a65:0xe3b41055e8ff2377!8m2!3d46.3125636!4d11.6019976' target='_blank'><p>Via Cesare Battisti 2</p></a>
                        <br>
                        <h2 style='font-weight: 900;'>CAMPITELLO</h2>
                        <a href="tel:0462750416"><p>0462-750416</p></a>
                        <a href='https://www.google.com.br/maps/place/macelleria+dellantonio+s.n.c./@46.4764974,11.7387952,17z/data=!3m1!4b1!4m9!1m3!11m2!2s8plO4Vi8KGpSPZrzosvM0xXeNW3bUA!3e1!3m4!1s0x47786a4ba3b3e0d1:0xa84761f876bbe6b4!8m2!3d46.4764937!4d11.7409839' target='_blank'><p>Piaz de Ciampedel 28</p></a>
                    </div>
                </div>
            </div>
            <hr style="border: 3px solid rgba(255, 64, 64, 0.71); width: 50%; border-radius: 100%;"/>
            <div class="container comment-form" data-aos="fade-up" data-aos-duration="2000" id="contattaci-macelleria">
                <!--Section description-->
                <p class="text-center w-responsive mx-auto mb-5">Hai qualche domanda? Non esitare a contattarci, ti risponderemo il prima possibile</p>
                <form method="POST" class="needs-validation" novalidate id="sendEmailForm">
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
                    <hr style="border: 3px solid rgb(121, 85, 72); width: 50%; border-radius: 100%;"/>
                    <div id="recaptcha"><div class="g-recaptcha" data-sitekey="6Ld8YaAUAAAAAKDIu30P3tuRfUuPw-XgFHd9_J5U" data-callback="enableBtn"></div></div>
                    <input id="senderButton" type="submit" class="btn primary-btn" value="Inviaci un'email" disabled>
                    <div class="spinner-border text-success invisible" id="loading" role="status">
                        <span class="sr-only">Loading...</span>
                    </div>
                </form>
                <div class="status" id="status"></div>
            </div>
        </section>
    </div>

    <!-- Footer -->

    <footer id="footer" class="container-fluid text-center footer">

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
    <script src="js/parallax.js" async></script>
    <script src="js/nav.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <script>
    </script>
    <script>
        AOS.init();
        function aosInit() {
            AOS.init();
        }

        function enableBtn() {
            document.getElementById("senderButton").disabled = false;
        }
    </script>
    <script>
        // Example starter JavaScript for disabling form submissions if there are invalid fields
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
    </script>
    <script>
        var map1;
        function initMap() {
            //The locations
            var mac = {lat: 46.312831, lng: 11.602077};
            var campMap = {lat: 46.476503, lng: 11.740982};
            var center = {lat: 46.396439, lng: 11.6774257};
            // The map, centerd
            map1 = new google.maps.Map(
                    document.getElementById('map1'), {zoom: 11, center: center});
            // The marker, positioned at Uluru
            var marker = new google.maps.Marker({position: mac, map: map1});
            var markerc = new google.maps.Marker({position: campMap, map: map1});

            marker.addListener("click", function () {
                window.open("https://www.google.com.br/maps/place/Macelleria+Dellantonio+S.n.c./@46.3125673,11.5998089,17z/data=!3m1!4b1!4m9!1m3!11m2!2s8plO4Vi8KGpSPZrzosvM0xXeNW3bUA!3e1!3m4!1s0x4778640a1b138a65:0xe3b41055e8ff2377!8m2!3d46.3125636!4d11.6019976");
            });
            markerc.addListener("click", function () {
                window.open("https://www.google.com.br/maps/place/macelleria+dellantonio+s.n.c./@46.4764974,11.7387952,17z/data=!3m1!4b1!4m9!1m3!11m2!2s8plO4Vi8KGpSPZrzosvM0xXeNW3bUA!3e1!3m4!1s0x47786a4ba3b3e0d1:0xa84761f876bbe6b4!8m2!3d46.4764937!4d11.7409839");
            });
        }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAdJPQRGr1Dh2vWyM2gq8pMgMYsILS_le4&callback=initMap"
            async defer>
    </script>
    <script>
        //Load Story page
        var principale = "";
        var mirrors;
        function backToPrincipale() {
            $('#content').html(principale);
            $('#content').removeClass("container");
            for (i = 0; i < mirrors.length; i++) {
                $("body").append(mirrors[i]);
            }
            aosInit();
        }
        //Load Story page
        function callStory() {
            $.ajax({
                type: "GET",
                url: "ajax/story.jsp",
                cache: false,
                success: function (response) {
                    principale = $('#content').html().toString();
                    $('#content').html("");
                    $('#content').html(response);
                    mirrors = $('.parallax-mirror');
                    $('.parallax-mirror').remove();
                    aosInit();
                },
                error: function () {
                    alert("Errore call Story");
                }
            });
        }
        function callProducts() {
            $.ajax({
                type: "GET",
                url: "ajax/products.jsp",
                cache: false,
                success: function (response) {
                    principale = $('#content').html().toString();
                    $('#content').html("");
                    $('#content').html(response);
                    mirrors = $('.parallax-mirror');
                    $('.parallax-mirror').remove();
                    aosInit();
                },
                error: function () {
                    alert("Errore call Products");
                }
            });
        }

        function sendEmail(event) {
            event.preventDefault();
            if (check === true) {
                $('#senderButton').remove();
                $('#loading').removeClass("invisible");
                $.ajax({
                    type: "POST",
                    url: "sendEmail",
                    data: {nome: $('#nome').val(), email: $('#email').val(), oggetto: $('#oggetto').val(), messaggio: $('#messaggio').val(), recaptcha: $("#g-recaptcha-response").val(), for : 'macelleria'},
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
    </script>
    <script>
        /* footer */
        $(function () {
            $("#footer").load("ajax/footer.html");
        });

        /* navbar */
        $(function () {
            $("#main-nav").load("ajax/navbar.html");
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
