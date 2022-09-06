import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="mapanim"
export default class extends Controller {
  connect() {
    console.log("hello there")
  }

  anim() {
    open("../anim",'popup','width=480,height=288,toolbar=no,scrollbars=no,resizable=no');
  }
}
