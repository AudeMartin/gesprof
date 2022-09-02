import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

// Connects to data-controller="fetch-assignments"
export default class extends Controller {
  static targets = ['form','teacher']
  static values = { teachersAssignedIds: Array }

  new_assignment(e){
      e.preventDefault()
      //TODO:Dynamic Popup values wip
      // const school = this.schoolTarget.selectedOptions[0].textContent;
      const url = this.formTarget.action
      if(!this.#isAssigned()) return
      console.log('passed');
      return
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

    #isAssigned(){
      if(this.teachersAssignedIdsValue.includes(parseInt(this.teacherTarget.value, 10))){
        Swal.fire({
          title: 'Déjà affecté !',
          text: `L'enseignant actuel a déjà une affectation.`,
          icon: 'warning',
          backdrop: true,
          showCancelButton:true,
          cancelButtonText:'Annuler',
          confirmButtonText: 'Poursuivre',
        }).then((result)=>{
          if(!result.isDenied) return false
        });
      }else{
        return true
      }
    }
}
