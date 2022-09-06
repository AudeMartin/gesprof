import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sort-dashboard"
export default class extends Controller {
  static targets = ["list", "assId"]

  add() {
    // console.log(this.cardTarget)
    const assId = this.assIdTarget.innerText
    const cardHTML = `<div class="card nestedform" id="card-${assId}" data-my-nested-form-target="card">
      <div class="row">
        <div class="col">
          <div class="mb-3 text optional school_assignments_teacher_message"><label class="form-label text optional" for="school_assignments_attributes_${assId}_teacher_message">Message au remplaçant</label><textarea class="form-control text optional" name="school[assignments_attributes][${assId}][teacher_message]" id="school_assignments_attributes_${assId}_teacher_message"></textarea></div>
        </div>
        <div class="col">
          <div class="mb-3 text optional school_assignments_area_message"><label class="form-label text optional" for="school_assignments_attributes_${assId}_area_message">Message au gestionnaire</label><textarea class="form-control text optional" name="school[assignments_attributes][${assId}][area_message]" id="school_assignments_attributes_${assId}_area_message"></textarea></div>
        </div>

        <div class="col">

        <div class="mb-3 date optional school_assignments_date"><label class="form-label date optional" for="school_assignments_attributes_${assId}_date_3i">Date du remplacement</label><div class="d-flex flex-row justify-content-between align-items-center"><select id="school_assignments_attributes_${assId}_date_3i" name="school[assignments_attributes][${assId}][date(3i)]" class="form-select mx-1 is-valid date optional" value="2022-09-01">
<option value="1" selected="selected">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<option value="11">11</option>
<option value="12">12</option>
<option value="13">13</option>
<option value="14">14</option>
<option value="15">15</option>
<option value="16">16</option>
<option value="17">17</option>
<option value="18">18</option>
<option value="19">19</option>
<option value="20">20</option>
<option value="21">21</option>
<option value="22">22</option>
<option value="23">23</option>
<option value="24">24</option>
<option value="25">25</option>
<option value="26">26</option>
<option value="27">27</option>
<option value="28">28</option>
<option value="29">29</option>
<option value="30">30</option>
<option value="31">31</option>
</select>
<select id="school_assignments_attributes_${assId}_date_2i" name="school[assignments_attributes][${assId}][date(2i)]" class="form-select mx-1 is-valid date optional" value="2022-09-05">
<option value="1">Janvier</option>
<option value="2">Février</option>
<option value="3">Mars</option>
<option value="4">Avril</option>
<option value="5">Mai</option>
<option value="6">Juin</option>
<option value="7">Juillet</option>
<option value="8">Août</option>
<option value="9" selected="selected">Septembre</option>
<option value="10">Octobre</option>
<option value="11">Novembre</option>
<option value="12">Décembre</option>
</select>
<select id="school_assignments_attributes_${assId}_date_1i" name="school[assignments_attributes][${assId}][date(1i)]" class="form-select mx-1 is-valid date optional" value="2022-09-05">
<option value="2017">2017</option>
<option value="2018">2018</option>
<option value="2019">2019</option>
<option value="2020">2020</option>
<option value="2021">2021</option>
<option value="2022" selected="selected">2022</option>
<option value="2023">2023</option>
<option value="2024">2024</option>
<option value="2025">2025</option>
<option value="2026">2026</option>
<option value="2027">2027</option>
</select>
</div></div>
      </div>









        <div class="w-100 d-flex justify-content-end">
          <button type="button" class="btn btn-outline-primary !important"  id="btn-${assId}">Supprimer</button>

        </div>
        <hr>
          </div>
    </div>`
    this.assIdTarget.innerText = Number(assId) + 1
    this.listTarget.insertAdjacentHTML("beforeend", cardHTML)
    const btn = document.getElementById(`btn-${assId}`)
    const card = document.getElementById(`card-${assId}`)
    console.log(btn);
    btn.addEventListener("click", (event) =>{
      card.outerHTML = ""
    })
  }
}
