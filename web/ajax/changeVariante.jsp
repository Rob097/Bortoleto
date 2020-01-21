<%-- 
    Document   : changeVariante
    Created on : 19 gen 2020, 17:16:46
    Author     : Roberto97
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="request" value="<%=request%>"/>
<c:set value='${productdao.getProduct(param.prod)}' var="prod1"/> <!-- Prodotto a cui ci riferiamo -->
<c:set value='${productdao.getVariant(param.id)}' var="var1"/> <!-- variante scelta -->
<c:set value='${param.varianti}' var="string"/> <!-- Stringa con tutte le variant selezionate della combinazione (serve per mantenere lo stato altrimenti quando seleziono una variante gli evenutali altri select tornano nella posizione di default) -->
<c:set value='${param.quick}' var="isQuick"/>  <!-- Serve per capire se ci riferiamo alla pagina product al prodotto o al modal QuickView -->
<c:set var="array1" value="${productdao.getProductVariant(prod1.id)}"/>  <!-- Tutte le varianti del prodotto in questione, servono per riformare la schermata -->
<c:set var="ids" value="${string.split('_')}" />  <!-- Array con gli id delle varianti che sto selezionando -->
<c:set var="pos" value="${-1}" /> <!-- Posizione di partenza a -1 perchè ad ogni ciclo la incremento e per il primo ciclo mi serve la posizione 0 -->
<c:set var="costo" value="0" />  <!-- costo totale delle scelte selezionate -->
<c:set var="peso" value="0" /> <!-- PEso totale delle scelte selezionate -->

 <!-- ciclo per creare il costo e il peso totali -->
<c:forEach items="${ids}" var="id" >
    <c:set var="var" value="${productdao.getVariant(id)}" />
    <c:set var="costo" value="${costo + var.getSupplement()}" />     
    <c:set var="peso" value="${peso + var.getPesoMaggiore()}" /> 
</c:forEach>

<li>€${costo}</li> <!-- stampo il costo totale -->
<li>${peso}kg</li> <!-- stampo il peso totale -->
    <c:forEach items="${array1}" var="varianti1" >    
        <c:set var="pos" value="${pos + 1}" /> <!-- incremento la posizione da considerare nell'array ids -->
    <li>
        <div class="select__color prodict-statas">
            <div class="div-select">
                <!-- Questo choose serve per capire se usare il metodo quick o no. Il motivo percui ho fatto due metodi lo ho scritto nel metodo quick nel .jsp nella cartella ajax -->
                <c:choose>
                    <c:when test="${isQuick eq true}">
                        <select onchange="changeVarianteQuick(this, ${prod1.id}, ${isQuick});" name="${varianti1.get(0).variant.replace(" ", "")}-${isQuick}" id="${varianti1.get(0).variant.replace(" ", "")}-${isQuick}">
                    </c:when>
                    <c:otherwise>
                        <select onchange="changeVariante(this, ${prod1.id}, ${isQuick});" name="${varianti1.get(0).variant.replace(" ", "")}-${isQuick}" id="${varianti1.get(0).variant.replace(" ", "")}-${isQuick}">
                    </c:otherwise>
                </c:choose>
                    <c:forEach items="${varianti1}" var="variante1" >
                         <!-- nell'options controllo se l'id nella posizione pos dell'array ids è uguale all'id della variante nella rispettiva posizione dell'arraylist varianti1 (che sarebbe l'id di variante1), se è uguale lo segno come selezionato -->
                        <option value="${variante1.id}" <c:if test="${ids[pos] eq variante1.id}">selected="selected"</c:if>>${variante1.variantName}</option>
                    </c:forEach>   
                </select><br>
            </div>
        </div>
    </li>
</c:forEach>