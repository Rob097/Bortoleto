<%-- 
    Document   : cartCarrelloPage
    Created on : 8-feb-2019, 16.15.42
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
<c:set value="${productdao.getCartVariant(request)}" var="variantiCart" />
<c:if test="${param.val eq 'true' || param.val eq 'false'}">
    <c:set var="ritiroAttribute" value="${!param.val}" scope="session"/>
</c:if>
<c:set value="${productdao.getAllProductsOfCart(request)}" var="prodottiCart" />
<c:set value="${productdao.getTotalOfCart(request)}" var="subTotaleCart" />
<c:set value="${productdao.getTotalWeightOfCart(request)}" var="pesoTotaleCart" />
<c:set value="${pagamentodao.getSpeseSpedizione(pesoTotaleCart, ritiroAttribute, request)}" var="spedizioneCart" />
<c:set value="${pagamentodao.getTot(subTotaleCart, spedizioneCart)}" var="totaleCart" />
<c:choose>
    <c:when test="${prodottiCart eq null}">
        <div class="text-center" style="background-color: white;">
            <i style="color: #ff3547;" class="far fa-frown fa-4x mb-3 animated rotateIn"></i>
            <h3 style="text-align: center;">Non hai prodotti nel carrello</h3>
            <p class="pt-5">Ricorda che i prodotti del carrello, se non vengono cancellati manualmente, hanno una durata di <b style="font-weight: bold;">30 giorni</b>.</p>
            <a class="btn" style="background-color: #9e0000; color: white;" href="<c:url value="/bottega.jsp" />">Ritorna alla bottega online</a>
        </div>
    </c:when>
    <c:otherwise>
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
        <a onclick="svuotaCarrello();" class="checkout-btn" style="padding: .75rem 1.25rem; color: white; text-align: center;background-color: #5f0b0b; font-weight: 600;">Svuota carrello</a>
    </c:otherwise>
</c:choose>
