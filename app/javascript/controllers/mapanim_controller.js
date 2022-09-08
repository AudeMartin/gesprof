import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="mapanim"
export default class extends Controller {
  anim() {
    var top=(screen.height)/2;
    var left=(screen.width)/2;
    window.open("../anim",'popup',"top="+top+",left="+left+",toolbar=no,scrollbars=no,resizable=no");
  }
}
