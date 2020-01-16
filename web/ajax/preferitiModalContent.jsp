<%-- 
    Document   : addPreferito
    Created on : 5-feb-2019, 15.57.18
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
<c:set value="${pagamentodao.getSpeseSpedizione(subTotaleCart, ritiroAttribute, request)}" var="spedizioneCart" />
<c:set value="${pagamentodao.getTot(subTotaleCart, spedizioneCart)}" var="totaleCart" />
<c:set value="${productdao.getProduct(param.id)}" var="prodotto"/>

<div id="preferitiModal" class="modal-dialog modal-full-height modal-bottom modal-notify modal-danger" role="document">

    <div class="modal-content" style="height: auto; min-height: 100%;">

        <div class="modal-header sticky-top">
            <p class="heading lead">Prodotti salvati</p><i style="color: white; margin-top: auto; margin-bottom: auto; margin-left: .5rem;" data-toggle="tooltip" title='I prodotti salvati nei preferiti, se non vengono cancellati manualmente, hanno una durata di 1 anno.' class="fas fa-info-circle"></i>

            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true" class="white-text">×</span>
            </button>
        </div>


        <div class="modal-body">
            <c:choose>
                <c:when test="${preferiti eq null || preferiti.isEmpty()}">
                    <div class="text-center">
                        <i style="color: #ff3547;" class="far fa-frown fa-4x mb-3 animated rotateIn"></i>
                        <h3 style="text-align: center;">Non hai prodotti salvati</h3>
                        <p class="pt-5">Ricorda che i prodotti salvati, se non vengono cancellati manualmente, hanno una durata di <b style="font-weight: bold;">1 anno</b>.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:set value="${productdao.getAllProductsOfSession(preferiti)}" var="prodotti" />
                    <div class="text-center">
                        <i style="color: #ff3547;" class="fa fa-check fa-4x mb-3 animated rotateIn"></i><br>
                        <a href="/Bortoleto/addAllPref" class="btn btn-danger waves-effect">Aggiungi tutto
                            <i class="fa fa-shopping-cart ml-1"></i>
                        </a>
                        <a href="/Bortoleto/removeAllPref" class="btn btn-danger waves-effect">Rimuovi tutto
                            <i class="fas fa-trash ml-1"></i>
                        </a>
                    </div>
                    <table class="table">
                        <thead id="headerPreferiti">
                            <tr>
                                <th scope="col">Nome</th>
                                <th scope="col">Descrizione</th>
                                <th scope="col">Prezzo</th>
                                <th scope="col"></th>
                            </tr>
                        </thead>
                        <tbody id="bodyPreferiti">
                            <c:forEach items="${prodotti}" var="prodotto">
                                <tr class="row righePreferiti">
                                    <td class="col-md-3 w30-xl">
                                        <div>
                                            <h4 class="nomargin" style="font-weight: bold;"><a href="<c:url value="/prodotto.jsp?id=${prodotto.id}&nome=${prodotto.nome.replace(' ', '-')}&cat=${prodotto.categoria.replace(' ', '-')}"/>">${prodotto.nome}</a></h4>
                                            <p style="color: #4cb493;">${prodotto.categoria}</p>
                                        </div>
                                        <div class="image-liquid image-holder--original immaginePreferiti" style="background-image: url('/${prodotto.immagine}');"></div>                                                
                                    </td>
                                    <td class="col-md-3 w50-xl">${prodotto.descrizione}</td>
                                    <td class="col-md-3 w19-xl" style="font-weight: bold;">€ ${prodotto.costo}</td>
                                    <td class="col-md-3 w1-xl">
                                        <c:choose>
                                            <c:when test="${productdao.isInCart(prodotto.id, request) eq true}">
                                                <i data-toggle="tooltip" title='"${prodotto.nome}" gia nel carrello' class="fa fa-check green-text pointer right20pxsm"></i></button>
                                            </c:when>
                                            <c:otherwise>
                                                <c:if test="${prodotto.isDisponibile() eq true}">
                                                    <i data-toggle="tooltip" title='Aggiungi al carrello "${prodotto.nome}"' class="fa fa-plus pointer right20pxsm" onclick="addProd(${prodotto.id}); $(this).removeClass('fa-plus'); $(this).addClass('fa-check');"></i></button>
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>
                                        <i class="fas fa-trash pointer left20pxsm" data-toggle="tooltip" title='Rimuovi "${prodotto.nome}"' onclick="removePreferito(${prodotto.id});"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>                                
        </div>


        <div class="modal-footer">  
            <div class="row" style="width: 100%;">
                <c:choose>
                    <c:when test="${preferiti eq null}">
                        <div class="col-12">
                            <a class="btn btn-danger waves-effect disabled">Aggiungi tutto
                                <i class="fa fa-shopping-cart ml-1"></i>
                            </a>
                        </div>
                        <div class="col-12">
                            <a class="btn btn-danger waves-effect disabled">Rimuovi tutto
                                <i class="fas fa-trash ml-1"></i>
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12">
                            <a href="/Bortoleto/addAllPref" class="btn btn-danger waves-effect">Aggiungi tutto
                                <i class="fa fa-shopping-cart ml-1"></i>
                            </a>
                        </div>
                        <div class="col-12">
                            <a href="/Bortoleto/removeAllPref" class="btn btn-danger waves-effect">Rimuovi tutto
                                <i class="fas fa-trash ml-1"></i>
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <a class="btn btn-outline-danger waves-effect" data-dismiss="modal">Chiudi</a>
        </div>
    </div>

</div>