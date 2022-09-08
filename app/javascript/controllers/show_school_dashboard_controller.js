import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-school-dashboard"
export default class extends Controller {
  static targets=['charts', 'map']

  switchTab(e){
    let tab = e.currentTarget

    let chartsTab = this.chartsTarget
    let chartsBtn = document.querySelector('#charts')
    let mapTab = this.mapTarget
    let mapBtn = document.querySelector('#map')

    tab.classList.add('active','tab')

    if(tab.id === 'charts'){
      chartsTab.classList.remove('d-none')
      mapTab.classList.add('d-none')
      mapBtn.classList.remove('active','tab')
    }else{
      mapTab.classList.remove('d-none')
      chartsTab.classList.add('d-none')
      chartsBtn.classList.remove('active','tab')
    }
  }
}
