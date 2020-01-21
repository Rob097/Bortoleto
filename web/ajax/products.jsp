<%-- 
    Document   : products
    Created on : 16-mar-2019, 15.02.53
    Author     : Roberto97
--%>



<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="mt-5 mb-5 text-center">
    <h3 class="macTitle" data-aos="fade-right" data-aos-duration="2000">I nostri prodotti</h3>
    <a class="buttonS" href="#content" onclick="backToPrincipale();" style='color: black;'>Torna indietro</a>
</div>

<div id="carousel-example-multi" class="carousel slide carousel-multi-item v-2 white-text" data-ride="carousel">

    <div class="carousel-inner" role="listbox">
        <div id="productElements" style="flex-wrap: unset; color: black; margin-top: 1.5rem; overflow-x: auto; overflow-y: hidden; display: inline-flex;" class="carousel-item active nav nav-tabs" role="tablist"> 
            <div class="col-md-4 zoomSlide nav-item active" data-toggle="tab" href="#carne" >
                <a class="nav-link" style="border: none;">
                    <div class="card mb-2">
                        <div class="image-liquid image-holder--original card-img-top" style=" background-image: url('https://lh3.googleusercontent.com/yhX8Chr9raW4fOuzTeqJAYmb8EpTJF1TLfCy-4o7B7tM7JAE3Q45J992i_IbbUC7TxiKSBdpaqhN_JGM9gqCoTaLQ_qySXcWnrwT6uSYZK4D_Kh86M_DTSxChDmFiYYNMPwuA5EKRA=w2400');height: 15rem;" alt="Carne"></div>                                            
                        <div class="card-body">
                            <h2 class="card-title font-weight-bold black-text">La Carne</h2>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 zoomSlide nav-item" data-toggle="tab" href="#salumi">
                <a class="nav-link" style="border: none;">
                    <div class="card mb-2">
                        <div class="image-liquid image-holder--original card-img-top" style=" background-image: url('https://lh3.googleusercontent.com/M9N4ETlcOj3uXo_bja_DL_qCveouyGan6Cfl6Q1xdsUKkLKph7V8BjWtkoLj-VwXyH-jdlggatxwDQLmexrVVJZlYY0vHGI2jrKCz_SK40eCY-Ab2lYJqKvYtEx9nAwrWiKB-1TtZw=w2400');height: 15rem;" alt="Salumi"></div>                                            
                        <div class="card-body">
                            <h2 class="card-title font-weight-bold black-text">I Salumi</h2>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 zoomSlide nav-item" data-toggle="tab" href="#formaggio">
                <a class="nav-link" style="border: none;">
                    <div class="card mb-2">
                        <div class="image-liquid image-holder--original card-img-top" style=" background-image: url('https://lh3.googleusercontent.com/FCs5BAIliI7G5RePP4nLvEIy3PwtEg0S7dkGypxZqOjpXnJtXfLpLmuYXFCg5kZ2Lp8wDnJK2tr_4FGcV0R8Dyugi1vZU2YpeYEBuMMxLfTBfoGd1Gj4frYIN38ZjMMA8Wk-mhGv_w=w2400');height: 15rem;" alt="Formaggi"></div>                                            
                        <div class="card-body">
                            <h2 class="card-title font-weight-bold black-text">Il Formaggio</h2>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 zoomSlide nav-item" data-toggle="tab" href="#trentino">
                <a class="nav-link " style="border: none;">
                    <div class="card mb-2">
                        <div class="image-liquid image-holder--original card-img-top" style=" background-image: url('https://lh3.googleusercontent.com/8nfnixlyMQHb97-nHuSKcuZaDmqLjl7558H4CEO3AFDgvy4_HBEkorXSCscmmpf3axWFsAWo-jLgq46li3Bfk8bICY91QwhG1dUC4FaiysTPdd7foP3Ji3zmN4f_wlc3KRpJWkmL2g=w2400');height: 15rem;" alt="Trentino"></div>                                            
                        <div class="card-body">
                            <h2 class="card-title font-weight-bold black-text">Il Trentino</h2>
                        </div>
                    </div>
                </a>
            </div>            
        </div>
    </div>
</div>



