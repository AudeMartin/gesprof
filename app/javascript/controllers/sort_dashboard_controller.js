import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sort-dashboard"
export default class extends Controller {

  static targets = ["school", "absences", "initial-rate", "assignments", "current-rate"]

  sort() {
    console.log(this.childElement)
  }
}
