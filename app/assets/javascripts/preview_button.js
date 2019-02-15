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

function hello_world() {
  alert('hello world');
}