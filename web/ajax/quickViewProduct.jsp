<%-- 
    Document   : quickViewProduct
    Created on : 3 gen 2020, 15:22:04
    Author     : Roberto97
--%>


<!-- Per impedire alla maggior parte dei motori di ricerca di indicizzare la pagina -->
<meta name="robots" content="noindex">
<!-- Per impedire solo a Google di indicizzare la pagina -->
<meta name="googlebot" content="noindex">


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="request" value="<%=request%>"/>
<c:set var="prodotto" value="${productdao.getProduct(param.id)}"/>
<c:set var="array" value="${productdao.getProductVariant(param.id)}"/>
<c:set value="${ricettedao.getRecipeOfProduct(prodotto.id)}" var="ideeProdotto" />
<c:set value="${blogdao.getIDTag(prodotto.nome.replace('-', ' '))}" var="blogProdotto" />
<!-- Modal -->
<div class="modal fade" id="${prodotto.id}-Quick-Modal" tabindex="-1" role="dialog" style="z-index: 1071;">
    <div class="modal-dialog modal__container" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <div class="modal-product">
                    <!-- Start product images -->
                    <div id="prodotto-immagine" class="product-images mb-5" style="width: fit-content;">
                        <div class="main-image images" style="width: fit-content;margin: auto;">
                            <img style="border-radius: 5px; max-height: 600px;" alt="${prodotto.nome}" src="/${prodotto.immagine}">
                        </div>
                        <div class="mt-5">
                            <h4 class="styled">Descrizione</h4>
                            <p class="description">${prodotto.descrizione}</p>
                        </div>
                    </div>
                    <!-- end product images -->
                    <div class="product-info">
                        <h1 style="margin: 10px 0 10px 0; font-weight: bold;"><a style="color: black !important;" href="<c:url value="/prodotto.jsp?id=${prodotto.id}&nome=${prodotto.nome.replace(' ', '-')}&cat=${prodotto.categoria.replace(' ', '-')}"/>">${prodotto.nome}</a></h1>
                        <h2 style="font-size: 20px;">${prodotto.categoria}</h2>                        
                        <div id="ratingDiv">
                            <c:set var="rate" value="${productdao.getRate(prodotto.id)}" />
                            <label style="color: rgba(162, 171, 171, 1)!important;">${productdao.getNumberRate(prodotto.id)} valutazioni (${rate} <i class="far fa-star"></i>)</label><br>
                            <fieldset class="rating text-center" style="display: initial;">
                                <input onclick="rate($(this).val(), ${prodotto.id});" type="radio" id="star5" name="rating" value="5" <c:if test="${rate >= 5}">checked</c:if> /><label class = "full" for="star5" title="5 stelle"></label>
                                <input onclick="rate($(this).val(), ${prodotto.id});" type="radio" id="star4half" name="rating" value="4.5" <c:if test="${rate >= 4.5 && rate < 5}">checked</c:if>/><label class="half" for="star4half" title="4.5 stelle"></label>
                                <input onclick="rate($(this).val(), ${prodotto.id});" type="radio" id="star4" name="rating" value="4" <c:if test="${rate >= 4 && rate < 4.5}">checked</c:if>/><label class = "full" for="star4" title="4 stelle"></label>
                                <input onclick="rate($(this).val(), ${prodotto.id});" type="radio" id="star3half" name="rating" value="3.5" <c:if test="${rate >= 3.5 && rate < 4}">checked</c:if>/><label class="half" for="star3half" title="3.5 stelle"></label>
                                <input onclick="rate($(this).val(), ${prodotto.id});" type="radio" id="star3" name="rating" value="3" <c:if test="${rate >= 3 && rate < 3.5}">checked</c:if>/><label class = "full" for="star3" title="3 stelle"></label>
                                <input onclick="rate($(this).val(), ${prodotto.id});" type="radio" id="star2half" name="rating" value="2.5" <c:if test="${rate >= 2.5 && rate < 3}">checked</c:if>/><label class="half" for="star2half" title="2.5 stelle"></label>
                                <input onclick="rate($(this).val(), ${prodotto.id});" type="radio" id="star2" name="rating" value="2" <c:if test="${rate >= 2 && rate < 2.5}">checked</c:if>/><label class = "full" for="star2" title="2 stelle"></label>
                                <input onclick="rate($(this).val(), ${prodotto.id});" type="radio" id="star1half" name="rating" value="1.5" <c:if test="${rate >= 1.5 && rate < 2}">checked</c:if>/><label class="half" for="star1half" title="1.5 stelle"></label>
                                <input onclick="rate($(this).val(), ${prodotto.id});" type="radio" id="star1" name="rating" value="1" <c:if test="${rate >= 1 && rate < 1.5}">checked</c:if>/><label class = "full" for="star1" title="1 stella"></label>
                                <input onclick="rate($(this).val(), ${prodotto.id});" type="radio" id="starhalf" name="rating" value="0.5" <c:if test="${rate >= 0.5 && rate < 1}">checked</c:if>/><label class="half" for="starhalf" title="0.5 stelle"></label>

                                </fieldset><br>                                
                            </div>
                            <div class="quick-desc">
                            <c:if test="${ideeProdotto ne null && !ideeProdotto.isEmpty()}">
                                <br><a target="_blank" href="<c:url value="/idee.jsp?prod=${prodotto.id}&nome=${prodotto.nome.replace(' ', '-')}" />"><img style="vertical-align: text-top; margin-right: 5px;" src="/Bortoleto/img/cappello-chef.png" />Scopri curiose idee su come usare questo prodotto</a><br>
                                </c:if>
                                <c:if test="${blogProdotto ne null && blogProdotto != 0}">
                                <br><a target="_blank" href="<c:url value="/blog.jsp?tag=${prodotto.nome.replace(' ', '-')}"/>"><img style="vertical-align: text-top; margin-right: 5px;" src="/Bortoleto/img/libro.png" />Lo sapevi che...</a>
                                </c:if>
                        </div>
                        <c:choose>
                            <c:when test="${prodotto.disponibile eq true}">
                                <c:set var="array" value="${productdao.getProductVariant(prodotto.id)}"/>
                                <div class="row">
                                    <div class="col-8">
                                        <ul class="pro__dtl__prize">
                                            <li><span>Prezzo: </span></li>
                                            <li><span>Peso: </span></li>                                                    
                                                <c:if test="${array ne null && !array.isEmpty()}">
                                                    <c:forEach items="${array}" var="varianti" >
                                                    <li><span>${varianti.get(0).variant}: </span></li>
                                                    </c:forEach>
                                                </c:if>
                                            <li><span>Quantità: </span></li>
                                        </ul>
                                    </div>
                                    <div class="col-4">
                                        <ul class="pro__dtl__prize">
                                            <c:choose>
                                                <c:when test="${array ne null && !array.isEmpty()}">
                                                    <div id="boxDati-true">
                                                        <li>€${array.get(0).get(0).supplement}</li>
                                                        <li>${array.get(0).get(0).pesoMaggiore}kg</li>
                                                            <c:forEach items="${array}" var="varianti" >
                                                            <li>
                                                                <div class="select__color prodict-statas">
                                                                    <div class="div-select">
                                                                        <select onchange="changeVarianteQuick(this, ${prodotto.id}, true);" name="${varianti.get(0).variant.replace(" ", "")}-true" id="${varianti.get(0).variant.replace(" ", "")}-true">
                                                                            <c:forEach items="${varianti}" var="variante" >
                                                                                <option value="${variante.id}">${variante.variantName}</option>
                                                                            </c:forEach>   
                                                                        </select><br>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                        </c:forEach>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <li>€${prodotto.costo}</li>
                                                    <li>${prodotto.peso}kg</li>
                                                    </c:otherwise>
                                                </c:choose>
                                            <li>
                                                <div class="product-action-wrap">
                                                    <div class="product-quantity">
                                                        <form id='myform' method='POST' action='#'>
                                                            <div class="product-quantity">
                                                                <div class="cart-plus-minus">
                                                                    <input id="quantitaInput-Quick" class="cart-plus-minus-box" type="number" name="qtybutton" min="1" value="1">
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <ul class="pro__dtl__btn">
                                    <li class="buy__now__btn"><a id="addToCartQuick" onclick="addProdQuick(${prodotto.id});"><i style='margin-right: 1rem;color: inherit;font-size: 15px;' class='fa fa-cart-plus'></i>Aggiungi al Carrello</a></li>
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
                                </ul>
                            </c:when>
                            <c:otherwise>
                                <h4 style="color: white; background-color: #c32707; padding: 0.3em; text-align: center;">ESAURITO</h4>
                                <ul class="pro__dtl__btn">
                                    <li class="heart-${prodotto.id}" style="margin: auto auto;">
                                        <c:choose>
                                            <c:when test="${productdao.isPreferito(prod.id, request) eq true}">
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
                                </ul>
                            </c:otherwise>
                        </c:choose>
                        <div class="social-sharing">
                            <div class="widget widget_socialsharing_widget">
                                <iframe src="https://www.facebook.com/plugins/share_button.php?href=https%3A%2F%2Fmacelleriadellantonio.it%2FBortoleto%2Fprodotto.jsp%3Fid%3D${prodotto.id}%26nome%3D${prodotto.nome.replace(' ', '-')}%26cat%3D${prodotto.categoria.replace(' ', '-')}&layout=button&size=large&appId=320307085338651&width=100&height=28" width="100" height="28" style="border:none;overflow:hidden;margin:auto;" scrolling="no" frameborder="0" allowTransparency="true" allow="encrypted-media"></iframe>
                            </div>
                        </div>
                    </div><!-- .product-info -->
                </div><!-- .modal-product -->
            </div><!-- .modal-body -->
        </div><!-- .modal-content -->
    </div><!-- .modal-dialog -->
