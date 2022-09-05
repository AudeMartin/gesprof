import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-dashboard"
export default class extends Controller {

  static targets = ["form", "input", "table"]

  searchIndex() {
    let searchInput = this.inputTarget.value
    const schools = JSON.parse(this.formTarget.dataset.schools)

    const findMatches = (wordToMatch, array) => {
      return array.filter(school => {
        const regex = new RegExp(wordToMatch, 'gi')
        return school[0].match(regex)
      })
    }

    const displayMatches = () => {
      const allMatches = findMatches(searchInput, schools)
      const ids = allMatches.map(school => {
        return school[1]
      })
      if (ids.length === 0) {
        return
        } else {
        this.filter(ids)
      }
    }


    displayMatches()

  }

  filter(schools) {

    const url = `./schools/?search=${schools}`
    console.log(url)
    fetch(url, {
      method: "GET",
      headers: { "Accept": "text/plain","Content-Type": "application/json" }})
      .then(response => response.text())
      .then((data) => {
        this.tableTarget.innerHTML = data
      })

  }
}
