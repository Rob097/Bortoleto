<%-- 
    Document   : blogOrder
    Created on : 20-apr-2019, 11.20.15
    Author     : Roberto97
--%>


<!-- Per impedire alla maggior parte dei motori di ricerca di indicizzare la pagina -->
<meta name="robots" content="noindex">
<!-- Per impedire solo a Google di indicizzare la pagina -->
<meta name="googlebot" content="noindex">


<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="request" value="<%=request%>"/>
<c:set value="${blogdao.getAllBlogs()}" var="blogs" />

<c:choose>
    <c:when test="${param.cat != null && !param.cat.equals('')}">
        <c:set value="${catblogdao.getCatByName(param.cat.replace('-', ' '))}" var="cat" />
        <c:set value="${blogdao.getAllBlogsOfCategory(cat.id_cat)}" var="blogs" />
        <h2 class="mt-5 mb-5 black-text"><i class="fas fa-stream mr-2" style="color: black;"></i>${cat.nome}</h2>
        <!-- blogs = getAllBlogOfCategory() 
        if blogs is void -> no category found
        -->
    </c:when>
    <c:when test="${param.tag != null && !param.tag.equals('')}">
        <c:set value="${param.tag.replace('-', ' ')}" var="tag" />
        <c:set value="${blogdao.getAllBlogsWithTag(blogdao.getIDTag(param.tag.replace('-', ' ')))}" var="blogs" />
        <h2 class="mt-5 mb-5 black-text"><i class="fas fa-tag mr-2" style="color: black;"></i>${tag}</h2>
        <!-- blog = getAllBlogWithTag() -->
    </c:when>
</c:choose>

