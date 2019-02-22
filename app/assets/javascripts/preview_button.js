function create_markdown_preview(text) {
  $.ajax({
    type: "GET",
    url: "/preview",
    data: {text: text},
    success: (data) => {
      $("#paste-area").html(data);
    }
  });
}
//
// function hello_world() {
//   alert('hello world');
// }
//
// function filter_for_tags() {
//   let result = "";
//   result = $('#note_tags').val().replace(/,\s/g, ",");
//   if (!(result.includes("{") && result.includes("}"))) {
//     result = "{" + result + "}";
//   }
//   $('#note_tags').val(result);
// }