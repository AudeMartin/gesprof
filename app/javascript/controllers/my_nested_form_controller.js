import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sort-dashboard"
export default class extends Controller {

  static targets = ["template"]

  add() {
    console.log(this.templateTarget)
  }
}
