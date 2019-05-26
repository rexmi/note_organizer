$( document ).on("turbolinks:load", () => {
  $("body").on("click", ".hide-btn", (e) => {
    // let pid = e.target.parentElement.previousSibling.previousSibling.textContent.trim();
    pid = e.target.id
    // $(`.${pid}`).empty();

    if($(`.${pid}`).attr("class").includes("invisible")) {
      $(`.${pid}`).removeClass("invisible").addClass("visible");
    } else {
      $(`.${pid}`).addClass("invisible");
    }
  })
})