function filter_for_tags() {
  let result = "";
  result = $('#note_tags').val().replace(/,\s/g, ",");
  if (!(result.includes("{") && result.includes("}"))) {
    result = "{" + result + "}";
  }
  $('#note_tags').val(result);
}

$(document).on('turbolinks:load', () => {
  $('#note_tags').blur(filter_for_tags);

  $("#preview-button").click((e) => {
    e.preventDefault();
    create_markdown_preview($("#note_body").val());
  });
});
