function filter_for_tags() {
  let result = "";
  result = $('#note_tags').val().replace(/,\s/g, ",");
  if (!(result.includes("{") && result.includes("}"))) {
    result = "{" + result + "}";
  }
  $('#note_tags').val(result);
}

$(() => {
  $('#note_tags').blur(filter_for_tags);
});