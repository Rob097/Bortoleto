<%-- 
    Document   : carrelloModalContent
    Created on : 6-feb-2019, 17.06.09
    Author     : Roberto97
--%>


<!-- Per impedire alla maggior parte dei motori di ricerca di indicizzare la pagina -->
<meta name="robots" content="noindex">
<!-- Per impedire solo a Google di indicizzare la pagina -->
<meta name="googlebot" content="noindex">


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="request" value="<%=request%>"/>
<c:set var="response" value="<%=response%>"/>
<c:set value="${productdao.getAllProductsOfCart(request)}" var="prodottiCart" />
<c:set value="${productdao.getCartVariant(request)}" var="variantiCart" />
<c:set value="${productdao.getTotalOfCart(request)}" var="subTotaleCart" />
<c:set value="${pagamentodao.getSpeseSpedizione(subTotaleCart, ritiroAttribute, request)}" var="spedizioneCart" />
<c:set value="${pagamentodao.getTot(subTotaleCart, spedizioneCart)}" var="totaleCart" />

<h2>Carrello <i style="color: black; margin-top: auto; margin-bottom: auto; margin-left: .5rem;" data-toggle="tooltip" title='I prodotti salvati nel carrello, se non vengono cancellati manualmente, hanno una durata di 30 giorni.' class="fas fa-info-circle"></i></h2>
    <c:choose>
        <c:when test="${prodottiCart eq null}">
        <div class="text-center">
            <i style="color: #ff3547;" class="far fa-frown fa-4x mb-3 animated rotateIn"></i>
            <h3 style="text-align: center;">Non hai prodotti nel carrello</h3>
            <p class="pt-5">Ricorda che i prodotti del carrello, se non vengono cancellati manualmente, hanno una durata di <b style="font-weight: bold;">30 giorni</b>.</p>
        </div>
    </c:when>
    <c:otherwise>
        <ul class="cd-cart-items">

            <c:forEach items="${prodottiCart}" var="prodotto">
                <c:set var="hasVariant" value="${false}" />

                <li class="row">
                    <div class="col-3">
                        <div class="image-liquid image-holder--original" style="width: 100%; min-width: 50px; height: 50px; background-image: url('/${prodotto.immagine}');"></div>                  
                    </div>
                    <div class="col-9">
                        <a href="<c:url value="/prodotto.jsp?id=${prodotto.id}&nome=${prodotto.nome.replace(' ', '-')}&cat=${prodotto.categoria.replace(' ', '-')}"/>">${prodotto.nome}</a>
                        <a id="remove-${prodotto.id}" onclick="removeProd(${prodotto.id}, null)" style="float: right;" data-toggle="tooltip" title="Rimuovi '${prodotto.nome}' dal carrello"><img src="/Bortoleto/img/cd-remove-item.svg" alt="remove_${prodotto.id}"/></a>

                        <c:forEach items="${variantiCart}" var="varianti">
                            <c:set var="valori" value="${varianti.key}"/>
                            <c:if test="${valori ne null && !valori.isEmpty()}">
                                <c:set var="prod" value="${productdao.getProduct(valori.get(0).id_prod)}" />
                                <c:if test="${prod.id eq prodotto.id}">
                                    <c:set var="hasVariant" value="${true}" />
                                    <c:set var="quantita" value="${varianti.value}"/>
                                    <c:set var="costoV" value="0"/>

                                    <hr>
                                    <span class="cd-qty"><input onchange="updateQuantity(${prodotto.id}, '${productdao.getVariantBlock(valori)}', $(this).val());" style="border: none; max-width: 3rem;" type="number" min="1" value="${quantita}" /></span>
                                        <c:forEach items="${valori}" var="variante">
                                            <c:set var="costoV" value="${costoV + variante.supplement}"/>
                                        <div class="cd-price">${variante.variant}: ${variante.variantName}</div>
                                    </c:forEach>
                                    <div class="cd-price" style="width: max-content;">€ ${String.format('%.2f', Double.parseDouble(prodotto.costo.replace(",", ".")) + costoV).replace(',', '.')}</div>
                                    <a id="remove-${prodotto.id}-${productdao.getVariantBlock(valori)}" onclick="removeProd(${prodotto.id}, '${productdao.getVariantBlock(valori)}')" class="cd-item-remove-1 cd-img-replace" data-toggle="tooltip" title="Rimuovi questa variante dal carrello">Remove</a>
                                </c:if>
                            </c:if>
                        </c:forEach>
                        <c:if test="${hasVariant eq false}">
                            <br>
                            <div class="cd-price" style="width: max-content;">€ ${Double.parseDouble(prodotto.costo.replace(",", "."))}</div>
                            <span class="cd-qty"><input onchange="updateQuantity(${prodotto.id}, null, $(this).val());" style="border: none; max-width: 3rem;" type="number" min="1" value="${prodotto.quantita}" /></span>
                            </c:if>
                    </div>  
                </li>

            </c:forEach>

            <c:choose>
                <c:when test="${!productdao.getFreshProductsOfCart(request).isEmpty() && ritiroAttribute != true}">
                    <li class="row">
                        <div class="image-liquid image-holder--original col-3" style="width: 50px; height: 50px; background-image: url('https://lh3.googleusercontent.com/6QOIaGv5w7KSjKo8XuMGgg_aXFQPbjQUX1TADK7LBCmxvRvNQncQRs-xDhdOz8rxnDg1tHL-zuybheQTO5a-ad3TE1YkXASmHIY7zd1jVhLMzbJE-W1rD_7NwYN-phBCflLlXuRB5Q=w2400');"></div>                                                
                        <div class="col-9">
                            <p>Kit spedizione alimenti freschi Keatchen</p>
                            <div class="cd-price">
                                € ${productdao.checkWeight(request)}
                                <span style="float: right;">
                                    <i style="color: black; margin-top: auto; margin-bottom: auto; margin-left: .5rem;" data-toggle="tooltip" title='Se hai aggiunto al carrello prodotti freschi, viene automaticamente aggiunto il contenitore refrigerante Keatchen per la spedizione. Il costo del contenitore varia in base ai prodotti che hai scelto.' class="fas fa-info-circle"></i>
                                </span>
                            </div>
                        </div>
                    </li>
                </c:when>
            </c:choose>


            <li class="list-group-item d-flex justify-content-between bg-light">
                <div class="text-success">
                    <h6 class="my-0">Ritiro in negozio</h6>
                </div>
                <span class="text-success"><input type="checkbox" id="ritiroCheckOnModal" onchange="updateCartCarrelloPage(this.checked);" <c:choose><c:when test="${ritiroAttribute eq true}">checked="true"</c:when><c:otherwise></c:otherwise></c:choose>></span>
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
                        <%String cFRESH = "< €100 -> €8.90\n€100 - €200 -> €12.90\n€200 - €257 -> €21.90\n> €257 -> GRATIS\nVa aggiunto il costo del box refrigerante anche in caso di spedizione gratuita ";%>
                        <div class="text-success">
                            <h6 class="my-0">Spedizione KEATCHEN
                                <span>
                                    <i style="color: black; margin-top: auto; margin-bottom: auto; margin-left: .5rem;" data-toggle="tooltip" title='<%=cFRESH%>' class="fas fa-info-circle"></i>
                                </span>
                            </h6>
                        </div>
                        <span class="text-success" style="width: 100%; text-align: right;">€ ${spedizioneCart}</span>
                    </c:when>
                    <c:when test="${productdao.getFreshProductsOfCart(request).isEmpty() && ritiroAttribute != true}">
                        <%String c = "< €100 -> €8.90\n€100 - €200 -> €12.90\n€200 - €257 -> €21.90\n> €275 -> GRATIS\n";%>
                        <div class="text-success">
                            <h6 class="my-0" style="width: max-content;">Spedizione 
                                <span>
                                    <i style="color: black; margin-top: auto; margin-bottom: auto; margin-left: .5rem;" data-toggle="tooltip" title='<%=c%>' class="fas fa-info-circle"></i>
                                </span>
                            </h6>
                        </div>
                        <span class="text-success" style="width: 100%; text-align: right;">€ ${spedizioneCart}</span>
                    </c:when>
                    <c:otherwise>
                        <div class="text-success">
                            <h6 class="my-0">Ritiro in negozio
                            </h6>
                        </div>
                    </c:otherwise>
                </c:choose>
            </li>
        </ul> <!-- cd-cart-items -->
        <div class="cd-cart-total" style="color: #000080; font-weight: bold;">
            <p>Total <span>€ ${totaleCart}</span></p>
        </div> <!-- cd-cart-total -->
        <a href="/Bortoleto/carrello.jsp" class="checkout-btn">Checkout</a>
        <a onclick="svuotaCarrello();" class="checkout-btn" style="background-color: #5f0b0b; font-weight: 600;">Svuota carrello</a>
    </c:otherwise>
</c:choose>    