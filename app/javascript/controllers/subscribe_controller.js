import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "errors", "input" ]

  clearErrors() {
    this.errorsTarget.innerHTML = null;
  }

  // expand() {
  //   this.formTarget.classList.add("expanded");
  //   window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' });
  // }
}