<c:set value="${blogdao.getOrderedBy(request.getParameter('order'), blogs)}" var="blogs" />
<c:choose>
    <c:when test="${param.search != null && param.search != ''}">
        <c:set value="${blogdao.getAllBlogs()}" var="blogs" />
        <c:set value="${blogdao.getOrderedBy(request.getParameter('order'), blogs)}" var="blogs" />
        <h3 id="search_Result" class="black-text text-center">
            Risultati della ricerca: '${param.search}'   
            <a href="<c:url value="/blog.jsp"/>" style="cursor: pointer;">
                <i class="red-text fas fa-times"></i>
            </a>
        </h3><br>
        <c:set value="false" var="checkSearch" /> 
        <c:forEach items="${blogs}" var="blog" >
            <c:out value="CIAO" />
            <c:set var="commenti" value="${commblogdao.getAllCommOfBlog(blog.id).size()}" />
            <c:if test="${blog.nome.toLowerCase().contains(param.search.replace('+', ' ').toLowerCase()) || blog.categoria.toLowerCase().contains(param.search.replace('+', ' ').toLowerCase())}">
                <div class="row mb-4 Post">
                    <div class="col-lg-3  col-md-3 meta-details" style="text-align: right;  margin-top: 35px;">
                        <ul class="tags key" style="padding-left: 0px;">
                            <li><a href="#" class="categoriaArt tagLink">${blog.categoria}</a><i class="fas fa-stream ml-2" style="color: black;"></i></li>
                        </ul>
                        <ul class="tags realTags key black-text textOverflow">
                            <c:forEach items="${blogdao.getAllTextTagsOfBlog(blog.id)}" var="tag" >
                                <li>
                                    <a class="tagLink" href="<c:url value="/blog.jsp?tag=${tag.replace(' ', '-')}"/>">${StringUtils.capitalize(tag.toLowerCase())}</a>
                                </li>
                            </c:forEach>
                        </ul>
                        <div class="user-details row detailPost">
                            <p style="padding-left: 0px;" class="user-name col-lg-12 col-md-12 col-6"><a style="color: #757777;">${blog.creatore}</a><i class="far fa-user" style="color: black;"></i></p>
                            <p style="padding-left: 0px;" class="date col-lg-12 col-md-12 col-6"><a style="color: #757777;">${blog.data.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))}</a> <i class="far fa-calendar-alt" style="color: black;"></i></span></p>
                            <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6"><a style="color: #757777;">${commenti} Commenti</a> <i class="far fa-comment" style="color: black;"></i></p>
                            <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6"><a style="color: #757777;">${blog.views} Letture</a> <i class="far fa-eye" style="color: black;"></i></p>
                        </div>
                    </div>
                    <div class="col-lg-9 col-md-9 ">
                        <div class="feature-img text-center">
                            <img class="lazy img-fluid blogIMG" data-src="/${blog.immagine}" alt="${blog.nome}">
                        </div>
                        <a class="posts-title" href="<c:url value="/articolo.jsp?id=${blog.id}&nome=${blog.nome.replace(' ', '-')}"/>">
                            <h2 class="textOverflow nomeArt mt-3">${blog.nome}</h2>
                        </a>
                        <p class="excert textOverflow" style="color: #000000 !important">
                            ${blog.descrizione}
                        </p>
                        <a href="<c:url value="/articolo.jsp?id=${blog.id}&nome=${blog.nome.replace(' ', '-')}"/>" class="primary-btn btn btn-outline-brown mb-5" style="padding-top: 0; padding-bottom: 0;">Leggi l'articolo</a>
                    </div>
                </div>
                <c:set value="true" var="checkSearch" />   
            </c:if>
        </c:forEach>
        <c:if test="${checkSearch == false}">
            <h4 id="noProd" class="black-text text-center">Non ci sono articoli che corrispondono alla ricerca: '${param.search}'</h4>
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
            <c:when test="${blogs == null || blogs.isEmpty()}">
                <h4 class="mt-5 mb-5 black-text">Nessun articolo trovato</h4>
            </c:when>
            <c:otherwise>
                <c:forEach items="${blogs}" var="blog" >
                    <c:set var="commenti" value="${commblogdao.getAllCommOfBlog(blog.id).size()}" />
                    <div class="row mb-4 Post">
                        <div class="col-lg-3  col-md-3 meta-details" style="text-align: right;  margin-top: 35px;">
                            <ul class="tags key black-text" style="padding-left: 0px;">
                                <li>
                                    <a class="tagLink" href="<c:url value="/blog.jsp?cat=${blog.categoria.replace(' ', '-')}"/>" class="categoriaArt">${blog.categoria}</a>
                                    <i class="fas fa-stream ml-2" style="color: black;"></i>
                                </li>
                            </ul>

                            <ul class="tags realTags key black-text textOverflow mt-2">
                                <c:forEach items="${blogdao.getAllTextTagsOfBlog(blog.id)}" var="tag" >
                                    <li>
                                        <a class="tagLink" href="<c:url value="/blog.jsp?tag=${tag.replace(' ', '-')}"/>">${StringUtils.capitalize(tag.toLowerCase())}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                            <div class="user-details row detailPost">
                                <p style="padding-left: 0px;" class="user-name col-lg-12 col-md-12 col-6"><a style="color: #757777;">${blog.creatore}</a><i class="far fa-user" style="color: black;"></i></p>
                                <p style="padding-left: 0px;" class="date col-lg-12 col-md-12 col-6"><a style="color: #757777;">${blog.data.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))}</a> <i class="far fa-calendar-alt" style="color: black;"></i></span></p>
                                <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6"><a style="color: #757777;">${commenti} Commenti</a> <i class="far fa-comment" style="color: black;"></i></p>
                                <p style="padding-left: 0px;" class="comments col-lg-12 col-md-12 col-6"><a style="color: #757777;">${blog.views} Letture</a> <i class="far fa-eye" style="color: black;"></i></p>
                            </div>
                        </div>
                        <div class="col-lg-9 col-md-9 ">
                            <div class="feature-img text-center">
                                <img class="lazy img-fluid blogIMG" data-src="/${blog.immagine}" alt="${blog.nome}">
                            </div>
                            <a class="posts-title" href="<c:url value="/articolo.jsp?id=${blog.id}&nome=${blog.nome.replace(' ', '-')}"/>">
                                <h2 class="textOverflow nomeArt mt-3">${blog.nome}</h2>
                            </a>
                            <div class="excert textOverflow" style="color: #000000 !important">
                                ${blog.descrizione}
                            </div>
                            <a href="<c:url value="/articolo.jsp?id=${blog.id}&nome=${blog.nome.replace(' ', '-')}"/>" class="primary-btn btn btn-outline-brown mb-5" style="padding-top: 0; padding-bottom: 0;">Leggi l'articolo</a>
                        </div>
                    </div>  
                </c:forEach>
                <h4 id="noProd" class="black-text text-center invisible">Non ci sono articoli che corrispondono alla ricerca</h4>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>
<script>
    $(function () {
        $('.lazy').lazy();
    });
</script>