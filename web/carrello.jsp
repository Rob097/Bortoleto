<%-- 
    Document   : cerrello
    Created on : 8-feb-2019, 15.36.50
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
<c:set var="response" value="<%=response%>"/>
<c:set value="${productdao.getAllProductsOfCart(request)}" var="prodottiCart" />
<c:set value="${productdao.getTotalOfCart(request)}" var="subTotaleCart" />
<c:set value="${productdao.getTotalWeightOfCart(request)}" var="pesoTotaleCart" />
<c:set value="${pagamentodao.getSpeseSpedizione(pesoTotaleCart, ritiroAttribute, request)}" var="spedizioneCart" />
<c:set value="${pagamentodao.getTot(subTotaleCart, spedizioneCart)}" var="totaleCart" />
<c:set value="${productdao.getCartVariant(request)}" var="variantiCart" />
<%@ page import="varie.Costanti" %>
<c:set value="<%=varie.Costanti.SPACES_COOKIE%>" var="SPACES_COOKIE" />
<!DOCTYPE html>
<html>
    <head>

        <!-- Per impedire alla maggior parte dei motori di ricerca di indicizzare la pagina -->
        <meta name="robots" content="noindex">
        <!-- Per impedire solo a Google di indicizzare la pagina -->
        <meta name="googlebot" content="noindex">


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

        <link rel="icon" href="/Bortoleto/img/favicon.ico" sizes="16x16" >
        <title>Macelleria Dellantonio</title>
        <meta name="Description" content="Macelleria Dellantonio l'Bortoleto. Val di Fiemme. Val di Fassa. Trentino">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="theme-color" content="#31353d">

        <!-- bootstrap include -->
        <link rel="stylesheet nofollow" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet nofollow" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="css/mdb.min.css" rel="stylesheet nofollow">
        <!-- fine bootstrap include -->

        <!--include css -->
        <link rel="stylesheet nofollow" href="css/Cards-min.css" type="text/css">
        <link rel="stylesheet nofollow" href="css/style-min.css">
        <link rel="stylesheet nofollow" href="css/form-validation.css">
        <link rel="stylesheet nofollow" href="css/font-min.css">
        <link rel="stylesheet nofollow" href="css/navbar-min.css">
        <!-- fine include css --> 
        <style>
            footer{
                background-color:#222222;
                color:white;
                font-family: 'Caveat';
            }
            .container{
                max-width: 1500px;
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
    <noscript><img height="1" width="1" style="display:none"
                   src="https://www.facebook.com/tr?id=467659847403449&ev=PageView&noscript=1"
                   /></noscript>
    <!-- End Facebook Pixel Code -->
</head>
<body class="foo" data-spy="scroll" data-target=".sidebar">

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

    <div class="container">
        <c:choose>
            <c:when test="${prodottiCart eq null}">
                <div class="text-center black-text" style="margin-top: 6rem;">
                    <i style="color: #ff3547;" class="far fa-frown fa-4x mb-3 animated rotateIn"></i>
                    <h3 style="text-align: center;">Non hai prodotti nel carrello</h3>
                    <p class="pt-5">Ricorda che i prodotti del carrello, se non vengono cancellati manualmente, hanno una durata di <b style="font-weight: bold;">30 giorni</b>.</p>
                    <a class="btn" style="background-color: #9e0000; color: white;" href="<c:url value="/bottega.jsp" />">Ritorna alla bottega online</a>
                </div>
            </c:when>
            <c:otherwise>                    
                <div class="row">                        
                    <div class="col-md-4 order-md-2 mb-4" style="margin-top: 6rem;">
                        <h4 class="d-flex justify-content-between align-items-center mb-3">
                            <span class="black-text">Il tuo carrello</span>
                            <span id="cartSizeSumUp" class="badge badge-secondary badge-pill">${productdao.getCartSize(request)}</span>
                        </h4>
                        <ul id="cartCarrelloPage" class="list-group mb-3">
                            <c:forEach items="${prodottiCart}" var="prodotto">
                                <c:set var="hasVariant" value="${false}" />

                                <li class="list-group-item d-flex justify-content-between lh-condensed">
                                    <div style="width: 100%;">
                                        <img src="${prodotto.immagine}" style="width: 100px;"/>
                                        <h6 class="my-0 pointer mt-2"><a href="<c:url value="/prodotto.jsp?id=${prodotto.id}&nome=${prodotto.nome.replace(' ', '-')}&cat=${prodotto.categoria.replace(' ', '-')}"/>">${prodotto.nome}</a></h6>

                                        <!-- Prendo tuttel le varianti del prodotto presenti nel carrello -->
                                        <c:forEach items="${productdao.getCartProductVariant(request, prodotto.id)}" var="varianti">
                                            <c:set var="hasVariant" value="${true}" />
                                            <c:set var="valori" value="${varianti.key}"/>
                                            <c:set var="quantita" value="${varianti.value}"/>
                                            <c:set var="costoV" value="0"/>

                                            <hr>
                                            <div style="height: fit-content; text-align: right;" class="text-muted red-text pointer"><a  onclick="removeProd(${prodotto.id}, '${productdao.getVariantBlock(valori)}')"  data-toggle="tooltip" title="Rimuovi questa variante dal carrello">X</a></div>
                                            <%--<span class="cd-qty"><input onchange="updateQuantity(${prodotto.id}, '${productdao.getVariantBlock(valori)}', $(this).val());" style="border: none; max-width: 3rem;" type="number" min="1" value="${quantita}" /></span>--%>
                                            <small class="text-muted">Quantità: </small><small class="text-muted"><input onchange="updateQuantity(${prodotto.id}, '${productdao.getVariantBlock(valori)}', $(this).val());" style="border: none; max-width: 3rem;" type="number" min="1" value="${quantita}" /></small>
                                            <!-- Visualizzo i dati della combinazione di varianti e calcolo il costo -->    
                                            <c:forEach items="${valori}" var="variante">
                                                <c:set var="costoV" value="${costoV + variante.supplement}"/>
                                                <div style="color: #a5aebc; margin: 5px auto;" class="cd-price">${variante.variant}: ${variante.variantName}</div>
                                            </c:forEach>
                                            <!-- Mostro il costo e il peso di un unità di questa combinazione di varianti -->
                                            <div class="cd-price" style="width: max-content;">€ ${String.format('%.2f', costoV).replace(',', '.')} | ${String.format('%.2f', productdao.getWeightOfVariantCombination(valori)).replace(",", ".")} kg.</div>
                                        </c:forEach>
                                        <c:if test="${hasVariant eq false}">
                                            <br>
                                            <small class="text-muted">Quantità: </small><small class="text-muted"><input onchange="updateQuantity(${prodotto.id}, null, $(this).val());" style="border: none; max-width: 3rem;" type="number" min="1" value="${prodotto.quantita}" /></small>
                                            <div class="cd-price" style="width: max-content;">€ ${String.format('%.2f', Double.parseDouble(prodotto.costo.replace(",", ".")))} | ${String.format('%.2f', Double.parseDouble(prodotto.peso)).replace(",", ".")} kg.</div>
                                        </c:if>
                                    </div>
                                    <span style="height: fit-content;" class="text-muted text-center"><br><span class="red-text pointer" onclick="removeProd(${prodotto.id}, null)"  data-toggle="tooltip" title="Rimuovi '${prodotto.nome}' dal carrello">X</span></span>
                                </li>
                            </c:forEach>
                            <c:choose>
                                <c:when test="${!productdao.getFreshProductsOfCart(request).isEmpty() && ritiroAttribute != true}">
                                    <li class="list-group-item d-flex justify-content-between lh-condensed">
                                        <div>
                                            <img src="https://lh3.googleusercontent.com/6QOIaGv5w7KSjKo8XuMGgg_aXFQPbjQUX1TADK7LBCmxvRvNQncQRs-xDhdOz8rxnDg1tHL-zuybheQTO5a-ad3TE1YkXASmHIY7zd1jVhLMzbJE-W1rD_7NwYN-phBCflLlXuRB5Q=w2400" style="width: 100px;"/>
                                            <h6>Kit spedizione alimenti freschi Keatchen</h6>
                                        </div>
                                        <span style="margin-top: auto; margin-bottom: auto; min-width: 63px;" class="text-muted text-center">€ ${productdao.checkWeight(request)}<br><span><i style="color: black; margin-top: auto; margin-bottom: auto; margin-left: .5rem;" data-toggle="tooltip" title='Se hai aggiunto al carrello prodotti freschi, viene automaticamente aggiunto il contenitore refrigerante Keatchen per la spedizione. Il costo del contenitore varia in base ai prodotti che hai scelto.' class="fas fa-info-circle"></i></span></span>
                                    </li>
                                </c:when>
                            </c:choose>
                            <li class="list-group-item d-flex justify-content-between bg-light">
                                <div class="text-success">
                                    <h6 class="my-0">Ritiro in negozio</h6>
                                </div>
                                <span class="text-success">
                                    <span class="text-success">
                                        <span class="text-success">
                                            <input type="checkbox" id="ritiroCheck" onchange="updateCartCarrelloPage(this.checked);"
                                                   <c:choose>
                                                       <c:when test="${ritiroAttribute eq true}">
                                                           checked="true"
                                                       </c:when>
                                                       <c:otherwise>

                                                       </c:otherwise>
                                                   </c:choose>
                                                   >
                                        </span>
                                    </span>
                                </span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between bg-light">
                                <div class="text-success">
                                    <h6 class="my-0">Sub-Totale</h6>
                                </div>
                                <span class="text-success">€ ${subTotaleCart}</span>
                            </li> 
                            <li class="list-group-item d-flex justify-content-between bg-light">
                                <c:choose>
                                    <c:when test="${!productdao.getFreshProductsOfCart(request).isEmpty() && ritiroAttribute != true}">
                                        <%String cFRESH = "< 15kg -> €8.90\n15kg - 25kg -> €12.90\n€25kg - 50kg -> €21.90\n> 50kg -> GRATIS\nVa aggiunto il costo del box refrigerante anche in caso di spedizione gratuita ";%>
                                        <div class="text-success">
                                            <h6 class="my-0">Spedizione Keatchen <span><i style="color: black; margin-top: auto; margin-bottom: auto; margin-left: .5rem;" data-toggle="tooltip" title='<%=cFRESH%>' class="fas fa-info-circle"></i></span></h6>
                                        </div>
                                        <span class="text-success" style="width: 100%; text-align: right;">€ ${spedizioneCart}<br>${String.format('%.2f', pesoTotaleCart).replace(",", ".")} kg</span>
                                        </c:when>
                                        <c:when test="${productdao.getFreshProductsOfCart(request).isEmpty() && ritiroAttribute != true}">
                                            <%String c = "< 15kg -> €8.90\n15kg - 25kg -> €12.90\n€25kg - 50kg -> €21.90\n> 50kg -> GRATIS\n";%>
                                        <div class="text-success">
                                            <h6 class="my-0">Spedizione 
                                                <c:if test="${ritiroAttribute != true}">
                                                    <span>
                                                        <i style="color: black; margin-top: auto; margin-bottom: auto; margin-left: .5rem;" data-toggle="tooltip" title='<%=c%>' class="fas fa-info-circle"></i>
                                                    </span>
                                                </c:if>
                                            </h6>
                                        </div>
                                        <span class="text-success">€ ${spedizioneCart}<br>${String.format('%.2f', pesoTotaleCart).replace(",", ".")} kg</span>
                                        </c:when>
                                        <c:otherwise>
                                        <div class="text-success">
                                            <h6 class="my-0">Ritiro in negozio
                                            </h6>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                            <li class="list-group-item d-flex justify-content-between bg-light" style="color: #ffffff;font-weight: bold;background-color: #b4505a !important;">
                                <span style="padding:5px;margin:0;">Totale dell'ordine</span>
                                <strong style="font-size:20px;">€ ${totaleCart}</strong>
                            </li>
                        </ul>
                    </div>
                    <div style="height: auto;" class="col-md-8 order-md-1">
                        <div id="datiBox" class="sticky-top">
                            <div style="width: 100%; text-align: right;">
                                <a href="<c:url value="/bottega.jsp"/>" class="mt-5" style="font-weight: 900;"><i class="fas fa-arrow-left mr-2"></i>Torna al negozio</a>
                            </div>
                            <div style="height: 75vh; overflow: hidden scroll;">
                                <form id="SENDATI" class="needs-validation" novalidate action="javascript:sendDati()">
                                    <h4 class="mb-3">Dati pesonali</h4>                            
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="nome">Nome</label>
                                            <input type="text" class="form-control" id="nome" name="nome" <c:choose><c:when test="${nome ne null}">value="${nome.replace(SPACES_COOKIE, " ")}"</c:when><c:otherwise>placeholder="Il tuo nome"</c:otherwise></c:choose> required>
                                                    <div class="invalid-feedback">
                                                        E' richiesto un nome valido
                                                    </div>
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label for="cognome">Cognome</label>
                                                        <input type="text" class="form-control" id="cognome" name="cognome" <c:choose><c:when test="${cognome ne null}">value="${cognome.replace(SPACES_COOKIE, " ")}"</c:when><c:otherwise>placeholder="Il tuo cognome"</c:otherwise></c:choose> required>
                                                    <div class="invalid-feedback">
                                                        E' richiesto un cognome valido
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="mb-3">
                                                <label for="email">Email</label>
                                                    <input type="email" class="form-control" id="email" name="email" <c:choose><c:when test="${email ne null}">value="${email.replace(SPACES_COOKIE, " ")}"</c:when><c:otherwise>placeholder="La tua email"</c:otherwise></c:choose> required>
                                                <div class="invalid-feedback">
                                                    E' richiesta un'email valida che servirà per le comunicazioni.
                                                </div>
                                            </div>

                                            <div class="mb-3">
                                                <label for="indirizzo">Indirizzo</label>
                                                    <input type="text" class="form-control" id="indirizzo" name="indirizzo" <c:choose><c:when test="${indirizzo ne null}">value="${indirizzo.replace(SPACES_COOKIE, " ")}"</c:when><c:otherwise>placeholder="Il tuo indirizzo con numero civico"</c:otherwise></c:choose> required>
                                                <div class="invalid-feedback">
                                                    E' richiesto un indirizzo valido che servirà per la spedizione.
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-5 mb-3">
                                                    <label for="citta">Città</label>
                                                        <input type="text" class="form-control" id="citta" name="citta" <c:choose><c:when test="${citta ne null}">value="${citta.replace(SPACES_COOKIE, " ")}"</c:when><c:otherwise>placeholder="La tua città"</c:otherwise></c:choose> required>
                                                    <div class="invalid-feedback">
                                                        E' richiesto un nome di città valido che servirà per la spedizione
                                                    </div>
                                                </div>
                                                <div class="col-md-3 mb-3">
                                                    <label for="zip">CAP</label>
                                                        <input type="text" class="form-control" id="zip" name="zip" <c:choose><c:when test="${zip ne null}">value="${zip.replace(SPACES_COOKIE, " ")}"</c:when><c:otherwise>placeholder="Il CAP della tua città"</c:otherwise></c:choose> required>
                                                    <div class="invalid-feedback">
                                                        CAP richiesto per la spedizione
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="mb-3">
                                                <label for="note">Note</label>
                                                <textarea class="form-control" id="note" name="note" placeholder="Aggiungi qualsiasi nota che ci possa aiutare a prepare al meglio il tuo ordine o a facilitare la consegna del pacco"></textarea>
                                            </div>

                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="save-info" name="save-info">
                                                <label class="custom-control-label" for="save-info">Salva queste informazioni per la prossima volta</label>
                                            </div>
                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="subscribe-from-cart" name="subscribe">
                                                <label class="custom-control-label" for="subscribe-from-cart">Iscriviti alla newsletter <b style="font-weight: 900;">non</b> invasiva (NO SPAM)</label>
                                            </div>
                                            <hr class="mb-4">
                                            <div class="custom-control custom-checkbox text-center">
                                                <input type="checkbox" class="custom-control-input" id="conditionCheck" required>
                                                <label class="custom-control-label" for="conditionCheck">Ho letto e accetto le <a href="/Bortoleto/file/CondizionidiVendita.pdf" download>condizioni di vendita</a></label>
                                            </div>
                                            <hr class="mb-4">
                                            <button id="sendDatiButton" class="btn btn-primary btn-lg btn-block" type="submit">Procedi al pagamento</button>  
                                            <div id="divLoading" class="text-center invisible">
                                                <div class="spinner-border text-success" id="loading" role="status">
                                                    <span class="sr-only">Loading...</span>
                                                </div>
                                            </div>
                                        </form>
                                        <form id="SENDORDINE" class="needs-validation" novalidate name="SENDORDINE" method="POST" action="https://www.servizipos.it/ems-elk-web/pages/ems_elink_payment.xhtml" targhet="_PARENT">
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
            </c:otherwise>
        </c:choose>
    </div>


    <footer id="footer" class="container-fluid text-center">

    </footer>

    <!-- MODAL -->
    <div class="modal fade bottom" id="fluidModalBottomDangerDemo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"  aria-hidden="true">

    </div>
    <!-- FINE MODAL -->


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.7.2/js/all.js" integrity="sha384-0pzryjIRos8mFBWMzSSZApWtPl/5++eIfzYmTgBBmXYdhvxPc+XcFEk+zJwDgWbP" crossorigin="anonymous"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="js/mdb.min.js"></script>
    <script src="js/vari-min.js"></script>
    <script src="js/modernizr-min.js"></script>
    <script src="js/main-min.js"></script> 
    <script src="js/nav.js"></script>
    <script>

    </script>
    <script>
        $(document).ready(function () {
            document.getElementById('conditionCheck').checked = false;
        });
    </script>
    <script>
        var check = false;
        // Example starter JavaScript for disabling form submissions if there are invalid fields
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
                            check = true;
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();
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
                    $('#bigAction').html(response);
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
                    $('#bigAction').html(response);
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
                    updateCartCarrelloPage(null);
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
                    updateCartCarrelloPage(null);
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
                    updateCartCarrelloPage(null);
                    $('#datiBox').remove();
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
                        updateCartCarrelloPage(null);
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
                    $('#cartSizeSumUp').html(response);
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
            $('#ritiroCheck').parent().html("<img style='width: 50%;' src='/Bortoleto/img/91.gif' />");
            $('#ritiroCheckOnModal').parent().html("<img style='width: 50%;' src='/Bortoleto/img/91.gif' />");
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

        //sendDati
        function sendDati() {
            if (check === true) {
                $('#sendDatiButton').remove();
                $('#divLoading').removeClass("invisible");
            }
            $.ajax({
                type: "POST",
                url: "lastServlet",
                data: {nome: $('#nome').val(), cognome: $('#cognome').val(), email: $('#email').val(), indirizzo: $('#indirizzo').val(), citta: $('#citta').val(), zip: $('#zip').val(), note: $('#note').val(), save: document.getElementById('save-info').checked, subscribe: document.getElementById('subscribe-from-cart').checked},
                cache: false,
                success: function (response) {
                    $('#SENDORDINE').html(response);
                    document.forms['SENDORDINE'].submit();
                },
                error: function () {
                    alert("Errore send date");
                }
            });
        }
        /*sendDati
         function sendDati() {
         $.ajax({
         type: "POST",
         url: "lastServlet",
         data: {nome: $('#nome').val(), cognome: $('#cognome').val(), email: $('#email').val(), indirizzo: $('#indirizzo').val(), citta: $('#citta').val(), zip: $('#zip').val(), save: $('#save-info').val()},
         cache: false,
         success: function (dt, status, request) {
         
         $.ajax({
         type: "POST",
         url: "https://www.servizipos.it/ems-elk-web/pages/ems_elink_payment.xhtml",
         data: {MERCHANT_ID: request.getResponseHeader('MERCHANT_ID'), ORDER_ID: request.getResponseHeader('ORDER_ID'), IMPORTO: request.getResponseHeader('IMPORTO'), DIVISA: request.getResponseHeader('DIVISA'), ABI: request.getResponseHeader('ABI'), ITEMS: request.getResponseHeader('ITEMS'), URLOK: request.getResponseHeader('URLOK'), URLKO: request.getResponseHeader('URLKO'), MAC: request.getResponseHeader('MAC'), LINGUA: request.getResponseHeader('LINGUA'), EMAIL: request.getResponseHeader('EMAIL')},
         cache: false,
         success: function (response) {
         },
         error: function () {
         alert("Errore send date");
         }
         });
         
         },
         error: function () {
         alert("Errore send date");
         }
         });
         }*/
    </script>
    <script>
        $(function () {
            $("#fluidModalBottomDangerDemo").load("ajax/preferitiModalContent.jsp");
        });

        /* Carrello Modal */
        $(function () {
            $("#cd-cart").load("ajax/carrelloModalContent.jsp");
        });

        /* footer */
        $(function () {
            $("#footer").load("ajax/footer.html");
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
