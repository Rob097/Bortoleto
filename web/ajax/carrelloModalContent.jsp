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
<c:set value="${productdao.getTotalWeightOfCart(request)}" var="pesoTotaleCart" />
<c:set value="${pagamentodao.getSpeseSpedizione(pesoTotaleCart, ritiroAttribute, request)}" var="spedizioneCart" />
<c:set value="${pagamentodao.getTot(subTotaleCart, spedizioneCart)}" var="totaleCart" />

<div class="mt-3" style="padding: 0;">
    <div class="pl-3 pr-3">
        <h4>Carrello <i style="color: black; margin-top: auto; margin-bottom: auto; margin-left: .5rem;" data-toggle='tooltip' title='I prodotti salvati nel carrello, se non vengono cancellati manualmente, hanno una durata di 30 giorni.' class="fas fa-info-circle"></i></h4>
    </div>
    <c:choose>
        <c:when test="${prodottiCart eq null}">
            <div class="text-center">
                <i style="color: #ff3547;" class="far fa-frown fa-4x mb-3 animated rotateIn"></i>
                <h3 style="text-align: center;">Non hai prodotti nel carrello</h3>
                <p class="pt-5">Ricorda che i prodotti del carrello, se non vengono cancellati manualmente, hanno una durata di <b style="font-weight: bold;">30 giorni</b>.</p>
                <a class="btn" style="background-color: #9e0000; color: white;" href="<c:url value="/bottega.jsp" />">Ritorna alla bottega online</a>
            </div>
        </c:when>
        <c:otherwise>
            <a href="/Bortoleto/carrello.jsp" class="checkout-btn" style="font-weight: 900; color: black;">Procedi con l'ordine</a>
            <ul class="cd-cart-items">
                <c:forEach items="${prodottiCart}" var="prodotto">
                    <c:set var="hasVariant" value="${false}" />

                    <li class="row">
                        <div class="col-3">
                            <div class="image-liquid image-holder--original" style="width: 100%; min-width: 50px; height: 50px; background-image: url('/${prodotto.immagine}');"></div>                  
                        </div>
                        <div class="col-9">
                            <a href="<c:url value="/prodotto.jsp?id=${prodotto.id}&nome=${prodotto.nome.replace(' ', '-')}&cat=${prodotto.categoria.replace(' ', '-')}"/>">${prodotto.nome}</a>
                            <a id="remove-${prodotto.id}" onclick="removeProd(${prodotto.id}, null)" style="float: right;"><img data-toggle="tooltip" title="Rimuovi '${prodotto.nome}' dal carrello" src="/Bortoleto/img/cd-remove-item.svg" alt="remove_${prodotto.id}"/></a>

                            <!-- Prendo tuttel le varianti del prodotto presenti nel carrello -->
                            <c:forEach items="${productdao.getCartProductVariant(request, prodotto.id)}" var="varianti">
                                <c:set var="hasVariant" value="${true}" />
                                <c:set var="valori" value="${varianti.key}"/>
                                <c:set var="quantita" value="${varianti.value}"/>
                                <c:set var="costoV" value="0"/>

                                <hr>
                                <span class="cd-qty"><input onchange="updateQuantity(${prodotto.id}, '${productdao.getVariantBlock(valori)}', $(this).val());" style="border: none; max-width: 3rem;" type="number" min="1" value="${quantita}" /></span>
                                <a id="remove-${prodotto.id}-${productdao.getVariantBlock(valori)}" onclick="removeProd(${prodotto.id}, '${productdao.getVariantBlock(valori)}')"><img style="float: right;margin-right: 10px;" data-toggle="tooltip" title="Rimuovi questa variante dal carrello" src="/Bortoleto/img/cd-remove-item.svg" alt="remove_variante"/></a>
                                <!-- Visualizzo i dati della combinazione di varianti e calcolo il costo -->    
                                <c:forEach items="${valori}" var="variante">
                                    <c:set var="costoV" value="${costoV + variante.supplement}"/>
                                    <div class="cd-price">${variante.variant}: ${variante.variantName}</div>
                                </c:forEach>
                                <!-- Mostro il costo e il peso di un unità di questa combinazione di varianti -->
                                <div style="color: black;" class="cd-price" style="width: max-content;">€ ${String.format('%.2f', costoV).replace(',', '.')} | ${String.format('%.2f', productdao.getWeightOfVariantCombination(valori)).replace(',', '.')} kg.</div>
                            </c:forEach>
                            <!-- Se il prodotto non ha varianti allora visualizzo i dati del prodotto -->
                            <c:if test="${hasVariant eq false}">
                                <br>
                                <span class="cd-qty"><input onchange="updateQuantity(${prodotto.id}, null, $(this).val());" style="border: none; max-width: 3rem;" type="number" min="1" value="${prodotto.quantita}" /></span>
                                <div style="color: black;" class="cd-price" style="width: max-content;">€ ${String.format('%.2f', Double.parseDouble(prodotto.costo.replace(",", ".")))} | ${String.format('%.2f', prodotto.peso).replace(",", ".")} kg.</div>
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


                <div class="pl-3 pr-3">
                    <li class="list-group-item d-flex justify-content-between bg-light">
                        <div class="text-success">
                            <h6 class="my-0">Ritiro in negozio</h6>
                        </div>
                        <span class="text-success">
                            <input type="checkbox" id="ritiroCheckOnModal" onchange="updateCartCarrelloPage(this.checked);"
                                   <c:if test="${ritiroAttribute eq true}">
                                       checked="true"
                                   </c:if>/>
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
                </div>
            </ul> <!-- cd-cart-items -->
            <div class="cd-cart-total pl-3 pr-3" style="color: #ffffff;font-weight: bold;background-color: #b4505a;">
                <p style="padding:5px;margin:0;">Totale dell'ordine<span style='font-size:20px;'>€ ${totaleCart}</span></p>
            </div> <!-- cd-cart-total -->
            <a href="/Bortoleto/carrello.jsp" class="checkout-btn" style="font-weight: 900; color: black;">Procedi con l'ordine</a>
            <a onclick="svuotaCarrello();" class="checkout-btn" style="background-color: #5f0b0b; font-weight: 600;">Svuota carrello</a>
        </c:otherwise>
    </c:choose>    
</div>