import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

// Connects to data-controller="fetch-assignments"
export default class extends Controller {
  static targets = ['form']
  connect() {
  }

  new_assignment(e){
      e.preventDefault()
      //TODO:Dynamic Popup values wip
      // const school = this.schoolTarget.selectedOptions[0].textContent;
      // const teacher = this.teacherTarget.selectedOptions[0].textContent;
      // const formData = new FormData(this.formTarget)
      const url = this.formTarget.action

      Swal.fire({
        title: 'Confirmation',
        text: `Modifier l'affectation ?`,
        icon: 'question',
        backdrop: true,
        showLoaderOnConfirm: true,
        showCancelButton:true,
        cancelButtonText:'Annuler',
        confirmButtonText: 'Valider',
        preConfirm: async() =>  {
          return await fetch(url, {
                  method: "PATCH",
                  headers: { "Accept": "application/json" },
                  body:new FormData(this.formTarget)
                })
                .then(response =>{
                  if(!response.ok) throw new Error(response.statusText)
                  return response.json()
                })
                .then((data) => {
                  Swal.fire({
                    title: `Affectation modifié !`,
                    icon: 'success',
                    text:`
                    ${data.name} se rendra à cette école ce jour\n
                    ${data.email} | ${data.phone_number}
                    `,
                    confirmButtonText: 'Fermer',
                  })
                }).catch(error => {
                  Swal.showValidationMessage(
                    `Request failed: ${error}`
                  )
                })
        },
        allowOutsideClick: () => !Swal.isLoading()
      })
    }
}
