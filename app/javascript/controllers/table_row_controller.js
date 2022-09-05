import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="table-row"
export default class extends Controller {

  static targets = ["link"]

  redirect() {
    window.location = this.linkTarget.firstElementChild.href
  }
}
