import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "flexBreak", "form" ]

  expand() {
    this.formTarget.style.display = "inherit";
    setTimeout(() => {
      this.formTarget.classList.remove("collapsed");
    }, 0)
    setTimeout(() => {
      window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' });
    }, 0)
  }
}
