import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["newsContainer", "readMoreButton", "refreshButton"]

  refresh(event) {
    console.log("Hello from news controller again");
  }
}