import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sort-dashboard"
export default class extends Controller {
  static targets = ["list", "assId"]

  add() {
    console.log(this.cardTarget)
    const assId = this.assIdTarget.innerText
    const cardHTML = `<div class="card" data-my-nested-form-target="card">
      <div class="row">
        <div class="col">
          <div class="mb-3 text optional school_assignments_teacher_message"><label class="form-label text optional" for="school_assignments_attributes_${assId}_teacher_message">Message au remplaçant</label><textarea class="form-control text optional" name="school[assignments_attributes][${assId}][teacher_message]" id="school_assignments_attributes_${assId}_teacher_message"></textarea></div>
        </div>
        <div class="col">
          <div class="mb-3 text optional school_assignments_area_message"><label class="form-label text optional" for="school_assignments_attributes_${assId}_area_message">Message au gestionnaire</label><textarea class="form-control text optional" name="school[assignments_attributes][${assId}][area_message]" id="school_assignments_attributes_${assId}_area_message"></textarea></div>
        </div>
          <div class="mb-3 hidden school_assignments_date"><input class="form-control hidden" value="2022-09-01" autocomplete="off" type="hidden" name="school[assignments_attributes][${assId}][date]" id="school_assignments_attributes_${assId}_date"></div>
          <button type="button" data-action="nested-form#remove">Supprimer</button>

          <input autocomplete="off" type="hidden" value="false" name="school[assignments_attributes][${assId}][_destroy]" id="school_assignments_attributes_${assId}__destroy">
      </div>
    </div>`
    this.assIdTarget.innerText = Number(assId) + 1
    this.listTarget.insertAdjacentHTML("beforeend", cardHTML)
  }
}
