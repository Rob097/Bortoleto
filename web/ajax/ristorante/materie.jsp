<%-- 
    Document   : materie
    Created on : 30-apr-2019, 18.41.24
    Author     : Roberto97
--%>


<!-- Per impedire alla maggior parte dei motori di ricerca di indicizzare la pagina -->
<meta name="robots" content="noindex">
    <!-- Per impedire solo a Google di indicizzare la pagina -->
    <meta name="googlebot" content="noindex">


        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <c:set var="request" value="<%=request%>"/>
        <c:set var="type" value="${request.getParameter('id')}"/>


        <c:choose>
            <c:when test="${type eq 'La Carne'}">
                <c:set var="firstCaptionH3" value="Carne di manzo" />
                <c:set var="firstCaptionP" value="Frollata 30 giorni" />
                <c:set var="firstIMG" value="https://lh3.googleusercontent.com/ixN4bzXDDBzJpoHGooHd3Ryo5f1FTKoJgQV4Bs-lgGo6_k8zwVq9r3RCuTrSwtZ2eIWzc8ysfoZT398MDcOV0cJYh1vhhA9Yuo42G8Rmy_qTlluZIp68fVjN3IVZoK8HJIPZNX-ngg=w2400" />
            </c:when>
            <c:otherwise>
                <c:set var="firstCaptionH3" value="In fase di completamento" />
                <c:set var="firstCaptionP" value="In fase di completamento" />
                <c:set var="firstIMG" value="https://lh3.googleusercontent.com/ixN4bzXDDBzJpoHGooHd3Ryo5f1FTKoJgQV4Bs-lgGo6_k8zwVq9r3RCuTrSwtZ2eIWzc8ysfoZT398MDcOV0cJYh1vhhA9Yuo42G8Rmy_qTlluZIp68fVjN3IVZoK8HJIPZNX-ngg=w2400" />
            </c:otherwise>
        </c:choose>


        <div class="container" style="padding-top: 5rem;">
            <div class="mb-5 text-center">
                <a class="buttonS" href="#materiePrime" onclick="backMaterie();" style='color: black; background-color: white;'>Torna indietro</a><br>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <!-- INIZIO CAROUSEL -->
                                <div id="carousel${type.replace(' ', '')}" class="carousel slide" data-interval="85000">
                                    <ol class="carousel-indicators">
                                        <li data-target="#carousel${type.replace(' ', '')}" data-slide-to="0" class="active"></li>
                                        <li data-target="#carousel${type.replace(' ', '')}" data-slide-to="1"></li>
                                        <li data-target="#carousel${type.replace(' ', '')}" data-slide-to="2"></li>
                                    </ol>
                                    <div class="carousel-inner skyblue">

                                        <!-- first slide -->
                                        <div class="carousel-item active background slide-materie-carousel" style="background:linear-gradient(0deg,rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.35)),url(${firstIMG});">
                                            <div class="carousel-caption d-md-block">
                                                <h3 class="icon-container" style="width: 100%; margin-bottom: 0;">
                                                    <svg class="n1" width="10px" height="100%" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                                                        <path id="Rectangle" fill="none" stroke="#ad9966" stroke-width="7" d="M0,20 L0,120.0"></path>
                                                    </svg>
                                                </h3>
                                                <h3 data-animation="animated fadeInDown" style="margin-bottom: -15px; font-weight: bold;">
                                                    ${type}
                                                </h3>
                                                <h3 class="icon-container" style="width: 100%; margin-bottom: 0;">
                                                    <svg class="n2" width="10px" height="100%" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                                                        <path id="Rectangle" fill="none" stroke="#ad9966" stroke-width="7" d="M0,20 L0,100.0"></path>
                                                    </svg>
                                                </h3>
                                            </div>
                                        </div>

                                        <!-- second slide -->
                                        <div class="carousel-item background2 slide-materie-carousel">
                                            <div class="carousel-caption captionBG">
                                                <h3 class="h3-responsive">${firstCaptionH3}</h3>
                                                <p>${firstCaptionP}</p>
                                            </div>
                                        </div>

                                        <!-- third slide -->
                                        <div class="carousel-item background3 slide-materie-carousel">
                                            <div class="carousel-caption captionBG">
                                                <h3 class="h3-responsive">${firstCaptionH3}</h3>
                                                <p>${firstCaptionP}</p>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- controls -->
                                    <a class="carousel-control-prev" href="#carousel${type.replace(' ', '')}" role="button" data-slide="prev">
                                        <span aria-hidden="true"><i style="font-size: xx-large;" class="fas fa-angle-left"></i></span>
                                        <span class="sr-only">Previous</span>
                                    </a>
                                    <a class="carousel-control-next" href="#carousel${type.replace(' ', '')}" role="button" data-slide="next">
                                        <span aria-hidden="true"><i style="font-size: xx-large;" class="fas fa-angle-right"></i></span>
                                        <span class="sr-only">Next</span>
                                    </a>
                                </div>
                                <!-- FINE CAROUSEL -->
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <h4 class="sottotitoli" style="text-align: right;">La Qualità nel piatto</h4>       
                        <h3 class="styled" style="text-align: right; margin: 0;">${type}</h3>
                        <div>
                            <p class="description">
                                Le radici della nostra attività , risalenti a più di <i><b>110 anni fa</b></i>, hanno origine a <i><strong>Predazzo</strong></i> in val di Fiemme (Trentino).
                                La passione nel nostro lavoro ci ha sempre spronato a realizzare prodotti di <i><strong>altissima qualità</strong></i> della tradizione Trentina. 
                                Con il passare degli anni abbiamo rivoluzionato le nostre sedi e i servizi che offriamo quotidianamente ai nostri clienti, 
                                ed è per questo motivo che siamo stati e saremo sempre un <i><b>punto di riferimento</b></i> sia per i nostri compaesani, che ogni 
                                giorno scelgono la qualità  e la professionalità  che riusciamo ad offrire, sia per persone che ogni anno decidono di 
                                affidarsi a noi per scoprire i <i><strong>migliori prodotti gastronomici locali</strong></i>.
                                Tutti i prodotti presenti in questo store online e nei nostri punti vendita sono di <i><strong>produzione propria</strong></i>. 
                                Il nostro nuovo ristorante ci ha permesso di allietare i nostri clienti con la migliore carne proveniente direttamente dai <i><strong>pascoli della Val di Fiemme</strong></i>
                                e lavorata da noi.
                                In questo sito web potrai facilmente <i><strong>acquistare</strong></i> la maggior parte dei nostri prodotti, <i><strong>scoprire curiosità</strong></i> sulle lavorazioni e sulle materie prime che utiliziamo 
                                e <i><strong>scoprire nuovi e curiosi modi per consumare i prodotti che acquisti</strong></i>.
                            </p>
                        </div>
                    </div>
            </div>
        </div>
        <div class="mt-5 mb-5 text-center">
            <a class="buttonS" href="#materiePrime" onclick="backMaterie();" style='color: black; background-color: white;'>Torna indietro</a>
        </div>

        <script>
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
                var $myCarousel = $("#carousel${type.replace(' ', '')}"),
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