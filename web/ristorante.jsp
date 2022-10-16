<%-- 
    Document   : ristorante
    Created on : 27-apr-2019, 14.01.50
    Author     : Roberto97
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="request" value="<%=request%>"/> <!-- Request lo chiamo con una scriplets e lo salvo in una variabile perchè serve per diversi metodi java -->
<c:set var="response" value="<%=response%>"/> <!-- Response lo chiamo con una scriplets e lo salvo in una variabile perchè serve per diversi metodi java -->
<%@ page import="varie.Costanti" %>
<c:set value="<%=varie.Costanti.SPACES_COOKIE%>" var="SPACES_COOKIE" />
${consoledao.incrementViews("ristorante", request, 0)}
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

        <meta property="og:url"           content="https://macelleriadellantonio.it<c:url value="/ristorante.jsp"/>" />
        <meta property="og:type"          content="website" />
        <meta property="og:title"         content="Ristorante 'L Bortoleto - Predazzo" />
        <meta property="og:description"   content="Ristorante 'L Bortoleto a Predazzo offriamo un'esperienza gastronomica a km0 in grado di soddisfare i palati più fini rispettando la stagionalità dei prodotti." />
        <meta property="og:image"         content="/Bortoleto/img/logoNeg.jpg" />
        <meta property="og:site_name" content="Macelleria Ristorante Dellantonio 'L Bortoleto">
        <meta property="fb:app_id"         content="320307085338651" />

        <link rel="icon" href="/Bortoleto/img/logoNeg.jpg" type="image/png" alt="Logo Ristorante Bortoleto Predazzo" title="Logo Ristorante Bortoleto Predazzo">
        <title>Ristorante 'L Bortoleto - Predazzo</title>
        <meta name="Description" content="Ristorante 'L Bortoleto a Predazzo offriamo un'esperienza gastronomica a km0 in grado di soddisfare i palati più fini rispettando la stagionalità dei prodotti.">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="theme-color" content="#31353d">        

        <!-- bootstrap include -->
        <link rel="stylesheet nofollow" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet nofollow" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet nofollow" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet nofollow">
        <!-- fine bootstrap include -->
        <link href="css/mdb.min.css" rel="stylesheet nofollow">
        <link rel="stylesheet nofollow" href="css/parallax.css">
        <link rel="stylesheet nofollow" href="css/font-min.css">
        <link rel="stylesheet nofollow" href="css/style-min.css">
        <link rel="stylesheet nofollow" href="css/Cards-min.css" type="text/css">
        <link rel="stylesheet nofollow" href="css/prodotto-min.css">
        <link rel="stylesheet nofollow" href="css/macelleriaCSS-min.css">
        <link rel="stylesheet nofollow" href="css/vari-min.css">
        <link rel="stylesheet nofollow" href="css/animations-min.css">
        <link rel="stylesheet nofollow" href="css/ristorante-min.css">
        <link rel="stylesheet nofollow" href="css/animate-min.css">        
        <link rel="stylesheet nofollow" href="css/navbar-min.css">
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <style>  
            .sottotitoli {
                font-size: 14px;
                letter-spacing: 2px;
                font-family: "Montserrat",sans-serif;
                font-weight: 1000;
                text-shadow: 0 1px, 1px 0, 1px 1px;
                text-transform: uppercase;
                color: #b4505a;
                margin: 60px 0 20px 0;
            }
            .styled{
                font-family: "Montserrat",sans-serif;
                font-size: 3rem;
            }
            .divider-custom {
                color: #666;
                font-family: "Open Sans",Arial,sans-serif;
                font-weight: 500;
                line-height: 1.7em;
                -webkit-font-smoothing: antialiased;
                cursor: move;
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                border: 0;
                outline: 0;
                background: 0 0;
                font-size: 100%;
                vertical-align: baseline;
                display: block;
                width: 100%;
                pointer-events: none;
                background-repeat-y: no-repeat;
                margin-top: -1px;
                touch-action: none;
                top: 0;
                z-index: 1;
                height: 100px;
            }
            .divider3{
                z-index: 10;
                transform: rotateY(180deg) rotateX(180deg);
                background-image: url( data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTYwcHgiIGhlaWdodD0iMTQwcHgiIHZpZXdCb3g9IjAgMCAxNjAgMTQwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxnIGZpbGw9IiNiNDUwNWEiPjxwYXRoIGQ9Ik04MCAwTDAgMTQwaDE2MHoiLz48L2c+PC9zdmc+);
                background-size: cover;
                background-position-x: center;
            }
            #eapps-instagram-feed-1 {
                width: auto !important;
            }
            .eapps-widget-toolbar-panel-share{
                position: relative !important;
            }
            #stagioni-section{
                padding: 30px;
            }
            .title-container-stagioni{
                animation-delay: 1s; animation-duration: 3s;
            }
            .title-container-stagioni h4{
                margin-bottom: -15px;font-weight: 700!important;
                font-size: 60px;
                color: #ffffff!important;
                text-align: center!important;
                text-shadow: 0em 0.1em 0.1em rgba(0,0,0,0.4)!important;text-transform: uppercase;font-family: 'Montserrat',Helvetica,Arial,Lucida,sans-serif;
            }   
            .title-container-stagioni p{
                margin-bottom: -15px;font-family: 'Cruz Script',Helvetica,Arial,Lucida,sans-serif!important;
                font-weight: 700!important;
                font-size: 50px;
                color: #b4505a!important;
                text-align: center!important;
                text-shadow: 0em 0.1em 0.1em #ffffff!important;
            }
            .img-stagioni{
                max-width: 600px;
                width:100%;
                border-radius: 5px;
            }
            .divider-custom{
                color: #666;
                font-family: "Open Sans",Arial,sans-serif;
                font-weight: 500;
                line-height: 1.7em;
                -webkit-font-smoothing: antialiased;
                cursor: move;
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                border: 0;
                outline: 0;
                background: 0 0;
                font-size: 100%;
                vertical-align: baseline;
                display: block;
                width: 100%;
                pointer-events: none;
                background-repeat-y: no-repeat;
                margin-top: -1px;
                touch-action: none;
                top: 0;
                z-index: 1;
                height: 100px;
            }
            .divider6{
                background: transparent;
                background-image: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDBweCIgdmlld0JveD0iMCAwIDEyODAgMTQwIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxnIGZpbGw9IiNiNDUwNWEiPjxwYXRoIGQ9Ik0wIDUxLjc2YzM2LjIxLTIuMjUgNzcuNTctMy41OCAxMjYuNDItMy41OCAzMjAgMCAzMjAgNTcgNjQwIDU3IDI3MS4xNSAwIDMxMi41OC00MC45MSA1MTMuNTgtNTMuNFYwSDB6IiBmaWxsLW9wYWNpdHk9Ii4zIi8+PHBhdGggZD0iTTAgMjQuMzFjNDMuNDYtNS42OSA5NC41Ni05LjI1IDE1OC40Mi05LjI1IDMyMCAwIDMyMCA4OS4yNCA2NDAgODkuMjQgMjU2LjEzIDAgMzA3LjI4LTU3LjE2IDQ4MS41OC04MFYwSDB6IiBmaWxsLW9wYWNpdHk9Ii41Ii8+PHBhdGggZD0iTTAgMHYzLjRDMjguMiAxLjYgNTkuNC41OSA5NC40Mi41OWMzMjAgMCAzMjAgODQuMyA2NDAgODQuMyAyODUgMCAzMTYuMTctNjYuODUgNTQ1LjU4LTgxLjQ5VjB6Ii8+PC9nPjwvc3ZnPg==);
                background-size: 100% 100px;
                position: absolute;
            }
            .divider7{
                background: rgba(0,0,0,0.8);
                background-image: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDBweCIgdmlld0JveD0iMCAwIDEyODAgMTQwIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxnIGZpbGw9InJnYmEoMjU1LDI1NSwyNTUsMC42NSkiPjxwYXRoIGQ9Ik0wIDE0MGw2NDAtNzAgNjQwIDcwVjBMNjQwIDcwIDAgMHYxNDB6IiBmaWxsLW9wYWNpdHk9Ii41Ii8+PHBhdGggZD0iTTAgMTQwaDEyODBMNjQwIDcwIDAgMTQweiIvPjwvZz48L3N2Zz4=);
                background-size: 100% 100px;
                bottom: 0;
            }
            @media(min-width: 768px){
                #stagioni-section{
                    padding: 50px 100px 50px 100px;
                }
            }
            @media(max-width: 768px){
                .title-container-stagioni h4{
                    font-size: 25px;
                }
                .title-container-stagioni p{
                    font-size: 35px;
                    margin-top: 20px;
                }
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
            "name" : "'L Bortoleto Ristorante 'L Bortoleto",
            "image" : "/Bortoleto/img/logoNeg.jpg",
            "telephone" : "0462-500261",
            "email" : "ristorantebortoleto@gmail.com",
            "address" : {
            "@type" : "PostalAddress",
            "streetAddress" : "Via Cavour 2",
            "addressLocality" : "PREDAZZO",
            "addressRegion" : "TN",
            "addressCountry" : "Predazzo",
            "postalCode" : "38037"
            },
            "url" : "https://macelleriadellantonio.it/Bortoleto/Il-Risorante",
            "logo": "/Bortoleto/img/logoNeg.jpg",
            "openingHoursSpecification" : {
            "@type" : "OpeningHoursSpecification",
            "dayOfWeek" : {
            "@type" : "DayOfWeek",
            "name" : "MAR - DOM"
            }
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
<body id="topPage">
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
            <img width="90vh" src="/Bortoleto/img/logoNeg.jpg" alt="Logo Ristorante Bortoleto">
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

    <div id="galleria-ristorante-bortoleto" class="carousel slide carousel-fade" data-ride="carousel" style="height: 101vh;">

        <!--Indicators-->
        <ol class="carousel-indicators">
            <li data-target="#galleria-ristorante-bortoleto" data-slide-to="0" class="active"></li>
            <li data-target="#galleria-ristorante-bortoleto" data-slide-to="1"></li>
            <li data-target="#galleria-ristorante-bortoleto" data-slide-to="2"></li>
            <li data-target="#galleria-ristorante-bortoleto" data-slide-to="3"></li>
        </ol>
        <!--/.Indicators-->

        <!--Slides-->
        <div class="carousel-inner" role="listbox" style="height: 100%;">

            <!--First slide-->
            <div class="carousel-item active">
                <!--Mask color-->
                <div class="view">
                    <!--Video source-->
                    <video class="video-fluid" autoplay playsinline loop muted poster="img/restaPoster.gif"> 
                        <source src="img/restaVideo.mp4" type="video/mp4" />
                    </video>
                    <div class="mask rgba-indigo-light"></div>
                </div>

                <!--Caption-->
                <div class="videoCaption">
                    <img style="width: 60vh;" src="/Bortoleto/img/logoNeg.jpg" alt="Ristorante 'l Bortoleto" />

                    <div class="scrollIcon">
                        <a style="color: white;" href="#home">
                            <i class="fas fa-chevron-down"></i>
                            <h5>Scorri</h5>
                        </a>
                    </div>
                </div>
                <!--Caption-->
            </div>
            <!-- /.First slide -->

            <!--First slide -->
            <div class="carousel-item" style="height: 100%;">
                <div class="view" style="background-image: url('/Bortoleto/img/sedi/Ristorante/Ristorante-Bortoleto-Predazzo.jpg'); height: 100%; width: 100%; background-size: cover; background-position: center center; background-repeat: no-repeat;">
                </div>
                <div class="carousel-caption capBox">                        
                    <h4 class="h3-responsive" style="font-weight: 900;">Sala in pietra</h4>
                    <p>Antico laboratorio della macelleria restaurato</p><br>
                </div>
            </div>
            <!--/First slide -->

            <!--Second slide -->
            <div class="carousel-item" style="height: 100%;">
                <div class="view" style="background-image: url('https://lh3.googleusercontent.com/ixN4bzXDDBzJpoHGooHd3Ryo5f1FTKoJgQV4Bs-lgGo6_k8zwVq9r3RCuTrSwtZ2eIWzc8ysfoZT398MDcOV0cJYh1vhhA9Yuo42G8Rmy_qTlluZIp68fVjN3IVZoK8HJIPZNX-ngg=w2400'); background-repeat: no-repeat; background-size: cover; width: 100%; height: 100%; background-position: center center;">
                </div>
                <div class="carousel-caption capBox">
                    <h4 class="h3-responsive" style="font-weight: 900;">Bottega di Campitello</h4>
                    <p>Piaz de Ciampedel 28</p><br>
                </div>
            </div>
            <!--/Second slide -->

            <!--Third slide -->
            <div class="carousel-item" style="height: 100%;">
                <div class="view" style="background-image: url('https://lh3.googleusercontent.com/B49sL65bzYSo4tJrSB3--_ObqsXncjul0XIRqollfPF_eQ-qG4jgUsvVqf1DGi8uZdLw3g9EYReCkbyKsYkRaGdTTHYfl2qHl756vohNQtbHQCT_dXqaQip8cMfNcdAav-wAoh39Vg=w2400'); background-repeat: no-repeat; background-size: cover; width: 100%; height: 100%; background-position: center center;">
                </div>
                <div class="carousel-caption capBox">
                    <h4 class="h3-responsive" style="font-weight: 900;">Macello e laboratorio</h4>
                    <p>Via Dell Is-Cion</p><br>
                </div>
            </div>
            <!--/Third slide-->

        </div>
        <!--/.Slides-->

        <!--Controls-->
        <a class="carousel-control-prev" href="#galleria-ristorante-bortoleto" role="button" data-slide="prev">
            <span aria-hidden="true"><i style="font-size: xx-large;" class="fas fa-angle-left"></i></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#galleria-ristorante-bortoleto" role="button" data-slide="next">
            <span aria-hidden="true"><i style="font-size: xx-large;" class="fas fa-angle-right"></i></span>
            <span class="sr-only">Next</span>
        </a>
        <!--/.Controls-->

        <div class="et_pb_bottom_inside_divider divider-custom divider7"></div>
    </div>
    <!--/.Carousel Wrapper-->

    <div id="home" class="wrap-intro">
        <div class="mt-5 mb-5 text-center">
            <h1 class="macTitle" data-aos="fade-right" data-aos-duration="2000"><span class="bortoTitle">'L Bortoleto</span><br>Ristorante</h1>
        </div>

        <div class="container" style="text-align: right;">
            <h4 class="sottotitoli">Conosciamoci</h4>
            <h2 class="styled">Il Ristorante</h2>

            <div class="row mt-5 mb-5">
                <div class="col-md-5 mt-3 mb-5">
                    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" data-interval="8000">
                        <ol class="carousel-indicators">
                            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                        </ol>
                        <div class="carousel-inner">
                            <div class="carousel-item active" style="height: 300px; min-height: 300px !important;">
                                <img style="height: 100%; max-width: none !important;" class="d-block" src="/Bortoleto/img/sedi/Ristorante/Ristorante-Bortoleto-Predazzo.jpg" alt="Ristorante 'L Bortoleto Predazzo" title="Ristorante 'L Bortoleto Predazzo">
                            </div>
                            <div class="carousel-item" style="height: 300px; min-height: 300px !important;">
                                <img class="d-block w-100" src="http://templates.aucreative.co/deli/images/home-onepage-img-intro.jpg" alt="Simone Dellantonio">
                            </div>
                            <div class="carousel-item" style="height: 300px; min-height: 300px !important;">
                                <img style="height: 100%; max-width: none !important;" class="d-block" src="https://careersmart.org.uk/sites/default/files/2017-04/Waiters-and-waitresses.jpg" alt="Valeria Dellantonio">
                            </div>
                        </div>
                        <a class="carousel-control-prev" data-target="#carouselExampleIndicators" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" data-target="#carouselExampleIndicators" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </div>
                <div class="col-md-7">
                    <p class="description">
                        Il <strong>Ristorante 'L Bortoleto</strong> apre nel 2018 nel centro storico di <strong>Predazzo</strong>, 
                        nel cuore delle Dolomiti Trentine, con l'idea di offrire un'esperienza gastronomica a km0 attraverso le <strong>specialità del Trentino</strong>.
                    </p>
                    <p class="description">
                        Il ristorante intende valorizzare le carni della <a title="Macelleria Dellantonio" href="https://macelleriadellantonio.it/Bortoleto/La-Macelleria" target="_blank">macelleria</a>, 
                        una delle botteghe storiche del paese. La carne è, quindi, ovviamente il punto di forza del locale, che punta molto sulla <strong>stagionalità</strong>, 
                        con un menù che cambia in base al periodo dell'anno.
                        Questa è proprio la direzione principale di <strong>Simone Dellantonio</strong>, lo Chef.<br />
                        L'idea di adattare il menu in base alla stagione utilizzando <strong>materie prime fresche e di qualità</strong> è andata persa nel tempo ed è giusto recuperarla 
                        per creare un consumo sostenibile e per apprezzare tutti i prodotti meno conosciuti e utilizzati.
                    </p>
                    <p class="description">
                        Tra i <strong>ristoranti a Predazzo</strong>, il ristorante 'L Bortoleto, offre l'opportunità di gustare le <strong>specialità trentine</strong> con prodotti freschi e di stagione, 
                        apprezzabili ancor di più con i giusti abbinamenti dei principali <strong>vini</strong> della regione e di tutto il territorio Italiano, consigliati da <strong>Valeria Dellantonio</strong>, responsabile della sala.<br />
                        <strong>Cosa aspetti? <a title="Chiama il ristorante Bortoleto" href="tel:0462500261">Prenota il tuo tavolo!</a></strong>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <section id="menu" class="mb-5">
        <div class="row image-liquid image-holder--original parallax-window" data-parallax="scroll" data-image-src="http://192.168.1.107/bortoleto/wp-content/uploads/2020/02/menu-background-image-2-3.jpg" style="height: 70vh; width: 90%; margin: auto; position: relative; border-radius: 0; background-repeat: no-repeat; background-size: cover; background-position: center center;">
            <div class="et_pb_top_inside_divider divider-custom divider6"></div>
            <div style="position: relative;display: table;width:100%;height:100%;">
                <div style="display: table-cell;vertical-align: middle;text-align:center;">
                    <h2 data-aos="fade-right" data-aos-duration="2000" style='color:white;font-family:"montserrat"; font-size: 5rem;position:relative;z-index:1;'>Il Menu</h2>
                    <p data-aos="fade-up" data-aos-duration="2000" style="
                       font-family: 'Cruz Script',Helvetica,Arial,Lucida,sans-serif;
                       font-weight: 700;
                       color: #b4505a!important;
                       font-size: 2.5rem;
                       line-height: 1.2em;
                       text-shadow: 0px 0px 20px white;position:relative;z-index:1;">Specialità Trentine</p>
                    <h3 style="display: none;">ristorante l bortoleto predazzo menu</h3>
                </div>
            </div>
        </div>
        <div id="sections" class="container">

            <c:set var="position" value="0"/>
            <c:forEach items="${menudao.getAllMenu()}" var="menu" >
                <c:choose>
                    <c:when test="${position%2 == 0}">
                        <div class='row' style="margin-top: 5rem; margin-bottom: 5rem;">
                            <div class='col-lg-8'>
                                <div id="parallaxN1" class="image-liquid image-holder--original parallax-window" data-parallax="scroll" data-image-src="${menu.copertina}" style="height: 700px; width: 100%; position: relative; border-radius: 0; background-repeat: no-repeat; background-size: cover; background-position: center center;">
                                    <div class="">
                                        <div style="height: 700px;">
                                        </div>
                                    </div>
                                </div> 
                            </div> 
                            <div class='col-lg-4' style="z-index: 1;">
                                <div class="largeBox dxLB" data-aos="fade-right" data-aos-duration="2000">
                                    <h3 style='font-weight: 900;'>${menu.nome}</h3>
                                    <a class="buttonS" href="#menu" onclick="callMenu('${menu.nome}', '${menu.immagine}');" >Scopri di più</a>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class='row flex-column-reverse flex-lg-row' style="margin-top: 5rem;">
                            <div class='col-lg-4' style="z-index: 1;">
                                <div class="largeBox sxLB" data-aos="fade-right" data-aos-duration="2000"> 
                                    <h3 style='font-weight: 900;'>${menu.nome}</h3>
                                    <a class="buttonS" href="#menu" onclick="callMenu('${menu.nome}', '${menu.immagine}');" >Scopri di più</a>
                                </div>
                            </div>
                            <div class='col-lg-8'>
                                <div id="parallaxN2" class="image-liquid image-holder--original parallax-window" data-parallax="scroll" data-image-src="${menu.copertina}" style="height: 500px; width: 100%; position: relative; border-radius: 0; background-repeat: no-repeat; background-position: center center;">
                                    <div class="effetto1">
                                        <div style="height: 500px;">
                                        </div>
                                    </div>
                                </div>  
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
                <c:set var="position" value="${position + 1}"/>
            </c:forEach>
        </div>
    </section>

    <section id="stagioni-section">
        <div id="materie-prime-ristorante-bortoleto" class="carousel slide carousel-fade" data-ride="carousel" data-interval="80000">

            <!--Indicators-->
            <ol class="carousel-indicators">
                <li data-target="#materie-prime-ristorante-bortoleto" data-slide-to="0" class="active" style="background-color:#b4505a;"></li>
                <li data-target="#materie-prime-ristorante-bortoleto" data-slide-to="1" style="background-color:#b4505a;"></li>
                <li data-target="#materie-prime-ristorante-bortoleto" data-slide-to="2" style="background-color:#b4505a;"></li>
                <li data-target="#materie-prime-ristorante-bortoleto" data-slide-to="3" style="background-color:#b4505a;"></li>
            </ol>
            <!--/.Indicators-->

            <!--Slides-->
            <div class="carousel-inner pt-5 pb-5" role="listbox" style="min-height: 600px;  ">

                <div class="carousel-item active background slide-materie-carousel mt-5" style="position: relative;display: table;background-image: url(/console/img/immagini_sito/ristorante/la-carne/manzo-al-sesamo.jpg); background-color: rgba(0,0,0,.3); background-blend-mode: color; height: 600px;">
                    <div class="et_pb_top_inside_divider divider-custom divider6"></div>
                    <div style="display: table-cell;vertical-align: middle;">
                        <div class="title-container-stagioni" data-animation="animated fadeInDown" style="width: 80%;margin: auto;">
                            <h4 class="h3-responsive">La Stagionalità dei prodotti</h4>
                            <p style="">Le Materie Prime</p>
                        </div>
                    </div>
                </div>

                <!--La Carne -->
                <div class="carousel-item" style="height: 100%;">
                    <div class="et_pb_top_inside_divider divider-custom divider6"></div>
                    <div class="row" style="margin-top: 6rem;">
                        <div class="col-lg-6">
                            <div data-animation="animated fadeInLeft" style="height:100%; position: relative;display: table;width: auto; animation-duration: 2s;margin: auto;">
                                <div style="display: table-cell;vertical-align: middle;">
                                    <img data-src="/console/img/immagini_sito/ristorante/la-carne/manzo-al-sesamo.jpg" class="img-stagioni lazy" alt="La Carne"/>
                                </div>
                            </div>
                        </div>
                        <div data-animation="animated fadeInUp" style="animation-duration: 2s;" class="col-lg-6">      
                            <h4 class="sottotitoli" style="text-align: right;">La Qualità nel piatto</h4>  
                            <h3 class="styled mb-5" style="text-align: right;margin: 0;font-weight: 600!important;text-transform: uppercase!important;">La Carne</h3>
                            <div id="text" class="description" style="font-size: 16px;font-weight: 400;"><p>Nasciamo come <strong>ristorante macelleria</strong>&nbsp;e proprio per questo motivo la carne rappresenta la parte pi&ugrave; importante della nostra cucina. Tra i diversi tipi di carne che offriamo quelli che pi&ugrave; meritano attenzione sono sicuramente la <strong>carne rossa</strong> e la <strong>selvaggina</strong>.</p><p>Da sempre la <strong><a title="Macelleria Dellantonio" href="https://macelleriadellantonio.it/La-Macelleria" target="_blank">macelleria Dellantonio</a></strong> si basa sulla filosofia della <strong>filiera a km 0</strong>. Questo significa che la nostra qualit&agrave; nel piatto parte dai pascoli della Val di Fiemme dove vivono bovini 100% Italiani e locali. Da qui tutto avviene esclusivamente nei nostri laboratori di Predazzo dove&nbsp;ci preoccupiamo di <strong>frollare la carne</strong> e scegliere i tagli migliori per preparare&nbsp;<strong>secondi piatti di carne raffinati</strong> e salutari che vengono incontro alle esigenze dei palati pi&ugrave; fini mantenendo un perfetto equilibrio tra gustosit&agrave; e leggerezza.<br />Ci troviamo a 1000 metri, ai piedi delle <strong>Dolomiti</strong> e qui vivono molti animali selvatici come Cervi, Caprioli e Camosci. Anche in questo la macelleria Dellantonio punta sul km 0, per questo in autunno e primavera, quando i cacciatori iniziano la loro attivit&agrave;, il nostro menu si adegua alla <strong>stagione</strong> offrendo secondi piatti raffinati ottimi per una <strong>cena a base di carne</strong> locale.</p><p>&nbsp;</p></div>
                        </div>
                    </div>
                </div>
                <!--/La Carne -->

                <!--Dal Trentino -->
                <div class="carousel-item" style="height: 100%;">
                    <div class="et_pb_top_inside_divider divider-custom divider6"></div>
                    <div class="row" style="margin-top: 6rem;">
                        <div class="col-lg-6">
                            <div data-animation="animated fadeInLeft" style="height:100%; position: relative;display: table;width: auto; animation-duration: 2s;margin: auto;">
                                <div style="display: table-cell;vertical-align: middle;">
                                    <img data-src="/console/img/immagini_sito/ristorante/dal-trentino/orzo-goever.jpg" class="img-stagioni lazy" alt="Dal Trentino"/>
                                </div>
                            </div>
                        </div>
                        <div data-animation="animated fadeInUp" style="animation-duration: 2s;" class="col-lg-6">      
                            <h4 class="sottotitoli" style="text-align: right;">La Qualità nel piatto</h4>  
                            <h3 class="styled mb-5" style="text-align: right;margin: 0;font-weight: 600!important;text-transform: uppercase!important;">Dal Trentino</h3>
                            <div id="text" class="description" style="font-size: 16px;font-weight: 400;"><p>Il nostro territorio &egrave; caratterizzato da una <strong>biodiversit&agrave; unica</strong> che rende i settori pi&ugrave; importanti proprio quelli dell'<strong>allevamento</strong> e dell'<strong>agricoltura</strong>.&nbsp;<br />Da qui la nostra volont&agrave; di&nbsp;appoggiarci il pi&ugrave; possibile agli allevatori e agricoltori Trentini, sia per mantenere la <strong>filiera km0</strong>, sia per una sicurezza sulla provenienza e sulla qualit&agrave; dei prodotti.<p/><p>Tra le principali <strong>eccellenze Trentine</strong> che siamo onorati di poter portare sui tavoli del nostro ristorante citiamo la pasta <a title="Pastificio Felicetti" href="https://www.felicetti.it/" target="_blank" rel="nofollow">Felicetti</a>&nbsp;&nbsp;<img src="https://www.quotidianosostenibile.it/wp-content/uploads/2016/02/felicetti-logo.jpg" alt="Pastificio Felicetti" width="28" height="29" />, pastificio nato a Predazzo e ormai di fama internazionale per la qualit&agrave; dei suoi grani e delle sue lavorazioni. Il grano <a title="Goever" href="http://www.goever.it/" target="_blank" rel="nofollow">Goever&nbsp;<img src="http://www.goever.it/wp-content/uploads/2016/11/cropped-cropped-Gover-001.jpg" alt="Goever" width="63" height="21" /></a>, senza il quale il nostro orzo Trentino non sarebbe la stessa cosa. L'<a title="Uovo di Montagna" href="https://www.uovadimontagna.info/" target="_blank">uovo di montagna</a>&nbsp;<img src="https://static.wixstatic.com/media/d51a8c_dd50b50673ea4bb388dd74b805bbbd12~mv2.png/v1/fill/w_144,h_189,al_c,q_85,usm_0.66_1.00_0.01/d51a8c_dd50b50673ea4bb388dd74b805bbbd12~mv2.webp" alt="Uovo di Montagna" width="24" height="32" /> che rappresenta la volont&agrave; di un consumo sostenibile che&nbsp;garantisce la salute e la qualit&agrave; della vita degli animali a favore delle propriet&agrave; invidiabili delle uova prodotte nei loro allevamenti.<br />Direttamente dal lago di Garda le Sarde e Sardine degli allevamenti <a title="Armanini" href="https://www.armanini.it/" target="_blank">Armanini&nbsp;<img src="https://www.trentiner.it/media/catalog/category/cache/585X265/Senza_titolo_1.jpg" alt="Armanini" width="82" height="37" /></a>che garantiscono sicurezza e genuinit&agrave;.<br /><br />Inoltre da sempre la <a title="Macelleria Dellantonio" href="/Bortoleto/La-Macelleria">macelleria Dellantonio</a> si appoggia agli allevamenti locali della val di Fiemme e Fassa.</p></div>
                        </div>
                    </div>
                </div>
                <!--/Dal Trentino -->

                <!--Fatto da Noi -->
                <div class="carousel-item" style="height: 100%;">
                    <div class="et_pb_top_inside_divider divider-custom divider6"></div>
                    <div class="row" style="margin-top: 6rem;">
                        <div class="col-lg-6">
                            <div data-animation="animated fadeInLeft" style="height:100%; position: relative;display: table;width: auto; animation-duration: 2s;margin: auto;">
                                <div style="display: table-cell;vertical-align: middle;">
                                    <img data-src="/console/img/immagini_sito/ristorante/fatto-da-noi/frittelle.jpg" class="img-stagioni lazy" alt="Fatto da Noi"/>
                                </div>
                            </div>
                        </div>
                        <div data-animation="animated fadeInUp" style="animation-duration: 2s;" class="col-lg-6">      
                            <h4 class="sottotitoli" style="text-align: right;">La Qualità nel piatto</h4>  
                            <h3 class="styled mb-5" style="text-align: right;margin: 0;font-weight: 600!important;text-transform: uppercase!important;">Fatto da Noi</h3>
                            <div id="text" class="description" style="font-size: 16px;font-weight: 400;"><p>Quando le sale si svuotano e la tensione del servizio sparisce in cucina inizia la <strong>produzione</strong>.&nbsp;<p/><p>Quello a cui non rinunciamo sono le cose <strong>fatte in casa</strong> che esaltano tutti gli aromi e i sapori dei <strong>prodotti freschi</strong> e di qualit&agrave;.<br />I <strong>grissini</strong> che trovi al tavolo, assieme ai piccoli <strong>panini</strong> dalla forma tozza e dalla consistenza morbida dentro e croccante fuori, sono rigorosamente impastati e sfornati quotidianamente dai nostri forni.<br />Il nostro <strong><a href='#menu'>menù</a></strong> punta a esaltare la <strong>stagionalit&agrave; dei prodotti</strong>, per cui non sempre troverai alcuni piatti, ma se avrai la fortuna di poterci venire a trovare nel periodo giusto quello che ti aspetta sono i <strong>tortellini di pasta fresca</strong> fatta in casa, cucinati al momento e serviti asciutti o in un delizioso brodo di <strong>verdure di stagione</strong> per deliziarti anche con il profumo.&nbsp;<br />Per concludere in dolcezza tutti i nostri <strong>gelati</strong> sono sempre fatti da noi. Vieni a provare il gelato al <strong>Vin Brul&egrave;</strong> in autunno!&nbsp;</p><p>Molte altre pietanze sono fatte in casa da noi e per scoprirle ti invitiamo a <strong>venire a trovarci</strong>, saremmo lieti d'intrattenervi con le migliori <strong>specialit&agrave; trentine</strong>!</p></div>
                        </div>
                    </div>
                </div>
                <!--/Fatto da Noi -->

            </div>
            <!--/.Slides-->

            <!--Controls-->
            <a class="carousel-control-prev" href="#materie-prime-ristorante-bortoleto" role="button" data-slide="prev" style="color:#b4505a;">
                <span aria-hidden="true"><i style="font-size: xx-large;" class="fas fa-angle-left"></i></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#materie-prime-ristorante-bortoleto" role="button" data-slide="next" style="color:#b4505a;">
                <span aria-hidden="true"><i style="font-size: xx-large;" class="fas fa-angle-right"></i></span>
                <span class="sr-only">Next</span>
            </a>
            <!--/.Controls-->

        </div>
        <!--/.Carousel Wrapper-->
    </section>

    <!-- Section: Testimonials v.2 Facebook review -->
    <section class="effetto1 container text-center my-5" style='margin: auto auto; color: white !important;'>
        <h4 class="sottotitoli" style="text-align: center;">testimonials</h4>  
        <h2 class="styled" style="text-align: center; margin: 0; color: black;">Dicono di noi</h2>
        <script src="https://apps.elfsight.com/p/platform.js" defer></script>
        <div class="elfsight-app-2dbedd8a-3277-4550-a616-d563381ec957"></div>
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
    <section class="text-center my-5">
        <div class="et_pb_top_inside_divider ui-sortable-handle divider-custom divider3" style="margin-bottom: 5rem;"></div>
        <h2 class="h1-responsive font-weight-bold my-5" id="raggiungici-ristorante">Contatti</h2>            
        <div class='row flex-column-reverse flex-lg-row' style='width: 100%; margin: 0;'>
            <div class='col-lg-8'>
                <div class="mb-5 mt-5" data-aos="zoom-out-right" data-aos-duration="2000">
                    <div class="mapouter"><div class="gmap_canvas"><iframe style="min-height:550px;" width="100%" height="100%" id="gmap_canvas" src="https://maps.google.com/maps?q=ristorante%20bortoleto%20predazzo&t=&z=15&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe><a href="https://www.divi-discounts.com"></a></div><style>.mapouter{position:relative;text-align:right;height:100%;width:100%;min-height:550px;}.gmap_canvas {overflow:hidden;background:none!important;height:100%;width:100%;min-height:550px;}</style></div>
                </div>
            </div>
            <div class='col-lg-4'>
                <div class='contactInfo' data-aos="zoom-in-right" data-aos-duration="2000">
                    <h3 style='font-weight: 900;'>PREDAZZO</h3>
                    <a href="mailto:ristorantebortoleto@gmail.com"><p>ristorantebortoleto@gmail.com</p></a>
                    <a href="tel:0462500261"><p>0462-500261</p></a>
                    <a href="https://www.google.com/maps/place/Ristorante+'l+Bortoleto/@46.310865,11.6015513,16.75z/data=!4m5!3m4!1s0x4778633806ab5a6d:0xef49608af9171d85!8m2!3d46.3108156!4d11.6011964" target='_blank' rel="noopener"><p>Via Cavour 2</p></a>
                </div>
            </div>
        </div>
        <hr style="border: 3px solid rgb(121, 85, 72); width: 50%; border-radius: 100%;" id="contattaci-ristorante"/>
        <div class="container comment-form" data-aos="fade-right" data-aos-duration="2000">
            <!--Section description-->
            <p class="text-center w-responsive mx-auto mb-5">Hai qualche domanda? Non esitare a contattarci, ti risponderemo il prima possibile</p>
            <form method="POST" class="needs-validation" novalidate id="sendEmailForm">
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="nome">Nome</label>
                        <input type="text" class="form-control" id="nome" <c:if test="${nome ne null && cognome ne null}">value="${nome.replace(SPACES_COOKIE, ' ')} ${cognome.replace(SPACES_COOKIE, ' ')}"</c:if>placeholder="Il tuo nome" required>
                            <div class="invalid-feedback">
                                Il campo relativo al nome non è complilato in modo corretto
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" <c:if test="${email ne null}">value="${email.replace(SPACES_COOKIE, " ")}"</c:if> placeholder="La tua email" required>
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

    <footer id="footer" class="container-fluid text-center">

    </footer>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.7.2/js/all.js" integrity="sha384-0pzryjIRos8mFBWMzSSZApWtPl/5++eIfzYmTgBBmXYdhvxPc+XcFEk+zJwDgWbP" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <!-- MDB core JavaScript -->
    <script src="js/parallax.js"></script>
    <script type="text/javascript" src="js/mdb.min.js">async;</script>
    <script src="js/vari-min.js" async></script>
    <script src="js/modernizr-min.js" async></script>
    <script src="js/main-min.js" ></script>   
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/nav.js"></script>
    <script type="text/javascript" src="js/jquery.lazy.min.js"></script>
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

        /* Demo Scripts for Bootstrap Carousel and Animate.css article
         * on SitePoint by Maria Antonietta Perna
         */
        (function ($) {
            //Function to animate slider captions
            function doAnimations(elems) {
                //Cache the animationend event in a variable
                var animEndEv = "webkitAnimationEnd animationend";

                elems.each(function () {
                    var $this = $(this),
                            $animationType = $this.data("animation");
                    $this.addClass($animationType).one(animEndEv, function () {
                        $this.removeClass($animationType);
                    });
                });
            }

            //Variables on page load
            var $myCarousel = $("#materie-prime-ristorante-bortoleto"),
                    $firstAnimatingElems = $myCarousel
                    .find(".carousel-item:first")
                    .find("[data-animation ^= 'animated']");

            //Initialize carousel
            $myCarousel.carousel();

            //Animate captions in first slide on page load
            doAnimations($firstAnimatingElems);

            //Other slides to be animated on carousel slide event
            $myCarousel.on("slide.bs.carousel", function (e) {
                var $animatingElems = $(e.relatedTarget).find(
                        "[data-animation ^= 'animated']"
                        );
                doAnimations($animatingElems);
            });
        })(jQuery);
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
        //Load Story page
        var menu = "", materie = "";
        var mirrors;
        function backMenu() {
            $('#menu').html(menu);
            $('#menu').removeClass("container");
            for (i = 0; i < mirrors.length; i++) {
                $("body").append(mirrors[i]);
            }
            aosInit();
        }
        //Load Menu page
        function callMenu(nome, immagine) {
            $.ajax({
                type: "GET",
                url: "ajax/ristorante/menu.jsp",
                data: {nome: nome, immagine: immagine},
                cache: false,
                success: function (response) {
                    menu = $('#menu').html().toString();
                    $('#menu').addClass("container");
                    $('#menu').html("");
                    $('#menu').html(response);
                    mirrors = $('.parallax-mirror');
                    $('.parallax-mirror').remove();
                    aosInit();
                },
                error: function () {
                    alert("Errore call Menu");
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
                    data: {nome: $('#nome').val(), email: $('#email').val(), oggetto: $('#oggetto').val(), messaggio: $('#messaggio').val(), recaptcha: $("#g-recaptcha-response").val(), for : 'ristorante'},
                    cache: false,
                    success: function (response) {
                        $('#status').html("<h2>Grazie! Ti risponderemo appena possibile</h2>");
                        $('#loading').addClass("invisible");
                    },
                    error: function () {
                        $('#status').html("<h2>Ouch! Qualcosa è andato storto. Riprova tra qualche minuto, o scrivi a <a href='mailto:ristorantebortoleto@gmail.com'><i>ristorantebortoleto@gmail.com</i></a></h2>");
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

        $(function () {
            $('.lazy').lazy();
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
