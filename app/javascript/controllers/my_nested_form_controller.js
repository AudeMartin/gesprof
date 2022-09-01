import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sort-dashboard"
export default class extends Controller {

  static targets = ["card", "list"]

  add() {
    console.log(this.cardTarget)
    this.listTarget.insertAdjacentHTML("beforeend", this.cardTarget.innerHTML)
  }
}
