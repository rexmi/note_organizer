// function filter_for_tags() {
//   let result = "";
//   result = $('#note_tags').val().replace(/,\s/g, ",");
//   if (!(result.includes("{") && result.includes("}"))) {
//     result = "{" + result + "}";
//   }
//   $('#note_tags').val(result);
// }
//
// $(() => {
//   alert('wtf2');
//   $('#note_tags').blur(filter_for_tags);
// });


$(() => {
  $("#preview-button").click((e) => {

    e.preventDefault();
    // $.ajax({
    //   type: "GET",
    //   url: "../preview",
    //   data: {text: $("#note_body").val()},
    //   success: (data) => {
    //     $("#paste-area").html(data);
    //   }
    // });
    create_markdown_preview($("#note_body").val());
  });
});