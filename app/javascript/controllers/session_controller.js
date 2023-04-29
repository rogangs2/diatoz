import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    let url = window.location.href;
    let model = url.includes("subscriber") ? "subscriber" : "author";
    let page = url.includes("login") ? "login" : "new";
    if (page == "login") {
      let element1 = document.getElementById("session_person");
      element1.setAttribute("value", model);
    }
    if (page == "new") {
      if (model == "subscriber") {
        document.getElementById("tag-1").style.display = "none";
      } else {
        document.getElementById("tag-1").style.display = "none";
      }
    }
  }
}