</div>
<!-- END Modal -->

<script>
</script>
<script>
    function addProdQuick(id) {
        var quantita = $('#quantitaInput-Quick').val();
        var variant = "";


    <c:choose>
        <c:when test="${array ne null && !array.isEmpty()}">
            <c:forEach items="${array}" var="varianti" >
        variant += $('#${varianti.get(0).variant.replace(" ", "")}-true option:selected').val() + "_";
            </c:forEach>
        variant = variant.substring(0, variant.length - 1);
        </c:when>
        <c:otherwise>
        variant = null;
        </c:otherwise>
    </c:choose>
        if (variant !== null && variant.length < 1) {
            alert("Devi selezionare i valori");
        } else {
            $('#addToCartQuick').html("<img style='width: 10%;' src='/Bortoleto/img/91.gif' />");
            $.ajax({
                type: "POST",
                url: "/Bortoleto/addProd",
                data: {id: id, quantita: quantita, variant: variant},
                cache: false,
                success: function (response) {
                    updateCartSize();
                    $('#cd-cart').html(response);
                    updatePrefModal();
                    /*addToCartFacebookEvent();*/
                    $('#addToCartQuick').html("<img style='width: 10%;' src='data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTguMS4xLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4PSIwcHgiIHk9IjBweCIgdmlld0JveD0iMCAwIDE3LjgzNyAxNy44MzciIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDE3LjgzNyAxNy44Mzc7IiB4bWw6c3BhY2U9InByZXNlcnZlIiB3aWR0aD0iNTEycHgiIGhlaWdodD0iNTEycHgiPgo8Zz4KCTxwYXRoIGQ9Ik0xNi4xNDUsMi41NzFjLTAuMjcyLTAuMjczLTAuNzE4LTAuMjczLTAuOTksMEw2LjkyLDEwLjgwNGwtNC4yNDEtNC4yNyAgIGMtMC4yNzItMC4yNzQtMC43MTUtMC4yNzQtMC45ODksMEwwLjIwNCw4LjAxOWMtMC4yNzIsMC4yNzEtMC4yNzIsMC43MTcsMCwwLjk5bDYuMjE3LDYuMjU4YzAuMjcyLDAuMjcxLDAuNzE1LDAuMjcxLDAuOTksMCAgIEwxNy42Myw1LjA0N2MwLjI3Ni0wLjI3MywwLjI3Ni0wLjcyLDAtMC45OTRMMTYuMTQ1LDIuNTcxeiIgZmlsbD0iIzAwMDAwMCIvPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+Cjwvc3ZnPgo=' />");
                    setTimeout(function () {
                        $('#addToCartQuick').html("<i style='margin-right: 1rem;color: inherit;font-size: 15px;' class='fa fa-cart-plus'></i>Aggiungi al Carrello");
                    }, 2000);
                },
                error: function () {
                    $('#addToCartQuick').html("<img style='width: 10%;' src='data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTguMS4xLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4PSIwcHgiIHk9IjBweCIgdmlld0JveD0iMCAwIDI4IDI4IiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCAyOCAyODsiIHhtbDpzcGFjZT0icHJlc2VydmUiIHdpZHRoPSI1MTJweCIgaGVpZ2h0PSI1MTJweCI+CjxnPgoJPGcgaWQ9IngiPgoJCTxnPgoJCQk8cG9seWdvbiBwb2ludHM9IjI4LDIyLjM5OCAxOS41OTQsMTQgMjgsNS42MDIgMjIuMzk4LDAgMTQsOC40MDIgNS41OTgsMCAwLDUuNjAyIDguMzk4LDE0IDAsMjIuMzk4ICAgICAgNS41OTgsMjggMTQsMTkuNTk4IDIyLjM5OCwyOCAgICAiIGZpbGw9IiMwMDAwMDAiLz4KCQk8L2c+Cgk8L2c+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPGc+CjwvZz4KPC9zdmc+Cg==' />");
                    setTimeout(function () {
                        $('#addToCartQuick').html("<i style='margin-right: 1rem;color: inherit;font-size: 15px;' class='fa fa-cart-plus'></i>Aggiungi al Carrello");
                    }, 2000);
                }
            });
        }
    }
    //Change Variante Quick
    /* Il motivo per cui ho fatto questa funziona uguale a quella nel prodotto.jsp dove cambia solo il nome è che l'oggetto array veniva preso sbagliato nelle quickview
     * quindi ho dovuto ripetere la funzione anche qui. Comunque in questo modo non devo rcopiare la funzione in tutti i .jsp dove ci sono le quickview ma solo in product con il metodo non quick */
        function changeVarianteQuick(element, prod, isQuick) {

            var string = ""; //contiene la concatenazione degli id delle varianti scelte per la combinazione di varianti
            var selects; // nel ciclo foreach seleziona tutti i select delle varianti
            var optionSelected; //nel ciclo foreach prende l'opzione scelta per ogni select delle varianti
        <c:choose>
            <c:when test="${array ne null && !array.isEmpty()}">
                <c:forEach items="${array}" var="varianti" >
            selects = $('#${varianti.get(0).variant.replace(" ", "")}-' + isQuick);
            optionSelected = selects[0].options[selects.prop('selectedIndex')].value;
            string += optionSelected + "_";
                </c:forEach>
            </c:when>
        </c:choose>
            string = string.substring(0, string.length - 1); //rimuovo l'ultimo carattere che è un _
            //immagine di caricamento
            $('#boxDati-' + isQuick).html("<img style='width: 40%;' src='/Bortoleto/img/91.gif' />");

            //Funzione ajax per aggiornare la schermata, il isQuick è un boolean e serve per capire se ci riferiamo al prodotto o al modal QuickView
            $.ajax({
                type: "POST",
                url: "/Bortoleto/ajax/changeVariante.jsp",
                data: {id: element.value, prod: prod, quick: isQuick, varianti: string},
                cache: false,
                success: function (response) {
                    $('#boxDati-' + isQuick).html(response);
                },
                error: function () {
                    $('#boxDati-' + isQuick).css("background-color", "red");
                    $('#boxDati-' + isQuick).html("ERRORE");
                }
            });
        }
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