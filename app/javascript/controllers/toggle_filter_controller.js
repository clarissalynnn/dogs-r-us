import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-filter"
export default class extends Controller {
  static targets = ["toggleableElement"]
  connect() {
    console.log('Connected!')
  }

  fire () {
    this.toggleableElementTarget.classList.toggle("d-none");
  }
}
