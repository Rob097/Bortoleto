<!-- Per impedire alla maggior parte dei motori di ricerca di indicizzare la pagina -->
<meta name="robots" content="noindex">
<!-- Per impedire solo a Google di indicizzare la pagina -->
<meta name="googlebot" content="noindex">


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <script type='text/javascript' src='//platform-api.sharethis.com/js/sharethis.js#property=5c9f39799b272f00119ab911&product=social-ab' async='async'></script>
        <link rel="icon" href="https://lh3.googleusercontent.com/VG0xqWynqDpNvACWMyJogjD33onUwKccF6u3Fchrn1f_uIthdtIA274HKBdVZUnnOHyWTYqs2WSthS0oc5kWdoh3aFo3enZshECnIga2DqwVFKUmpeg2cPunqqDd2ztnW3dR9Yg8GfLo0t_Agnj-0I6_GorvaZmi78QHqgWra1JOJk_emcWTLyCjl6Nrixlz6JM1CXcVvmQb3zN05B-hLszQ86_CnQwzjxxVZPjqztikX7f2518X_wGyJYISAzYGtUYK6dhoqnCdku1ZNfNkZzRlOUbN6OuLp5PSgVk2FakHOOEHCNnBNf_VOVOZsNYRbzpAga7ixc1o3fnO3MJHLYIr5t06cAi9iPAdZjq-cCDUaepyUdYNZNnTGhJr_aUdK_Lagrq8qBdH8dRiMYSluHT-7zK4pKenXLxJDaoygPyO8cFk_rLuMbytcYEi9CfhI4inrl7WxFbst0b288P-6T5qVpTHs5jykMgXCw0cGSoSvee-wq_QZSMTVW6CncvC82_qpfLgZFZ6gWljq7BNNvVWn1a0wiS9Ko3pGG_slaRTNJfX7LnLqIIBoyxdZ946ym-a17TYLGrbzb_9ftNP-QxF9m76iOPd-_xm0h3dF4wCHIdSbZHqKhzjCPHF_UN7Q6wWjcWnYyUjIFVTA5GnqsYF5aXJ7XQ=w371-h237-no" sizes="16x16" type="image/png">
        <title>Disiscritto</title>
        <meta name="Description" content="Attenzione! Il tuo ordine è stato ANNULLATO">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="theme-color" content="#31353d">

        <!-- bootstrap include -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="/Bortoleto/css/mdb.min.css" rel="stylesheet">
        <link rel="stylesheet" href="/Bortoleto/css/font-min.css">
        <link rel="stylesheet" href="/Bortoleto/css/navbar-min.css">
        <!-- fine bootstrap include -->
        <style>
            footer{
                background-color:#222222;
                color:white;
                font-family: 'Caveat';
            }
        </style>
    </head>
    <body class="text-center" style="margin: auto auto;">
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                Menu
                <i class="fa fa-bars"></i>
            </button>
            <a id="nav-logo-img" class="navbar-brand" href="<c:url value="/#Bortoleto"/>">
                <img width="90vh" src="https://www.4shared.com/img/Eqhxxzi7fi/s25/166e3520be8/logo2" alt="Logo">
            </a>
            <a id="nav-logo-title" class="navbar-brand js-scroll-trigger" href="/Bortoleto/">'L Bortoleto</a>
            <a class="menu-cart-button hs-cart" href="<c:url value="/bottega.jsp"/>">
                <i style="margin-right: 20px; font-size: 30px; vertical-align:middle;" class="fas fa-shopping-cart"></i>
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
                            <a class="dropdown-item" href="<c:url value="/macelleria.jsp"/>">Per iniziare</a>
                            <a class="dropdown-item" href="<c:url value="/macelleria.jsp#la-nostra-storia"/>">La nostra Storia</a>
                            <a class="dropdown-item" href="<c:url value="/macelleria.jsp#i-nostri-prodotti"/>">I Nostri Prodotti</a>
                            <a class="dropdown-item" href="<c:url value="/macelleria.jsp#raggiungici-macelleria"/>">Raggiungici</a>
                            <a class="dropdown-item" href="<c:url value="/macelleria.jsp#contattaci-macelleria"/>">Contattaci</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <div class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Il Ristorante</div>
                        <div id="" class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="<c:url value="/ristorante.jsp"/>">Per iniziare</a>
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

        <div class="jumbotron" style="margin: auto auto; padding-top: 10rem !important;">
            <h1 class="display-3">Ops..</h1>
            <p class="lead"><strong>Sembra che ci sia stato un errore</strong></p>
            <hr>
            <p>
                per disiscriverti dalla newsletter <a href="<c:url value="/#contattaci"/>">inviaci un'email</a>
            </p>
            <p class="lead">
                <a class="btn btn-primary btn-sm" href="<c:url value="/bottega.jsp"/>" role="button">Torna al negozio</a>
            </p>
        </div>
        <footer id="footer" class="container-fluid text-center">

        </footer>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.7.2/js/all.js" integrity="sha384-0pzryjIRos8mFBWMzSSZApWtPl/5++eIfzYmTgBBmXYdhvxPc+XcFEk+zJwDgWbP" crossorigin="anonymous"></script>
        <!-- MDB core JavaScript -->
        <script type="text/javascript" src="/Bortoleto/js/mdb.min.js"></script>   
        <script src="/Bortoleto/js/nav-min.js"></script> 
        <script>
            /* footer */
            $(function () {
                $("#footer").load("/Bortoleto/ajax/footer.html");
            });
        </script>
    </body>
</html>
