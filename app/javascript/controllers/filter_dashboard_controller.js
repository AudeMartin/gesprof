import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-dashboard"
export default class extends Controller {

  static targets = ["form", "input", "suggestions", "table"]

  searchIndex() {
    let searchInput = this.inputTarget.value
    const schools = JSON.parse(this.formTarget.dataset.schools)
    const suggestions = this.suggestionsTarget
    const schoolNames = schools.map(school => school[0])
    const schoolIds = schools.map(school => school[1])

    const findMatches = (wordToMatch, array) => {
      return array.filter(school => {
        const regex = new RegExp(wordToMatch, 'gi')
        return school[0].match(regex)
      })
    }

    const displayMatches = () => {
      const matchArray = findMatches(searchInput, schools).slice(0,4)
      const html = matchArray.map(school => {
        const regex = new RegExp(searchInput, 'gi')
        const schoolName = school[0].replace(regex, `<span class="hl">${searchInput}</span>`)
        const schoolID = school[1]
        return `
        <li>
          <span class="name" data-action="click->filter-dashboard#filter">${schoolName}</span>
        </li>
      `
      }).join('')
      suggestions.innerHTML = html

    }

    displayMatches()
  }

  filter(event) {

    const filteredSchool = event.target.innerText
    console.log(this.tableTarget.innerHTML)
   // this.tableTarget.innerHTML = `<%= render "table", school: School.find_by(name: "${filteredSchool}" %>`
  }
}
