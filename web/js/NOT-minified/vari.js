//Tooltip js
$(document).ready(function () {
    $("body").tooltip({selector: '[data-toggle=tooltip]'});
});

/* .js per il Smooth Scrolling */

$(document).ready(function () {
    // Add smooth scrolling to all links in navbar + footer link
    $('a[href*="#"]').on('click', function (event) {

        // Make sure this.hash has a value before overriding default behavior
        if (this.hash !== "") {

            // Prevent default anchor click behavior
            event.preventDefault();

            // Store hash
            var hash = this.hash;

            // Using jQuery's animate() method to add smooth page scroll
            // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
            if ($(hash).offset() === null || $(hash).offset() === undefined) {
                window.location = this;
            } else {
                $('html, body').animate({
                    scrollTop: $(hash).offset().top
                }, 900, function () {

                    // Add hash (#) to URL when done scrolling (default click behavior)
                    window.location.hash = hash;
                });
            }
        } // End if
    });
});
(function ($) {
    "use strict"; // Start of use strict
    // Collapse Navbar
    var navbarCollapse = function () {
        if ($("#mainNav").offset().top > 100) {
            $("#mainNav").addClass("navbar-shrink");
        } else {
            $("#mainNav").removeClass("navbar-shrink");
        }
    };
    // Collapse now if page is not at top
    navbarCollapse();
    // Collapse the navbar when page is scrolled
    $(window).scroll(navbarCollapse);

    // Hide navbar when modals trigger


})(jQuery); // End of use strict

/*
 $(window).load(function () {
 
 $("#preloader").fadeOut("slow");
 
 });*/

window.onscroll = function () {
    scrollFunction();
};

function scrollFunction() {
    if (document.getElementById("myBtn45") !== null) {
        if (document.body.scrollTop > 400 || document.documentElement.scrollTop > 400) {
            document.getElementById("myBtn45").style.display = "block";
        } else {
            document.getElementById("myBtn45").style.display = "none";
        }
    }
}

(function ($) {
    $.fn.searchBox = function (ev) {
        var $searchEl = $(".search-elem");
        var $placeHolder = $(".placeholder");
        var $sField = $("#search-field");
        if (ev === "open") {
            $searchEl.addClass("search-open");
        }

        if (ev === "close") {
            $searchEl.removeClass("search-open"),
                    $placeHolder.removeClass("move-up"),
                    $sField.val("");
        }

        var moveText = function () {
            $placeHolder.addClass("move-up");
        };
        $sField.focus(moveText);
        $placeHolder.on("click", moveText);
        $(".submit").prop("disabled", true);
        $("#search-field").keyup(function () {
            if ($(this).val() != "") {
                $(".submit").prop("disabled", false);
            }
        });
    };
})(jQuery);
$(".search_icon").on("click", function (e) {
    $(this).searchBox("open");
    e.preventDefault();
});
$(".close-search").on("click", function () {
    $(this).searchBox("close");
});