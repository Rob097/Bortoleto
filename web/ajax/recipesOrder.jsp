<%-- 
    Document   : recipesOrder
    Created on : 22-apr-2019, 19.14.12
    Author     : Roberto97
--%>


<!-- Per impedire alla maggior parte dei motori di ricerca di indicizzare la pagina -->
<meta name="robots" content="noindex">
<!-- Per impedire solo a Google di indicizzare la pagina -->
<meta name="googlebot" content="noindex">


<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="request" value="<%=request%>"/>
<c:set value="${ricettedao.getAllRecipes()}" var="ricette" />
<c:set value="${ricettedao.getMostViewedRecipes()}" var="viewed" />


<c:choose>
    <c:when test="${param.cat != null && !param.cat.equals('')}">
        <c:set value="${ricettedao.getByType(param.cat)}" var="ricette" /> 
        <c:choose>
            <c:when test="${param.cat.equals('1')}">
                <h2 class="mt-5 mb-5 black-text"><i class="fas fa-stream mr-3" style="color: black;"></i>Le nostre idee</h2>
            </c:when>
            <c:when test="${param.cat.equals('2')}">
                <h2 class="mt-5 mb-5 black-text"><i class="fas fa-stream mr-3" style="color: black;"></i>Le vostre idee</h2>
                <a class="invisible-sm" onclick="sendRicetta();"><h1 class="mt-2 mb-5" style="color: #065906;"><i class="fas fa-pen-alt mr-2" style="color: #065906;"></i>Inviaci una tua idea</h1></a>
            </c:when>
        </c:choose>
    </c:when>
    <c:when test="${param.prod != null && param.prod != 0}">
        <c:set value="${ricettedao.getRecipeOfProduct(param.prod)}" var="ricette" /> 
        <nav id="breadcrumb">
            <ol class="cd-breadcrumb custom-separator" itemscope itemtype="https://schema.org/BreadcrumbList">
                <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                    <a itemprop="item" href="<c:url value="/#Bortoleto"/>"><span itemprop="name">Home</span></a>
                    <meta itemprop="position" content="1" />
                </li>
                <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                    <a itemprop="item" href="<c:url value="/idee.jsp"/>"><span itemprop="name">Idee in Cucina</span></a>
                    <meta itemprop="position" content="2" />
                </li>
                <li class="current" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                    <a href="<c:url value="/idee.jsp?prod=${productdao.getProduct(param.prod).id}&nome=${productdao.getProduct(param.prod).nome.replace(' ', '-')}"/>" itemprop="item" ><em><span itemprop="name">${productdao.getProduct(param.prod).nome}</span></em></a>
                    <meta itemprop="position" content="3" />
                </li>
            </ol>
        </nav>
        <h3 class="mt-5 mb-5 black-text">
            <i class="fas fa-stream mr-3" style="color: black;"></i>
            ${productdao.getProduct(param.prod).nome}
        </h3>   
    </c:when>
</c:choose>

<c:set value="${ricettedao.getOrderedBy(request.getParameter('order') , ricette)}" var="ricette" />

