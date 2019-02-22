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

// function filter_for_tags() {
//   let result = "";
//   result = $('#note_tags').val().replace(/,\s/g, ",");
//   if (!(result.includes("{") && result.includes("}"))) {
//     result = "{" + result + "}";
//   }
//   $('#note_tags').val(result);
// }

// $(() => {
//   $("#search-queue").focus(() => {
//     $("#search-queue").val("");
//     $("#search-queue").on("keydown", send_search);
//   });
//   $("#search-queue").on('focusout', () => {
//     $("#search-queue").off("keydown", send_search);
//     if($("#search-queue").val() == "") {
//       $("#search-queue").val("future search queue");
//     }
//   });
// });

$(document).on('turbolinks:load', function() {
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
  // if($("#note_tags").length) {
  //   $('#note_tags').blur(filter_for_tags);
  // }
  // $("#note_tags").ready(() => {
  //   console.log('yoyoyoyoyoyo');
  // });
})