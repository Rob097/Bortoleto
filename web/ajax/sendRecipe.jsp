<%-- 
    Document   : sendRecipe
    Created on : 25-apr-2019, 13.56.35
    Author     : Roberto97
--%>


<!-- Per impedire alla maggior parte dei motori di ricerca di indicizzare la pagina -->
<meta name="robots" content="noindex">
<!-- Per impedire solo a Google di indicizzare la pagina -->
<meta name="googlebot" content="noindex">


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>

<div class="comment-form">
    <h4 class="personalized mb-3">Inviaci una tua idea</h4>
    <form method="POST" action="/Bortoleto/sendRecipe" id="sendRicetta">
        <div class="form-group form-inline">
            <div class="form-group col-lg-6 col-md-12 name">
                <input type="text" class="form-control" id="nome" name="nome" placeholder="Il tuo nome" required>
            </div>
            <div class="form-group col-lg-6 col-md-12 name">
                <input type="email" class="form-control" id="email" name="email" placeholder="La tua email" required>
            </div>
        </div>
        <div class="form-group form-inline">
            <div class="form-group col-lg-12 col-md-12 name">
                <input maxlength="45" type="text" class="form-control" id="titolo" name="titolo" placeholder="Dai un nome alla tua idea" required>
            </div>
        </div>
        <div class="form-group form-inline" id="dynamic_form">
            <div class="form-group col-lg-5 col-md-12 name">
                <input type="text" class="form-control" id="ingrediente" name="ingrediente" placeholder="Cosa" required>
            </div>
            <div class="form-group col-lg-5 col-md-12 name">
                <input type="text" class="form-control" id="quantity" name="quantity" placeholder="Quanto" required>
            </div>
            <div class="button-group form-group col-lg-2 col-md-12">
                <a href="javascript:void(0)" class="btn btn-primary" id="plus" style="padding: .375rem .75rem;">+</a>
                <a href="javascript:void(0)" class="btn btn-danger" id="minus" style="padding: .375rem .75rem;">-</a>
            </div>
        </div>        

        <div class="form-group">
            <textarea maxlength="2500" class="form-control mb-10" rows="5" name="procedimento" placeholder="Procedimento" required></textarea>
        </div>
        <hr style="border: 3px solid rgb(121, 85, 72); width: 50%; border-radius: 100%;"/>
        <div id="recaptcha"><div class="g-recaptcha" data-sitekey="6Ld8YaAUAAAAAKDIu30P3tuRfUuPw-XgFHd9_J5U" data-callback="enableBtn"></div></div>
        <input type="submit" id="sendButton" class="btn primary-btn" value="Invia la ricetta" disabled>
    </form>
</div>
<script src="/Bortoleto/js/dynamic-form-min.js"></script>
<script src="/Bortoleto/js/bootstrap-maxlength-min.js"></script>
<script>
    $(document).ready(function () {
        var dynamic_form = $("#dynamic_form").dynamicForm("#dynamic_form", "#plus", "#minus", {
            limit: 10,
            formPrefix: "dynamic_form",
            normalizeFullForm: false
        });

        dynamic_form.inject([{p_name: 'Hemant', quantity: '123', remarks: 'testing remark'}, {p_name: 'Harshal', quantity: '123', remarks: 'testing remark'}]);

        $("#dynamic_form #minus5").on('click', function () {
            var initDynamicId = $(this).closest('#dynamic_form').parent().find("[id^='dynamic_form']").length;
            if (initDynamicId === 2) {
                $(this).closest('#dynamic_form').next().find('#minus').hide();
            }
            $(this).closest('#dynamic_form').remove();
        });

        $('form').on('submit', function (event) {
            var values = {};
            $.each($('form').serializeArray(), function (i, field) {
                values[field.name] = field.value;
            });
            console.log(values);
            event.preventDefault();
        });
    });
</script>
<script>
    function enableBtn() {
        document.getElementById("sendButton").disabled = false;
    }

    $('input[maxlength], textarea').maxlength({
        alwaysShow: true, //if true the threshold will be ignored and the remaining length indication will be always showing up while typing or on focus on the input. Default: false.
        // threshold: 10, //Ignored if alwaysShow is true. This is a number indicating how many chars are left to start displaying the indications. Default: 10
        warningClass: "form-text text-muted mt-1", //it's the class of the element with the indicator. By default is the bootstrap "badge badge-success" but can be changed to anything you'd like.
        limitReachedClass: "form-text text-muted mt-1", //it's the class the element gets when the limit is reached. Default is "badge badge-danger". Replace with text-danger if you want it to be red.
        //separator: ' of ', //represents the separator between the number of typed chars and total number of available chars. Default is "/".
        //preText: 'You have ', //is a string of text that can be outputted in front of the indicator. preText is empty by default.
        //postText: ' chars remaining.', //is a string outputted after the indicator. postText is empty by default.
        showMaxLength: true, //showMaxLength: if false, will display just the number of typed characters, e.g. will not display the max length. Default: true.
        showCharsTyped: true, //if false, will display just the remaining length, e.g. will display remaining lenght instead of number of typed characters. Default: true.
        placement: 'bottom-right-inside', //is a string, object, or function, to define where to output the counter. Possible string values are: bottom ( default option ), left, top, right, bottom-right, top-right, top-left, bottom-left and centered-right. Are also available : **bottom-right-inside** (like in Google's material design, **top-right-inside**, **top-left-inside** and **bottom-left-inside**. stom placements can be passed as an object, with keys top, right, bottom, left, and position. These are passed to $.fn.css. A custom function may also be passed. This method is invoked with the {$element} Current Input, the {$element} MaxLength Indicator, and the Current Input's Position {bottom height left right top width}.

        //appendToParent: true, // appends the maxlength indicator badge to the parent of the input rather than to the body.
        //message: an alternative way to provide the message text, i.e. 'You have typed %charsTyped% chars, %charsRemaining% of %charsTotal% remaining'. %charsTyped%, %charsRemaining% and %charsTotal% will be replaced by the actual values. This overrides the options separator, preText, postText and showMaxLength. Alternatively you may supply a function that the current text and max length and returns the string to be displayed. For example, function(currentText, maxLength) { return '' + Math.ceil(currentText.length / 160) + ' SMS Message(s)';}
        //utf8: if true the input will count using utf8 bytesize/encoding. For example: the '£' character is counted as two characters.
        //showOnReady: shows the badge as soon as it is added to the page, similar to alwaysShow
        //twoCharLinebreak: count linebreak as 2 characters to match IE/Chrome textarea validation
        //customMaxAttribute: String -- allows a custom attribute to display indicator without triggering native maxlength behaviour. Ignored if value greater than a native maxlength attribute. 'overmax' class gets added when exceeded to allow user to implement form validation.
        //allowOverMax: Will allow the input to be over the customMaxLength. Useful in soft max situations.
    });
</script>
