function filter_for_tags() {
  let result = "";
  result = $('#note_tags').val().replace(/,\s/g, ",");
  if (!(result.includes("{") && result.includes("}"))) {
    result = "{" + result + "}";
  }
  $('#note_tags').val(result);
}

$(() => {
//   let text = $('#note_tags').val();
//   console.log(text);
//
//   $('#note_tags').val(filter_for_tags());

  $('#note_tags').blur(filter_for_tags);
});
