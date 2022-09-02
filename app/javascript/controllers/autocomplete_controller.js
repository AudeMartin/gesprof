import { Controller } from "@hotwired/stimulus"
// import 'js-autocomplete/auto-complete.css';
import autocomplete from 'js-autocomplete';

// Connects to data-controller="autocomplete"
export default class extends Controller {

  static targets = ["form", "input", "suggestions"]

  search() {

    let searchInput = this.inputTarget.value
    const schools = JSON.parse(this.formTarget.dataset.schools)
    const suggestions = this.suggestionsTarget

    const findMatches = (wordToMatch, array) => {
      return array.filter(school => {
        const regex = new RegExp(wordToMatch, 'gi')
        return school.match(regex)
      })
    }

    const displayMatches = () => {
      const matchArray = findMatches(searchInput, schools).slice(0,4)
     // console.log(matchArray)
      const html = matchArray.map(school => {
        const regex = new RegExp(searchInput, 'gi')
        const schoolName = school.replace(regex, `<span class="hl">${searchInput}</span>`)
        return `
        <li>
          <span class="name" data-action="click->autocomplete#swap">${schoolName}</span>
        </li>
      `
      }).join('')
      suggestions.innerHTML = html
    }

    displayMatches()
  }

  swap (event) {
    this.inputTarget.value = event.target.innerText
  }

}
