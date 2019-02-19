function send_search(e) {
  if (e.which == 13 && $("#search-queue").val() != "") {
    $.ajax({
      type: "GET",
      url: "/search",
      data: {'search': $("#search-queue").val()},
      success: (d) => {
        $("#paste-area").html(d);
      }
    });
  }
}

$(() => {
  $("#search-queue").focus(() => {
    $("#search-queue").val("");
    $("#search-queue").on("keydown", send_search);
  });
  $("#search-queue").on('focusout', () => {
    $("#search-queue").off("keydown", send_search);
    if($("#search-queue").val() == "") {
      $("#search-queue").val("future search queue");
    }
  });
});