$( document ).on("turbolinks:load", () => {
  $("body").on("click", ".hide-btn", (e) => {
    // alert(e.target.className);
    let pid = e.target.parentElement.previousSibling.previousSibling.textContent.trim();
    // alert(pid);
    // console.log(pid)
    // alert(pid.trim());
    $(`.${pid}`).empty();
  })
})