import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "flexBreak", "form" ]

  // expand() {
  //   this.formTarget.classList.add("expanded");
  //   window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' });
  // }
}
