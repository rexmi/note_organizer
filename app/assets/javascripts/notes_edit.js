$(document).on('turbolinks:load', () => {
  $("#preview-button").click((e) => {
    e.preventDefault();
    create_markdown_preview($("#note_body").val());
  });
});