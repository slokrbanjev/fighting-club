// Fremdbibliotheken (jQuery, meanMenu, slippry) werden im Layout vor dieser Datei eingebunden.

$(function() {
  $(".main-menu").meanmenu({
    // onePage: true,
    meanScreenWidth: 600,
    // drei Balken; die Vorgabe "<span />" wird von jQuery 3 nicht mehr als leeres Element gelesen
    meanMenuOpen: "<span></span><span></span><span></span>"
  });
  // Sanftes Scrollen zu Ankern auf derselben Seite; alle anderen Links (andere Seite,
  // Sprachumschalter "#!") verhalten sich normal.
  $(".main-menu a, .smooth-link, .mean-nav a:not(.mean-expand)").on("click", function() {
    var href = $(this).attr("href") || "";
    var hash = href.indexOf("#") >= 0 ? href.substring(href.indexOf("#")) : "";
    if (hash.length < 2 || !/^#[A-Za-z][\w-]*$/.test(hash)) {
      return;
    }
    var $target = $(hash);
    if (!$target.length) {
      return;
    }
    $("body, html").animate({ scrollTop: $target.offset().top }, 600);
  });
  if ($(".glove").css("transitionDuration") !== "0s") {
    $(document).on("scroll", function() {
      if ($(this).scrollTop() > 100) {
        $(".glove").addClass("punch");
      } else {
        $(".glove").removeClass("punch");
      }
    });
  }
  if ($(".day-toggle").css("display") !== "none") {
    $(".day_header").on("click", function() {
      $(".slots", $(this).closest(".day")).slideToggle();
      if ($(".day-toggle", $(this).closest(".day")).text() === "⬇︎") {
        $(".day-toggle", $(this).closest(".day")).text("⬆︎");
      } else {
        $(".day-toggle", $(this).closest(".day")).text("⬇︎");
      }
    });
  }
  $(".gallery").slippry({
    transition: "kenburns",
    easing: "linear",
    speed: 2000,
    pause: 6000,
    kenZoom: 120,
    autoHover: false
  });
});