<c:choose>
    <c:when test="${param.search != null && param.search != ''}">
        <c:set value="${ricettedao.getAllRecipes()}" var="ricette" />
        <c:set value="${ricettedao.getOrderedBy(request.getParameter('order') , ricette)}" var="ricette" />
        <h3 id="search_Result" class="black-text text-center">
            Risultati della ricerca:  
            <a href="<c:url value="/idee.jsp"/>" style="cursor: pointer;">
                <i class="red-text fas fa-times"></i>
            </a>
        </h3><br>
        <c:set value="false" var="checkSearch" /> 
        <c:forEach items="${ricette}" var="ricetta" >
            <c:set value="${ricettedao.getComments(ricetta.id)}" var="commenti" />
            <c:if test="${ricetta.nome.toLowerCase().contains(param.search.replace('+', ' '))}">
                <div class="row mb-4 Ricetta">
                    <div class="col-lg-3  col-md-3 meta-details" style="text-align: right;  margin-top: 35px;">
                        <c:if test="${ricetta.id_prod ne null && ricetta.id_prod != 0}">
                            <ul class="tags key black-text" style="padding-left: 0px;">
                                <li>
                                    <a href="<c:url value="/idee.jsp?prod=${ricetta.id_prod}&nome=${ricetta.nome.replace(' ', '-')}"/>" class="categoriaArt">${productdao.getProduct(ricetta.id_prod).nome}</a>
                                    <i class="fas fa-stream ml-2" style="color: black;"></i>
                                </li>
                            </ul>
                        </c:if>
                        <div class="user-details row detailPost" style="color: #777777;">
                            <p style="padding-left: 0px;" class="creator user-name col-lg-12 col-md-12 col-6">${ricetta.creatore}<i class="far fa-user ml-2" style="color: black;"></i></p>
                            <p style="padding-left: 0px;" class="date col-lg-12 col-md-12 col-6">${ricetta.data.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))}<i class="far fa-calendar-alt ml-2" style="color: black;"></i></span></p>
                            <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6">${commenti.size()} Commenti<i class="far fa-comment ml-2" style="color: black;"></i></p>
                            <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6">${ricetta.views} Letture<i class="far fa-eye" style="color: black;"></i></p>
                            <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6">${ricetta.tempo} Minuti<i class="far fa-clock ml-2" style="color: black;"></i></p>
                            <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6">${ricetta.difficolta}<i class="far fa-smile ml-2" style="color: black;"></i></p> 
                        </div>
                    </div>
                    <div class="col-lg-9 col-md-9 ">
                        <div class="feature-img text-center">
                            <img class="lazy img-fluid blogIMG" data-src="/${ricetta.immagine}" alt="${ricetta.nome}">
                        </div>
                        <a class="posts-title" href="<c:url value="/idea.jsp?id=${ricetta.id}&nome=${ricetta.nome.replace(' ', '-')}"/>">
                            <h2 class="textOverflow nomeRic mt-3">${ricetta.nome}</h2>
                        </a>
                        <p class="excert textOverflow">
                            ${ricetta.descrizione}
                        </p>
                        <a href="<c:url value="/idea.jsp?id=${ricetta.id}&nome=${ricetta.nome.replace(' ', '-')}"/>" class="primary-btn btn btn-outline-brown mb-5" style="padding-top: 0; padding-bottom: 0;">scopri di più</a>
                    </div>
                </div>
                <c:set value="true" var="checkSearch" />   
            </c:if>
        </c:forEach>
        <c:if test="${checkSearch == false}">
            <h4 id="noProd" class="black-text text-center">Non ci sono ricette che corrispondono alla ricerca</h4>
        </c:if>
    </c:when>
    <c:otherwise>
        <h3 id="search_Result" class="black-text text-center invisible">
            Risultati della ricerca:  
            <a onclick='deleteSearch();' style="cursor: pointer;">
                <i class="red-text fas fa-times"></i>
            </a>
        </h3><br>
        <c:choose>
            <c:when test="${ricette == null || ricette.isEmpty()}">
                <h3 class="mt-5 mb-5 black-text">Tante teste, tante idee! Contribuisci anche tu!</h3>
                <a onclick="sendRicetta();"><h3 class="mt-2 mb-5" style="color: #065906;"><i class="fas fa-pen-alt mr-2" style="color: #065906;"></i>Inviaci una tua idea</h3></a>
            </c:when>                                
            <c:otherwise>
                <c:forEach items="${ricette}" var="ricetta" >
                    <c:set value="${ricettedao.getComments(ricetta.id)}" var="commenti" />
                    <div class="row mb-4 Ricetta">
                        <div class="col-lg-3  col-md-3 meta-details" style="text-align: right;  margin-top: 35px;">
                            <c:if test="${ricetta.id_prod ne null && ricetta.id_prod != 0}">
                                <ul class="tags key black-text" style="padding-left: 0px;">
                                    <li>
                                        <a href="<c:url value="/idee.jsp?prod=${ricetta.id_prod}&nome=${ricetta.nome.replace(' ', '-')}"/>" class="categoriaArt">${productdao.getProduct(ricetta.id_prod).nome}</a>
                                        <i class="fas fa-stream ml-2" style="color: black;"></i>
                                    </li>
                                </ul>
                            </c:if>
                            <div class="user-details row detailPost" style="color: #777777;">
                                <p style="padding-left: 0px;" class="creator user-name col-lg-12 col-md-12 col-6">${ricetta.creatore}<i class="far fa-user ml-2" style="color: black;"></i></p>
                                <p style="padding-left: 0px;" class="date col-lg-12 col-md-12 col-6">${ricetta.data.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))} <i class="far fa-calendar-alt ml-2" style="color: black;"></i></span></p>
                                <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6">${commenti.size()} Commenti <i class="far fa-comment ml-2" style="color: black;"></i></p>
                                <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6">${ricetta.views} Letture <i class="far fa-eye ml-2" style="color: black;"></i></p>
                                <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6">${ricetta.tempo} Minuti<i class="far fa-clock ml-2" style="color: black;"></i></p>
                                <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6">${ricetta.difficolta}<i class="far fa-smile ml-2" style="color: black;"></i></p> 
                            </div>
                        </div>
                        <div class="col-lg-9 col-md-9 ">
                            <div class="feature-img text-center">
                                <img class="lazy img-fluid blogIMG" data-src="/${ricetta.immagine}" alt="${ricetta.nome}">
                            </div>
                            <a class="posts-title" href="<c:url value="/idea.jsp?id=${ricetta.id}&nome=${ricetta.nome.replace(' ', '-')}"/>">
                                <h2 class="textOverflow nomeRic mt-3">${ricetta.nome}</h2>
                            </a>
                            <p class="excert textOverflow">
                                ${ricetta.descrizione}
                            </p>
                            <a href="<c:url value="/idea.jsp?id=${ricetta.id}&nome=${ricetta.nome.replace(' ', '-')}"/>" class="primary-btn btn btn-outline-brown mb-5" style="padding-top: 0; padding-bottom: 0;">scopri di più</a>
                        </div>
                    </div>  
                </c:forEach>
                <h4 id="noProd" class="black-text text-center invisible">Non ci sono ricette che corrispondono alla ricerca</h4>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>
<script>
    $(function () {
        $('.lazy').lazy();
    });
</script>