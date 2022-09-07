import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="mapanim"
export default class extends Controller {
  anim() {
    open("../anim",'popup','width=480,height=288,toolbar=no,scrollbars=no,resizable=no');
  }
}
