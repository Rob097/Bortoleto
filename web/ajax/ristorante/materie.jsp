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
                                        <div class="carousel-item active background slide-materie-carousel" id="firstIMG">
                                            <div class="carousel-caption d-md-block">
                                                <h3 class="icon-container" style="width: 100%; margin-bottom: 0;">
                                                    <svg class="n1" width="10px" height="100%" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                                                        <path id="Rectangle" fill="none" stroke="#b4505a" stroke-width="7" d="M0,20 L0,120.0"></path>
                                                    </svg>
                                                </h3>
                                                <h3 data-animation="animated fadeInDown" style="margin-bottom: -15px; font-weight: bold;">
                                                    ${type}
                                                </h3>
                                                <h3 class="icon-container" style="width: 100%; margin-bottom: 0;">
                                                    <svg class="n2" width="10px" height="100%" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                                                        <path id="Rectangle" fill="none" stroke="#b4505a" stroke-width="7" d="M0,20 L0,100.0"></path>
                                                    </svg>
                                                </h3>
                                            </div>
                                        </div>

                                        <!-- second slide -->
                                        <div class="carousel-item background2 slide-materie-carousel" id="secondIMG">
                                            <div class="carousel-caption captionBG">
                                                <h3 id="firstCaptionH3" class="h3-responsive"></h3>
                                                <p id="firstCaptionP"></p>
                                            </div>
                                        </div>

                                        <!-- third slide -->
                                        <div class="carousel-item background3 slide-materie-carousel" id="thirdIMG">
                                            <div class="carousel-caption captionBG">
                                                <h3 id="secondCaptionH3" class="h3-responsive"></h3>
                                                <p id="secondCaptionP"></p>
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
                        <h3 class="styled mb-5" style="text-align: right; margin: 0;">${type}</h3>
                        <div id="text" class="description">                          
                        </div>
                    </div>
            </div>
        </div>
        <div class="mb-5 text-center">
            <a class="buttonS" href="#materiePrime" onclick="backMaterie();" style='color: black; background-color: white;'>Torna indietro</a>
        </div>

        <script>
            var tipo = "${type}";
            console.log(tipo);
            switch (tipo) {
                case(null):
                case(""):
                default:
                    backMaterie();
                    break;
                case('La Carne'):
                    $('#firstCaptionH3').html("Carne di manzo");
                    $('#firstCaptionP').html("Frollata 30 giorni");
                    $('#secondCaptionH3').html("Carne di manzo");
                    $('#secondCaptionP').html("Frollata 30 giorni");
                    $('#firstIMG').css("background-image", "linear-gradient(0deg,rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.35)),url(http://localhost:8080/Bortoleto/img/logoNeg.jpg)");
                    $('#secondIMG').css("background-image", "linear-gradient(0deg,rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.35)),url(http://localhost:8080/Bortoleto/img/logoNeg.jpg)");
                    $('#thirdIMG').css("background-image", "linear-gradient(0deg,rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.35)),url(http://localhost:8080/Bortoleto/img/logoNeg.jpg)");
                    $('#text').html('<p>Nasciamo come <strong>ristorante macelleria</strong>&nbsp;e proprio per questo motivo la carne rappresenta la parte pi&ugrave; importante della nostra cucina. Tra i diversi tipi di carne che offriamo quelli che pi&ugrave; meritano attenzione sono sicuramente la <strong>carne rossa</strong> e la <strong>selvaggina</strong>.</p><p>Da sempre la <strong><a title="Macelleria Dellantonio" href="https://macelleriadellantonio.it/La-Macelleria" target="_blank">macelleria Dellantonio</a></strong> si basa sulla filosofia della <strong>filiera a km 0</strong>. Questo significa che la nostra qualit&agrave; nel piatto parte dai pascoli della Val di Fiemme dove vivono bovini 100% Italiani e locali. Da qui tutto avviene esclusivamente nei nostri laboratori di Predazzo dove&nbsp;ci preoccupiamo di <strong>frollare la carne</strong> e scegliere i tagli migliori per preparare&nbsp;<strong>secondi piatti di carne raffinati</strong> e salutari che vengono incontro alle esigenze dei palati pi&ugrave; fini mantenendo un perfetto equilibrio tra gustosit&agrave; e leggerezza.<br />Ci troviamo a 1000 metri, ai piedi delle <strong>Dolomiti</strong> e qui vivono molti animali selvatici come Cervi, Caprioli e Camosci. Anche in questo la macelleria Dellantonio punta sul km 0, per questo in autunno e primavera, quando i cacciatori iniziano la loro attivit&agrave;, il nostro menu si adegua alla <strong>stagionalit&agrave;</strong> offrendo secondi piatti raffinati ottimi per una <strong>cena a base di carne</strong> locale.</p><p>&nbsp;</p>');
                    break;
                case('Fatto da noi'):
                    $('#firstCaptionH3').html("Tortellini");
                    $('#firstCaptionP').html("di pasta Fresca");
                    $('#secondCaptionH3').html("Tortellini");
                    $('#secondCaptionP').html("di pasta Fresca");
                    $('#firstIMG').css("background-image", "linear-gradient(0deg,rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.35)),url(https://lh3.googleusercontent.com/ixN4bzXDDBzJpoHGooHd3Ryo5f1FTKoJgQV4Bs-lgGo6_k8zwVq9r3RCuTrSwtZ2eIWzc8ysfoZT398MDcOV0cJYh1vhhA9Yuo42G8Rmy_qTlluZIp68fVjN3IVZoK8HJIPZNX-ngg=w2400)");
                    $('#secondIMG').css("background-image", "linear-gradient(0deg,rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.35)),url(https://lh3.googleusercontent.com/ixN4bzXDDBzJpoHGooHd3Ryo5f1FTKoJgQV4Bs-lgGo6_k8zwVq9r3RCuTrSwtZ2eIWzc8ysfoZT398MDcOV0cJYh1vhhA9Yuo42G8Rmy_qTlluZIp68fVjN3IVZoK8HJIPZNX-ngg=w2400)");
                    $('#thirdIMG').css("background-image", "linear-gradient(0deg,rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.35)),url(https://lh3.googleusercontent.com/ixN4bzXDDBzJpoHGooHd3Ryo5f1FTKoJgQV4Bs-lgGo6_k8zwVq9r3RCuTrSwtZ2eIWzc8ysfoZT398MDcOV0cJYh1vhhA9Yuo42G8Rmy_qTlluZIp68fVjN3IVZoK8HJIPZNX-ngg=w2400)");
                    $('#text').html("<p>Quando le sale si svuotano e la tensione del servizio sparisce in cucina inizia la <strong>produzione</strong>.&nbsp;<p/><p>Quello a cui non rinunciamo sono le cose <strong>fatte in casa</strong> che esaltano tutti gli aromi e i sapori dei <strong>prodotti freschi</strong> e di qualit&agrave;.<br />I <strong>grissini</strong> che trovi al tavolo, assieme ai piccoli <strong>panini</strong> dalla forma tozza e dalla consistenza morbida dentro e croccante fuori, sono rigorosamente impastati e sfornati quotidianamente dai nostri forni.<br />Il nostro <strong><a href='#menu'>menù</a></strong> punta a esaltare la <strong>stagionalit&agrave; dei prodotti</strong>, per cui non sempre troverai alcuni piatti, ma se avrai la fortuna di poterci venire a trovare nel periodo giusto quello che ti aspetta sono i <strong>tortellini di pasta fresca</strong> fatta in casa, cucinati al momento e serviti asciutti o in un delizioso brodo di <strong>verdure di stagione</strong> per deliziarti anche con il profumo.&nbsp;<br />Per concludere in dolcezza tutti i nostri <strong>gelati</strong> sono sempre fatti da noi. Vieni a provare il gelato al <strong>Vin Brul&egrave;</strong> in autunno!&nbsp;</p><p>Molte altre pietanze sono fatte in casa da noi e per scoprirle ti invitiamo a <strong>venire a trovarci</strong>, saremmo lieti d'intrattenervi con le migliori <strong>specialit&agrave; trentine</strong>!</p>");
                    break;
                case('Dal Trentino'):
                    $('#firstCaptionH3').html("Mare contro lago");
                    $('#firstCaptionP').html("Sardine e Sarde del Garda Affumicate");
                    $('#secondCaptionH3').html("Pasta Felicetti");
                    $('#secondCaptionP').html("MExzzemaniche Il Cappelli");
                    $('#firstIMG').css("background-image", "linear-gradient(0deg,rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.35)),url(https://lh3.googleusercontent.com/ixN4bzXDDBzJpoHGooHd3Ryo5f1FTKoJgQV4Bs-lgGo6_k8zwVq9r3RCuTrSwtZ2eIWzc8ysfoZT398MDcOV0cJYh1vhhA9Yuo42G8Rmy_qTlluZIp68fVjN3IVZoK8HJIPZNX-ngg=w2400)");
                    $('#secondIMG').css("background-image", "linear-gradient(0deg,rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.35)),url(https://lh3.googleusercontent.com/ixN4bzXDDBzJpoHGooHd3Ryo5f1FTKoJgQV4Bs-lgGo6_k8zwVq9r3RCuTrSwtZ2eIWzc8ysfoZT398MDcOV0cJYh1vhhA9Yuo42G8Rmy_qTlluZIp68fVjN3IVZoK8HJIPZNX-ngg=w2400)");
                    $('#thirdIMG').css("background-image", "linear-gradient(0deg,rgba(0, 0, 0, 0.45),rgba(0, 0, 0, 0.35)),url(https://lh3.googleusercontent.com/ixN4bzXDDBzJpoHGooHd3Ryo5f1FTKoJgQV4Bs-lgGo6_k8zwVq9r3RCuTrSwtZ2eIWzc8ysfoZT398MDcOV0cJYh1vhhA9Yuo42G8Rmy_qTlluZIp68fVjN3IVZoK8HJIPZNX-ngg=w2400)");
                    $('#text').html("<p>Il nostro territorio &egrave; caratterizzato da una <strong>biodiversit&agrave; unica</strong> che rende i settori pi&ugrave; importanti proprio quelli dell'<strong>allevamento</strong> e dell'<strong>agricoltura</strong>.&nbsp;<br />Da qui la nostra volont&agrave; di&nbsp;appoggiarci il pi&ugrave; possibile agli allevatori e agricoltori Trentini, sia per mantenere la <strong>filiera km0</strong>, sia per una sicurezza sulla provenienza e sulla qualit&agrave; dei prodotti.<p/><p>Tra le principali <strong>eccellenze Trentine</strong> che siamo onorati di poter portare sui tavoli del nostro ristorante citiamo la pasta <a title=\"Pastificio Felicetti\" href=\"https://www.felicetti.it/\" target=\"_blank\" rel=\"nofollow\">Felicetti</a>&nbsp;&nbsp;<img src=\"https://www.quotidianosostenibile.it/wp-content/uploads/2016/02/felicetti-logo.jpg\" alt=\"Pastificio Felicetti\" width=\"28\" height=\"29\" />, pastificio nato a Predazzo e ormai di fama internazionale per la qualit&agrave; dei suoi grani e delle sue lavorazioni. Il grano <a title=\"Goever\" href=\"http://www.goever.it/\" target=\"_blank\" rel=\"nofollow\">Goever&nbsp;<img src=\"http://www.goever.it/wp-content/uploads/2016/11/cropped-cropped-Gover-001.jpg\" alt=\"Goever\" width=\"63\" height=\"21\" /></a>, senza il quale il nostro orzo Trentino non sarebbe la stessa cosa. L'<a title=\"Uovo di Montagna\" href=\"https://www.uovadimontagna.info/\" target=\"_blank\">uovo di montagna</a>&nbsp;<img src=\"https://static.wixstatic.com/media/d51a8c_dd50b50673ea4bb388dd74b805bbbd12~mv2.png/v1/fill/w_144,h_189,al_c,q_85,usm_0.66_1.00_0.01/d51a8c_dd50b50673ea4bb388dd74b805bbbd12~mv2.webp\" alt=\"Uovo di Montagna\" width=\"24\" height=\"32\" /> che rappresenta la volont&agrave; di un consumo sostenibile che&nbsp;garantisce la salute e la qualit&agrave; della vita degli animali a favore delle propriet&agrave; invidiabili delle uova prodotte nei loro allevamenti.<br />Direttamente dal lago di Garda le Sarde e Sardine degli allevamenti <a title=\"Armanini \" href=\"https://www.armanini.it/\" target=\"_blank\">Armanini&nbsp;<img src=\"https://www.trentiner.it/media/catalog/category/cache/585X265/Senza_titolo_1.jpg\" alt=\"Armanini\" width=\"82\" height=\"37\" /></a>che garantiscono sicurezza e genuinit&agrave;.<br /><br />Inoltre da sempre la <a title=\"Macelleria Dellantonio\" href=\"/Bortoleto/La-Macelleria\">macelleria Dellantonio</a> si appoggia sugli allevamenti locali della val di Fiemme e Fassa.</p>");
                    break;
            }
        </script>

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