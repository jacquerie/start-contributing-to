$(document).ready(function () {
  $("#language").on("changed.bs.select", function (e) {
    $("html, body").animate({
      scrollTop: $("#" + e.target.value).offset().top - 90,
    });
  });
});