<div class="tab-content text-center">
    <div class="tab-pane active" id="carne" role="tabpanel">                  
        <h3 class="titoloModal mt-5 mb-5">La <span style="font-weight: 900;">Carne</span></h3>

        <div id="slidecarne" class="carousel slide" data-interval="850000" data-ride="carousel">
            <div class="carousel-inner text-center">
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/4PmNw5s7S-GFnybOkDE7xeVpymerTnlFvrWaPqLqisFKdQsYSKL8GeFNpBjvx4ErVNnBCGBdZv3IG7BqEDP8vmygi5L6LfTtMRKFE03gTi8KwaTja6HDLVj5rVojHnDzQfpntQ5zLA=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/BQ6-A0rFU2UFzo0qNJA3mhvxaAU9aqcqtbaV-lVAPZGl_3ZguUdwF4KGDZQwmttJyeM80hq5loQEwD68Ywzn4vOe1ke-H7Q2R7GYXkQneT0Voe3kTeXT7qehc2nIy-nfccHQ3p0KOg=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/6JnEMDfJEpT0S7OoQ04Zv16xnAuh7p3KgXik2FwB9GFKam7PdVCWXwG1YaQoTtH0bbxRXYqAMMQ2BaRXVk1HLTBs7IkJ9GgG1y5oR789JKVY8tv-skPuBtf8bO3nAUC3gmSBr0N3sw=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/BV8tfNh10iyIukgaHtzjhfJz_Fl7PTuGtfpFgylqZYjbk6Z0XrjIIjYYKC89fBen-1-ie7BJqQZRl6hvQtoi_LT1oMSQprp6AyNRMuwrncngp1O63nUGyofeRIY94fAPU4he_-OMmg=w2400">
                </div>
                <div class="carousel-item active">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/w--fB409tCF0ht9MhjxjKJ19PEZXvRfzXD-5era0zmKhbZPnEiCYgZ_KT3HKXuo4paH_sNE83sJ-xKaVOVQXBXfovfVgJ3ktcL-QRrKiyu744-Cc3nR3koLcyB69mPtvR5UiS1NcOQ=w2400">
                </div>
            </div>
            <a class="carousel-control-prev" href="#slidecarne" role="button" data-slide="prev">
                <span aria-hidden="true"><i style="color: black; font-size: xx-large;" class="fas fa-angle-left"></i></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#slidecarne" role="button" data-slide="next">
                <span aria-hidden="true"><i style="color: black; font-size: xx-large;" class="fas fa-angle-right"></i></span>
                <span class="sr-only">Next</span>
            </a>
        </div>


        <h5 class="text-justify scritteproducts pt-3 text-center description" style="color:#bb5154"><b>I tipi di carne che offriamo ogni giorno ai nostri clienti sono molto variegati e apprezzzati.<br>In particolare:</b><br><br></h5>
        <ul class="text-justify modalCaption description" style="color: black;"><li>La carne bovina ed equina proveniente dagli allevamenti delle nostre valli e macellate presso il Nostro macello privato: gustose tenere e lavorate sapientemente.<br><br></li>
            <li>La carne suina tra cui una selezione marchiata Bizzotto allevata e macellata in trentino e val di Fiemme.<br><br></li>
            <li>IL coniglio valligiano allevato a Tesero. I caprini e gli ovini, anch'essi  nostrani e macellati da noi stessi.<br><br></li>
            <li>La selvaggina nostrana di cacciagione presente fresca da settembre a dicembre (durante la stagione venatoria), e lungo tutto l’anno congelata.<br><br></li>
            <li>La carne di pollo, tacchino, vitello tutta naturalmente italiana.<br></li></ul>
        <br><hr class="style18"><br>
    </div>

    <div class="tab-pane" id="salumi" role="tabpanel">
        <h2 class="titoloModal mt-5 mb-5">Salumi Insaccati Elenco</h2>
        <div id="slidesalumi" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner text-center">
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/4zZXY7yxPpXABXoURmpmTEfrxnkf93iZJK9rjbg38IUSArmhVJubvmT5EGKqnaiwuxpBoap4NwTSjW9XMROsj4HdU_f7p2c3sIlsk3AnL26lewh010adqqIK95ETfvn84gxQpaU0Rw=w2400">
                </div>
                <div class="carousel-item active">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/_9xxFzu_7b9aCTwjGLPo97BQekEZgacVTc0QOmxR8W4ZeimdgyG5o_pxfjmZgAt6by3nnlarJq3QK3Bqlge7s7uMW5g79wtehuwpEynl3uXqBPe72lwb0O3PCnFXzZh_CtCQWZv3fw=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/yFTnooYvC6rE2xanyISEV_bDBEamlTcDMH7Udp7del7WEGUKcAkMdLLsfeBxOJZ7DSN7kOKv3thv_6iF6mJh0c5-LJhapR-0SP_d_xhbqxrulzRXE4nFZrn4cfDrgLEFgFb9Vckatg=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/9cFJAoIPbSsjPCNWsrxLrbk8CDNEYjpCQC_ZfZLIsttu9TW9mby5BKstVrIJ4v7lRLRSthiOH94D0ActcXIbLDU7MiYEUnh82AnFRy0JFSCjACSnXxPFZAOT-76RVzxeRrlJxf9-EA=w2400">
                </div>
                <div class="carousel-item">
                    <img  class="img-rounded img-prod" src="https://lh3.googleusercontent.com/KJ4EXpVsbVGReNjhVbFKjUjPVdUKEVhjJswBg3UFkzjn8SN3FsaJLI0UbNp_quCoGRT2hc7uy5tCJ3FeMVtlRgdDAWszgpJ6RjYjHj97LTLARWsQg4dg8JBgsSL1wHWUw7SXkSHdSQ=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/I6CmjJ_bCg2Wka0GFAHtHPmP0_BCOOUQlwvME1exn1BA_WViS6OhOWVbOKyqLsyoiaafgQSad8hIushQYWs5g4ArEM_FfPljNiQPMo7VK3uMXdR-IB219ZpbIJ2nOfubj443YptQEA=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/jzr8FDjAWiQQkd-i0XpLurmd5j_DibTJLhFHdPvHeciNrp89p77NUuIEqIILETtZBYhTJ4fctSgbRGmSRtPHD1WmmkTWuT06aHA9CT2fYhjO29TaAkDDyoPpTvu_-11KX7teG51A6g=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/ZHup7GxfjU613HArQjMMiWp551X2-0lAtLm5IoC2Qc82CfHfM25qgPLGUa3C8c1n4Rv9HSVYloh3lpLf2oauyd2wiDjr86Kfk9dFByMdifvieSKAH2-Agyfpv5RSgmdnoeAiYM8jKg=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/T9o5hVtWyNPuoEDLJThiYRJo6N5FmoHzZm0Vze24gReMfsTksONZo-uNa8jyoq5fYjC8SyH6Ia4xyDS-mBRgr7W7Ac8WilSUY2kTFthZ4VmireFYrKLn_EmC_zevTosEA84JdbRyHA=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/hladRhokTihh0HT5O67-iRKM47TZC_WAIKjNJcLQR3SZhRVy0aDdqj8qHhh9sF2quTBqkcpDVpaRu5LaEy2I3M7fx-e5S95lGqSIijCywD70kiv-NDbPuwEkfCDMintDuV1ruyozwQ=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/3kutFYCS1u0cte1yB4oTKNyio4NqYbma4ihjaF1rBapOsDmUsLDlssf1ICOZld-GOuakl6ZHyJvQkeLWixJP-7n3FCwXJkyj7svU101Be6kayVGcAEnHZrHlWapP5B-CfZSGBcZBpQ=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/F5rZB7xmaBy92Ct0ZGht7CWaOGo5_FUAx8qPLphDT8KyCqbs2jUf90EsQ6c0e4eBmvtvLEyz1n5aLdEJGQm05VF8PSNSC9QB0gKsG6VP7-OA2fLQRC8P-syX4_Mns0i6De1A5yBd2w=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/Qf_dOU6KjBXVnlrdgeqzT33nD8B6HQRb6froYCGiyrF8yf1v1QLDWDD53iUp13NzinDSRos8G5mC7XIU9aXTsW-uPAt27Mb3EdgaR7pr9iXsATxpK2AiF8coTyTVNgN9TQbjSBKqig=w2400">
                </div>
            </div>
            <a class="carousel-control-prev" href="#slidesalumi" role="button" data-slide="prev">
                <span aria-hidden="true"><i style="color: black; font-size: xx-large;" class="fas fa-angle-left"></i></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#slidesalumi" role="button" data-slide="next">
                <span aria-hidden="true"><i style="color: black; font-size: xx-large;" class="fas fa-angle-right"></i></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <h5 class="text-justify scritteproducts pt-3 text-center description" style="color:#bb5154"><b>I nostri salumi sono realizzati da mastri salumieri da oltre un secolo!</b><br><br></h5>
        <ul class="text-justify modalCaption description" style="color: black;">
            <p>L'assortimento è sicuramente vasto, dai salumi di manzo e cavallo (con carni macellate da noi), a quelli di puro suino allevato e macellato in trentino con marchio Bizzotto. Sono quasi tutti senza glutine e lattosio, per venire incontro alle nuove esigenze alimentari.<br>Ecco un elenco dei salumi che potrete trovare nei nostri punti vendita o che potrete accquistare nella nostra bottega online o via email con spedizione direttamente a casa vostra, ovunque in Italia.</p>
            <br><hr class="style18"><br>
            <h3 class="text-center description" style="color:#ff8000; font-size: 1.75rem;">INSACCATI SATGIONATI</h3><br>
            <dl>
                <li><dt class="nomesalume">LUGANEGA NOSTRANA:</dt><dd class="descrizionesalumeright">Salamino nostrano dal gusto deciso ma equilibrato.</dd></li>
                <li><dt class="nomesalume">LUGANEGA FINA:</dt><dd class="descrizionesalumeright">Un vero e proprio ungheresino nostrano lievemente affumicato e aromatizzato.</dd></li>
                <li><dt class="nomesalume">IL FEUDO:</dt><dd class="descrizionesalumeright">Salsiccia secca sale e pepe dalla forma allungata, delicato e ideale per i bambini.</dd></li>
                <li><dt class="nomesalume">SALAMINO EQUINO:</dt><dd class="descrizionesalumeright">Con carne equina dal gusto forte e aromatizzato, ottimo accompagnato al pane.</dd></li>
                <li><dt class="nomesalume">SALAME DI SELVAGGINA:</dt><dd class="descrizionesalumeright">Nostrana di cacciagione, cervo capriolo o camoscio a voi la scelta.</dd></li>
                <li><dt class="nomesalume">SALAME NOSTRANO:</dt><dd class="descrizionesalumeright">In budello di manzo (più saporito) o di suino (più dolce), un classico.</dd></li>
                <li><dt class="nomesalume">SALAME AL PUZZONE:</dt><dd class="descrizionesalumeright">Salame nostrano con all’interno pezzetti di formaggio Puzzone di Moena.</dd></li>
                <li><dt class="nomesalume">LE PATRONE E IL CERVO:</dt><dd class="descrizionesalumeright">Piccole e originali; le prime piccanti, le seconde di cervo, da portare con voi ovunque.</dd></li>
                <li><dt class="nomesalume">LANDJAGHER:</dt><dd class="descrizionesalumeright">Miste suino e bovino affumicate con forno a legna, ideali per una merenda in alta montagna.</dd></li>
                <li><dt class="nomesalume">LUCANICA AFFUMICATA:</dt><dd class="descrizionesalumeright">Morbida, magra e con tutto il gusto del fumo originato dalla legna della val di fiemme.</dd></li>
                <li><dt class="nomesalume">LA TRENTINA</dt><dd class="descrizionesalumeright">Salciccia stagionata e aromatizzata con vera droga trentina.</dd></li>
                <p style="color: #b4505a">Ma anche la mortandela della val di Non, la sopressa con aglio e occasionalmente salami d’asino e cinghiale</p>
            </dl>
            <br><hr class="style18"><br>
            <h3 class="text-center description" style="color:#ff8000; font-size: 1.75rem;">STAGIONATI AFFUMICATI E COTTI</h3><br>
            <dl>
                <li><dt class="nomesalume">SPECK E PANCETTA AFFUMICATA:</dt><dd class="descrizionesalumeleft">Un classico, affumicato con sola legna naturale dei boschi del Trentino e prodotto artigianalmente nei nostri laboratori. Suddiviso in 3 tipologie principali il nostro speck passa dai pezzi magri come il filetto o il fiocco ai pezzi classici, che raggiunti i 6 mesi di stagionatura vengono costantemente controllati per evitare un’eccessiva asciugatura fino al raggiungimento massimo di 8 mesi. In fine troviamo il grasso. Speck di scrofe Trentine stagionato per 14 mesi dall’amabile sapore dolce. Probabilmente i prodotti che più ci caratterizzano in termini di qualità, i nostri speck e le nostre Pancette affumicate vengono realizzati dai nostri salumieri che toccano con mano ogni singola unità per assicurarne l'eccellenza.</dd></li>
                <li><dt class="nomesalume">LA BRESAOLA:</dt><dd class="descrizionesalumeleft">Affumicata di bovino, equino o cervo; magra e leggera, ideale per qualsiasi dieta</dd></li>
                <li><dt class="nomesalume">SPECK COTTO - PROSCIUTTINO TIROLESE:</dt><dd class="descrizionesalumeleft">Perfetto connubio tra il nostro prosciutto cotto e lo speck, lo speck cotto e il prosciuttino tirolese, consistono in prosciutto cotto lievemente affumicato con aromi delicati, ottimo da affettare e gustare con il pane. Il primo è un formato simile ai normali prosciutti cotti, il secondo un piccolo e comodo formato, l'ideale per realizzare regali tipici del luogo</dd></li>
                <li><dt class="nomesalume">AFFUMICATI COTTI:</dt><dd class="descrizionesalumeleft">I piatti tipici trentini sono perlopiù caratterizzati dall'affumicatura, per questo nei nostri punti vendità potrai trovare Carrè, lonza, stinco, puntine e pancetta affumicati; l'ideale per accompagnare le minestre o i crauti, già cotti e affumicati; oppure in padella come bistecca (carrè) o al forno (stinco), con un sapore unico e originale</dd></li>
            </dl>
            <br><hr class="style18"><br>
            <h3 class="text-center description" style="color:#ff8000; font-size: 1.75rem;">INSACCATI E SALUMI FRESCHI</h3><br>
            <dl>
                <li><dt class="nomesalume">LUGANEGA FRESCA E SALSICCIA TRENTINA:</dt><dd class="descrizionesalumeleft">Non poteva mancare nel nostro catalogo la famosa 'luganega fresca' e la 'salsiccia trentina', gli stessi insaccati che puoi trovare negli splendidi rifugi che popolano le nostre Dolomiti. La prima di puro suino mentre l’altra mista al vitello con una spolverata dell'ottimo 'aroma trentino', ottime in cucina</dd></li>
                <li><dt class="nomesalume">WURSTEL:</dt><dd class="descrizionesalumeleft">Il classico Prodotto Bavarese approda nelle nostre valli. Il Wurstel, assortito in varie forme e gusti; dai più delicati, morbidi e senza pelle 'spellati' ai più decisi e croccanti 'meraner' a pelle naturale, dai tozzi 'dickwurst' di grandi dimensioni ai candidi 'weisswurst' (non affumicati). </dd></li>
                <li><dt class="nomesalume">CARNE SALADA:</dt><dd class="descrizionesalumeleft">La nostra carne salada non e' carne salada del Trentino solo per la tradizione, ma anche e sopratutto per l'origine della materia prima. Carne di bovino della Val di Fiemme sapientemente aromatizzata per portarla ad avere un gusto deciso ma non invasivo rendendola piacevole sia agli adulti che ai piu' piccoli. Tagliata un po spessa da scottare in padella o sottile da mangiare come carpaccio. La prima ottima accompagnata dai fagioli, la seconda guarnita con olio, grana e rucola fresca.</dd></li>
            </dl></ul>
        <br><hr class="style18"><br>
    </div>

    <div class="tab-pane" id="formaggio" role="tabpanel">
        <h3 class="titoloModal mt-5 mb-5">Il <span style="font-weight: 900;">Formaggio</span></h3>
        <div id="slideformaggio" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner text-center">
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/AitCVM2-sPH-UeaO7EFfB3Z6H-Qoy-uhL-nbVu9GPTJjW_R7RnHo-tXv5J5xZnVTIWVoBslU8aUYuo2nc_F4aRVrRvL8M7xYVcoIoC9a2KvDgLmU6nd0i12i6sOVwOBtY7o9GfLSXw=w2400">
                </div>
                <div class="carousel-item active">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/J70YQyrwDVoo8rNmOCSlJq8xSucEk8mVsdpo5CQa4Y_vK3-BekUQoTzAXtpWhWm1cGoF8Q28kLZSBWTgxWrGe39MGuGyW6ay24Cj7JjmPwwVH3db43NuqvhetnSfSSwwljetvCRhug=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/iil4eVFUBjo6CZa43cW1If8OhAg8b-oGsI8uU-Ky7RuIgFeaMyasBwMypBn-aezQ_6FMSPepebKBvLncOlVSZMT4p_w0s8GTw0l2mOV41Da6dZv2bzfhh8xnB-MHlD0HvGD1YaY9qA=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/RKFRzCXSlaMGI85jwmsGI8qnMjKV-oGqTlbkUuqERTCdR1JbGZ89T3SeJcE0zTL1_ZGOJutRve1xIw6tmQXT2Ch1jvhL4RrXu6UMQvpeh1UaoypvNkzpJfuGM7b4qdC4KgBTzn1i-A=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/pjWgsveuneUrnCfNthRdRicB26kwGxL01Y02ylIW6l5Fjc8c1Fs530OmN0EmCJAzsEE8r5FH0FAkc08paawpuI1Dhgrcbd4_1f9U87ssm9nGi3l0UOZhFe0pWC9RdZc7yc3qDKzwZA=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/7zRxZHplVhOnK1TrYTDhLdWhBd7-DNsqHK-H27PBhCgy8QejgMUmXqfabjsEbxVbA_Yg5c8LZRpYl7NYwjkSDCMJ5lf4UrVbG_dpUtVl-SURhFZEEKYhqzh7ylPGLNJq4teQhsMFQQ=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/Z7QmgMv8rbESASNmhIhurF4VD34ISdR1PmdBhHrJhRXo_-rNqniE44Ym3pmWwsdtniKngKouWpSspiETIjun1SWZpT9Tvrhy4APkjc3-kx0d1MjlBdrJSSNI4YnSasuxXsdCwwVwHA=w2400">
                </div>
            </div>
            <a class="carousel-control-prev" href="#slideformaggio" role="button" data-slide="prev">
                <span aria-hidden="true"><i style="color: black; font-size: xx-large;" class="fas fa-angle-left"></i></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#slideformaggio" role="button" data-slide="next">
                <span aria-hidden="true"><i style="color: black; font-size: xx-large;" class="fas fa-angle-right"></i></span>
                <span class="sr-only">Next</span>
            </a>
        </div>


        <h5 class="text-justify scritteproducts pt-3 text-center description" style="color:#bb5154"><b>"Locale" è la parola d'ordine. Tutti i nostri formaggi provengono dalle malge delle nostre montgne e dai caseifici dei nostri paesi.</b><br><br></h5>
        <ul class="text-justify modalCaption description" style="color: black;">
            <p>
                Entrambi i nostri negozi hanno a disposizione numerosi formaggi del luogo di diversi tipi per soddisfare ogni esigenza:<br>
            </p><li>dai formaggi a pasta morbida dolci come il 'Fontal' o a pasta morbida saporiti come il famossisimo 'Puzzone di moena';</li><br>
            <li>ai formaggi stagionati come il 'Bastardo', 'stagionato nel fieno', 'stagionato nel vino';</li><br>
            <li>alle caciotte come la 'cacciota Malga Cerin' proveniente da una piccola malga locale;</li><br>
            <li>E moltissimi altri ancora.</li><br> 
            Vieni a trovarci per scoprire molto di più!
            <p></p>
        </ul>
        <br><hr class="style18"><br>        
    </div>

    <div class="tab-pane" id="trentino" role="tabpanel">
        <h3 class="titoloModal mt-5 mb-5">Il <span style="font-weight: 900;">Trentino</span></h3>
        <div id="slidetipici" class="carousel slide" data-interval="850000" data-ride="carousel">
            <div class="carousel-inner text-center">
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/iISsR62fAV7_GcygtPZN-tUfPUgOYk_WzTDxzbVFmtPPLG4_HiF61r5q7ZV8Im47fitsNLttscgbI6-tfiXEaSq94O3MaVJznGP3YAliS7vcLQntaFXqIPLd7uxiFNmHyuF6IQs3Xw=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/I3T6wtshsuPY4HnOM5mw04MFu_uQ9KN3e2BTbpQCscl5f6-zVDV-IORS6RL7RkX4gkGMKrw-6n-QQAAlDD_-2gyaFWq1IGEyw_rbvf6iVqdIKqhgMFQ8n0sfC1lKrWjg4WQ2sqVt8w=w2400">
                </div>
                <div class="carousel-item active carousel-item-left">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/nGaNKZqnLepHblWPDw-rUIABJYWIYJ-3uSOmgkKsee5nCjXFCut9Z-WohdjXDZOb7xC34N0O3qHmUHG0hTCnhmOGtwnidhUZY3BbH8fJZafvyLGp3KqMsLvTNWOOQBK2UYsjDQKdPw=w2400">
                </div>
                <div class="carousel-item carousel-item-next carousel-item-left">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/ZkhXNmah_f19BNkhEUNPIWN_A38Fum2d-VhbcMxIioXUermbh6TBCp8G_RCzEPLCGDi5rurw7s-OBg113jsjpMdRsg7xDH7GB7u4iU2JKLaqS7Idxl3ukTOjplGo3XlF9Tsk-Fg-Xw=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/fkXKCJwVtcnrEVe0AeqaZFFhzZxRjKxyRUEu-bJdbuYfH7psjeWpPrlqQ6RBxRvisCerGxSOjf1aep-VMypYWjZha_IK1bvK1Jz_WSXn-qBFsrlqKnzxClgf8a91NrscQroUyenNSw=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/jFw6s9Mhm_7_koSEToesmnESdz54GD6xrbSN_zwprxbsMZUCaFlPxNWrcsWAcppgK_uVIhIZgNFKANe-Sv_mTGdbkOBxpkDzlYXgqmbokrfhQy4mibTI3_uEAVXn8kUri9_zrxk3DA=w2400">
                </div>
                <div class="carousel-item">
                    <img class="img-rounded img-prod" src="https://lh3.googleusercontent.com/C7LzEIaiDPihjBUty6zxjCyN9e6XOQwqEIEDdJztOg-qtK4lpxM86gxUGITDBXe6EloAXttDhbWTYZvv-JOOL15CJJasXT0CROU9DWTieBYejxw3AaGxZeL5nfG0oZJMGx6VKOIAVQ=w2400">
                </div>
            </div>
            <a class="carousel-control-prev" href="#slidetipici" role="button" data-slide="prev">
                <span aria-hidden="true"><i style="color: black; font-size: xx-large;" class="fas fa-angle-left"></i></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#slidetipici" role="button" data-slide="next">
                <span aria-hidden="true"><i style="color: black; font-size: xx-large;" class="fas fa-angle-right"></i></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <h5 class="text-justify scritteproducts pt-3 text-center description" style="color:#bb5154"><b>Gli articoli venduti nel nostro punto vendita sono per lo più locali</b><br><br></h5>
        <ul class="text-justify modalCaption description" style="color: black;">
            <p>Locale è la parola d’ordine; per questo motivo gli articoli venduti nei nostri punti vendita sono per lo più locali, come i formaggi, i vini, il miele, la marmellata, i funghi, la polenta, la pasta e molto altro.<br>In particolare ecco un breve elenco dei prodotti trentini che potete trovare da noi:<br>
            </p><li>Vini rossi e bianchi provenienti dalle migliori cantine della regione e non solo, dal teroldego alla nosiola, dal pinot nero franz haas al rinomato san Leonardo e molto altro ancora.</li><br>
            <li>Polenta trentina da cucinare, istantanea o già cotta. La famosissima Polenta di Storo.</li><br>
            <li>Funghi secchi o sott’olio.</li><br>
            <li>Selezione Monograno della famosa pasta Felicetti;   Farro Kamut o Granoduro.</li><br>
            <li>Mieli trentini della ditta Castel Thun, marmellate, confetture, mostarde, pane tirolese. cetrioli, ragù di nostra produzione e molto altro.... viene a scoprire un universo di sapori.</li><br>
            <p style="color: #b4505a">Inoltre confezioniamo bellissimi cesti e idee regalo per qualsiasi evento (premiazioni sportive, compleanni, natale, ecc...)</p><br>
        </ul>
        <br><hr class="style18"><br>
    </div>
</div>

<div class="mt-5 mb-5 text-center">
    <a class="buttonS" href="<c:url value="/bottega.jsp"/>" style='color: white; background-color: #bb5154;'>Acquista</a>
    <ul class="list-inline dim">
        <li><u><h4>Contattaci</h4></u></li>
        <li>Email: info@macelleriadellantonio.it</li>
        <li>Telefono: 0462-501231</li>
    </ul>
    <a class="buttonS" href="#content" onclick="backToPrincipale();" style='color: black;'>Torna indietro</a>
</div>