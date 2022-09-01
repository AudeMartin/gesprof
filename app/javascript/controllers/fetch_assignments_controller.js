import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fetch-assignments"
export default class extends Controller {
  static targets = ['form']
  connect() {
  }

  new_assignment(e){
    e.preventDefault()
    console.log('toto')
  }
}
