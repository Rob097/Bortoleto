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
        <meta property="og:title"         content="Ristorante 'l Bortoleto" />
        <meta property="og:description"   content="Ristorante Macelleria a Predazzo Val di Fiemme Trentino. Scopri da dove nasce la nostra passione per la buona cucina e come la concretizziamo." />
        <meta property="og:image"         content="https://lh3.googleusercontent.com/kbvJO4XfUpn2DEQ_7l789Dz_nZjXYGJVsr_Ot22TEtR0LfqMVDPXWujbQqCwP8zQ6X3k75CaRVG61LZw-nC2DHpoi1hSGsqEMnZBmfloRAH4vvD2lWgZVRzrEC_g-NtFWt_mB2DRkA=w2400" />
        <meta property="og:site_name" content="Macelleria Ristorante Dellantonio 'L Bortoleto">
        <meta property="fb:app_id"         content="320307085338651" />

        <link rel="icon" href="https://lh3.googleusercontent.com/kbvJO4XfUpn2DEQ_7l789Dz_nZjXYGJVsr_Ot22TEtR0LfqMVDPXWujbQqCwP8zQ6X3k75CaRVG61LZw-nC2DHpoi1hSGsqEMnZBmfloRAH4vvD2lWgZVRzrEC_g-NtFWt_mB2DRkA=w2400" type="image/png">
        <title>Ristorante 'l Bortoleto</title>
        <meta name="Description" content="Ristorante a Predazzo Val di Fiemme Trentino. Scopri da dove nasce la nostra passione per la buona cucina e come la concretizziamo.">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="theme-color" content="#31353d">        

        <!-- bootstrap include -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
        <!-- fine bootstrap include -->
        <link href="css/mdb.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/parallax.css">
        <link rel="stylesheet" href="css/font-min.css">
        <link rel="stylesheet" href="css/style-min.css">
        <link rel="stylesheet" href="css/Cards-min.css" type="text/css">
        <link rel="stylesheet" href="css/prodotto-min.css">
        <link rel="stylesheet" href="css/macelleriaCSS-min.css">
        <link rel="stylesheet" href="css/vari-min.css">
        <link rel="stylesheet" href="css/animations-min.css">
        <link rel="stylesheet" href="css/ristorante-min.css">
        <link rel="stylesheet" href="css/animate-min.css">        
        <link rel="stylesheet" href="css/navbar-min.css">
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
            h3.styled{
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
            "image" : "https://lh3.googleusercontent.com/kbvJO4XfUpn2DEQ_7l789Dz_nZjXYGJVsr_Ot22TEtR0LfqMVDPXWujbQqCwP8zQ6X3k75CaRVG61LZw-nC2DHpoi1hSGsqEMnZBmfloRAH4vvD2lWgZVRzrEC_g-NtFWt_mB2DRkA=w2400",
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
            "logo": "https://lh3.googleusercontent.com/kbvJO4XfUpn2DEQ_7l789Dz_nZjXYGJVsr_Ot22TEtR0LfqMVDPXWujbQqCwP8zQ6X3k75CaRVG61LZw-nC2DHpoi1hSGsqEMnZBmfloRAH4vvD2lWgZVRzrEC_g-NtFWt_mB2DRkA=w2400",
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
            <img width="90vh" src="https://lh3.googleusercontent.com/kbvJO4XfUpn2DEQ_7l789Dz_nZjXYGJVsr_Ot22TEtR0LfqMVDPXWujbQqCwP8zQ6X3k75CaRVG61LZw-nC2DHpoi1hSGsqEMnZBmfloRAH4vvD2lWgZVRzrEC_g-NtFWt_mB2DRkA=w2400" alt="Logo">
        </a>
        <a id="nav-logo-title" class="navbar-brand js-scroll-trigger" href="<c:url value="/bottega.jsp"/>">'L Bortoleto</a>
        <a class="menu-cart-button hs-cart" href="<c:url value="/bottega.jsp"/>">
            <i style="margin-right: 20px; font-size: 30px; vertical-align:middle;" class="fas fa-shopping-cart"></i>
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

    <div id="carousel-example-1z" class="carousel slide carousel-fade" data-ride="carousel" style="height: 101vh;">

        <!--Indicators-->
        <ol class="carousel-indicators">
            <li data-target="#carousel-example-1z" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-1z" data-slide-to="1"></li>
            <li data-target="#carousel-example-1z" data-slide-to="2"></li>
            <li data-target="#carousel-example-1z" data-slide-to="3"></li>
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
                    <img style="width: 60vh;" src="https://lh3.googleusercontent.com/kbvJO4XfUpn2DEQ_7l789Dz_nZjXYGJVsr_Ot22TEtR0LfqMVDPXWujbQqCwP8zQ6X3k75CaRVG61LZw-nC2DHpoi1hSGsqEMnZBmfloRAH4vvD2lWgZVRzrEC_g-NtFWt_mB2DRkA=w2400" alt="Ristorante 'l Bortoleto" />

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
                <div class="view" style="background-image: url('https://lh3.googleusercontent.com/Qfpukrg2L5m_JGZ3tvX3skJbly1GCSUndEN-I3GJIqqNK90-d15pArC0ZxgwJDiRZh312e1QCQPnLN_RO0raBQHrPDcJCTwy1rV6vNkHyBZbyYC_EGVbBDMzY_CFbGa4DbxGcGfVvg=w2400'); height: 100%; width: 100%; background-size: cover; background-position: center center; background-repeat: no-repeat;">
                </div>
                <div class="carousel-caption capBox">                        
                    <h3 class="h3-responsive" style="font-weight: 900;">Bottega di Predazzo</h3>
                    <p>Via Cesare Battisti 2</p><br>
                </div>
            </div>
            <!--/First slide -->

            <!--Second slide -->
            <div class="carousel-item" style="height: 100%;">
                <div class="view" style="background-image: url('https://lh3.googleusercontent.com/ixN4bzXDDBzJpoHGooHd3Ryo5f1FTKoJgQV4Bs-lgGo6_k8zwVq9r3RCuTrSwtZ2eIWzc8ysfoZT398MDcOV0cJYh1vhhA9Yuo42G8Rmy_qTlluZIp68fVjN3IVZoK8HJIPZNX-ngg=w2400'); background-repeat: no-repeat; background-size: cover; width: 100%; height: 100%; background-position: center center;">
                </div>
                <div class="carousel-caption capBox">
                    <h3 class="h3-responsive" style="font-weight: 900;">Bottega di Campitello</h3>
                    <p>Piaz de Ciampedel 28</p><br>
                </div>
            </div>
            <!--/Second slide -->

            <!--Third slide -->
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

    <div id="home" class="wrap-intro">
        <div class="mt-5 mb-5 text-center">
            <h2 class="bortoTitle" data-aos="fade-right" data-aos-duration="2000">'L Bortoleto</h2>
            <h1 class="macTitle" data-aos="fade-right" data-aos-duration="2000">Ristorante 'L Bortoleto</h1>
        </div>

        <div id="carousel-team" class="carousel slide" data-ride="carousel">

            <!--Indicators-->
            <ol class="carousel-indicators" style="margin: -3rem auto;">
                <li data-target="#carousel-team" data-slide-to="0" class="active" style="background-color: black;"></li>
                <li data-target="#carousel-team" data-slide-to="1" style="background-color: black;"></li>
            </ol>
            <!--/.Indicators-->

            <div id="innerTeam" class="container carousel-inner" role="listbox">
                <div class="carousel-item active">
                    <div class="row">
                        <div class="text-intro col-sm-10 col-md-7 wow fadeInDown" data-wow-delay="0.5s" style="margin: auto auto; visibility: visible; animation-delay: 0.5s; animation-name: fadeInDown;">
                            <h3 class="sottotitoli">Chef</h3>
                            <h2 class="styled">Simone Dellantonio</h2>
                            <p class="description">
                                Donec quis euismod purus. Donec feugiat ligula rhoncus, varius nisl sed, tincidunt lectus. Nulla vulputate, lectus vel volutpat efficitur, orci lacus sodales sem, at interdum quam ligula sit amet quam. Praesent molestie est ut lorem malesuada pretium at sit amet magna.
                            </p>
                            <p class="description">
                                Donec quis euismod purus. Donec feugiat ligula rhoncus, varius nisl sed, tincidunt lectus. Nulla vulputate, lectus vel volutpat efficitur, orci lacus sodales sem, at interdum quam ligula sit amet quam. Praesent laoreet malesuada ex, sed blandit sem dictum id. Donec vulputate ultricies nibh, quis dapibus ex cursus sit amet. Duis non ex pellentesque, sollicitudin justo a, porttitor magna. Mauris eleifend est purus. Phasellus non ornare nunc, nec ullamcorper eros. Praesent molestie est ut lorem malesuada pretium at sit amet magna. Sed et volutpat sem. 
                            </p>
                        </div>

                        <div style="margin: auto auto;" class="wrap-pic-intro col-sm-10 col-md-5">
                            <div class="row">
                                <div class="col-12">
                                    <div class="pic-intro wow zoomIn" style="visibility: visible; animation-name: zoomIn;">
                                        <img style="border-radius: 5px;" class="lazy" data-src="http://templates.aucreative.co/deli/images/home-onepage-img-intro.jpg" alt="Chef">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="carousel-item ">

                    <div class="row"> 
                        <div class="text-intro col-sm-10 col-md-7 wow fadeInDown order-md-2" data-wow-delay="0.5s" style="margin: auto auto; visibility: visible; animation-delay: 0.5s; animation-name: fadeInDown;">
                            <h3 class="sottotitoli">Sala</h3>
                            <h2 class="styled">Valeria Dellantonio</h2>
                            <p class="description">
                                Donec quis euismod purus. Donec feugiat ligula rhoncus, varius nisl sed, tincidunt lectus. Nulla vulputate, lectus vel volutpat efficitur, orci lacus sodales sem, at interdum quam ligula sit amet quam. Praesent molestie est ut lorem malesuada pretium at sit amet magna.
                            </p>
                            <p class="description">
                                Donec quis euismod purus. Donec feugiat ligula rhoncus, varius nisl sed, tincidunt lectus. Nulla vulputate, lectus vel volutpat efficitur, orci lacus sodales sem, at interdum quam ligula sit amet quam. Praesent laoreet malesuada ex, sed blandit sem dictum id. Donec vulputate ultricies nibh, quis dapibus ex cursus sit amet. Duis non ex pellentesque, sollicitudin justo a, porttitor magna. Mauris eleifend est purus. Phasellus non ornare nunc, nec ullamcorper eros. Praesent molestie est ut lorem malesuada pretium at sit amet magna. Sed et volutpat sem. 
                            </p>
                        </div>

                        <div style="margin: auto auto;" class="wrap-pic-intro col-sm-10 col-md-5 order-md-1">
                            <div class="row">
                                <div class="col-12">
                                    <div class="pic-intro wow zoomIn" style="visibility: visible; animation-name: zoomIn;">
                                        <img style="border-radius: 5px;" class="lazy" data-src="https://careersmart.org.uk/sites/default/files/2017-04/Waiters-and-waitresses.jpg" alt="Sala">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Controls-->
            <a class="carousel-control-prev" data-target="#carousel-team" role="button" data-slide="prev">
                <span aria-hidden="true"><i style="font-size: xx-large;" class="fas fa-angle-left"></i></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" data-target="#carousel-team" role="button" data-slide="next">
                <span aria-hidden="true"><i style="font-size: xx-large;" class="fas fa-angle-right"></i></span>
                <span class="sr-only">Next</span>
            </a>
            <!--/.Controls-->
        </div><!-- Fine carousel -->            
    </div>

    <section id="menu" class="mb-5">
        <div id="sections" class="container">                    
            <div class="mt-5 mb-5 text-center">
                <h2 class="macTitle" data-aos="fade-right" data-aos-duration="2000">Il Menu</h2>
            </div>

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

    <hr style="border: 3px solid rgb(121, 85, 72); width: 50%; border-radius: 100%;"/>

    <section id="materiePrime" class="content-menu-02">
        <div class="container" style="padding-top: 5rem;">
            <div class="mb-5 text-center">
                <h2 class="macTitle" data-aos="fade-right" data-aos-duration="2000">Le nostre Materie Prime</h2>
            </div>
            <div class="row">
                <div class="col-content-menu-02 col-sm-7 col-md-3" style="margin: auto auto;">
                    <div class="row">
                        <div class="col-12 wow fadeInLeft" style="visibility: visible; animation-name: fadeInLeft;">
                            <a href="#materiePrime" onclick="callMaterie('Fatto da noi')" class="hover-img">
                                <img class="lazy" data-src="http://templates.aucreative.co/deli/images/img-menu-page-02-01.jpg" alt="FattoDaNoi">
                                <h3 class="text-in-img-menu-02">Fatto da noi</h3>
                            </a>
                        </div>
                        <div class="col-12 wow fadeInLeft" style="visibility: visible; animation-name: fadeInLeft;">
                            <a href="#materiePrime" onclick="callMaterie('Varie')" class="hover-img">
                                <img class="lazy" data-src="http://templates.aucreative.co/deli/images/img-menu-page-02-03.jpg" alt="Varie">
                                <h3 class="text-in-img-menu-02">Varie</h3>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-content-menu-02 col-sm-7 col-md-5" style="margin: auto auto;">
                    <div class="row">
                        <div class="col-12 wow fadeInDown" style="visibility: visible; animation-name: fadeInDown;">
                            <a href="#materiePrime" onclick="callMaterie('La Carne')" class="hover-img">
                                <img class="lazy" data-src="http://templates.aucreative.co/deli/images/img-menu-page-02-02.jpg" alt="LaCarne">
                                <h3 class="text-in-img-menu-02">La Carne</h3>
                            </a>
                        </div>
                        <div class="col-12 wow fadeInUp" style="visibility: visible; animation-name: fadeInUp;">
                            <a href="#materiePrime" onclick="callMaterie('La Pasta')" class="hover-img">
                                <img class="lazy" data-src="http://templates.aucreative.co/deli/images/img-menu-page-02-04.jpg" alt="LaPasta">
                                <h3 class="text-in-img-menu-02">La Pasta</h3>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-content-menu-02 col-sm-7 col-md-4 wow fadeInRight" style="visibility: visible; animation-name: fadeInRight; margin: auto auto;">
                    <a href="#materiePrime" onclick="callMaterie('Il Vino')" class="hover-img">
                        <img class="lazy" data-src="http://templates.aucreative.co/deli/images/img-menu-page-02-05.jpg" alt="IlVino">
                        <h3 class="text-in-img-menu-02">Il Vino</h3>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Section: Testimonials v.2 Facebook review -->
    <section class="effetto1 container text-center my-5" style='margin: auto auto; color: white !important;'>
        <h4 class="sottotitoli" style="text-align: center;">testimonials</h4>  
        <h3 class="styled" style="text-align: center; margin: 0; color: black;">Dicono di noi</h3>
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
                <div class="mb-5 mt-5" id="map1" data-aos="zoom-out-right" data-aos-duration="2000"></div>
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
    <script src="js/main-min.js" async></script>   
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
    </script>
    <script>
        var map1;
        function initMap() {
            //The locations
            var rist = {lat: 46.310835, lng: 11.601194};
            // The map, centerd
            map1 = new google.maps.Map(
                    document.getElementById('map1'), {zoom: 16.75, center: rist});
            // The marker, positioned at Uluru
            var marker = new google.maps.Marker({position: rist, map: map1});
            marker.addListener("click", function () {
                window.open("https://www.google.com/maps/place/Ristorante+'l+Bortoleto/@46.310865,11.6015513,16.75z/data=!4m5!3m4!1s0x4778633806ab5a6d:0xef49608af9171d85!8m2!3d46.3108156!4d11.6011964");
            });
        }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAdJPQRGr1Dh2vWyM2gq8pMgMYsILS_le4&callback=initMap"
            async defer>
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
        function backMaterie() {
            $('#materiePrime').html(materie);
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
        //Load Materie Prime page
        function callMaterie(id) {
            $.ajax({
                type: "GET",
                url: "ajax/ristorante/materie.jsp",
                data: {id: id},
                cache: false,
                success: function (response) {
                    materie = $('#materiePrime').html().toString();
                    $('#materiePrime').html(response);
                    aosInit();
                },
                error: function () {
                    alert("Errore call materie");
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
