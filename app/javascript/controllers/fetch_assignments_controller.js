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

        if(this.teachersAssignedIdsValue.includes(parseInt(this.teacherTarget.value, 10))){

        Swal.fire({
          title: 'Are you sure?',
          text: "You won't be able to revert this!",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonText: 'Yes, delete it!',
          cancelButtonText: 'No, cancel!',
          reverseButtons: true,
          preConfirm: (updateAssignment) => {
              fetch(url, {
                method: "PATCH",
                headers: { "Accept": "application/json" },
                body:new FormData(this.formTarget)
              })
              .then(response =>{
                if(!response.ok) throw new Error(response.statusText)
                return response.json()
              })
             .catch(error => {
                Swal.showValidationMessage(
                  `Request failed: ${error}`
                )
              })
          },
          allowOutsideClick: () => !Swal.isLoading()
        }).then((result) => {
          if (result.isConfirmed) {
            console.log(result.value.updateAssignment)
            Swal.fire({
              title:'Réaffecter !',
              text:`
               ${result.value.updateAssignment.name} se rendra à cette école ce jour\n
               ${result.value.updateAssignment.email} | ${result.value.updateAssignment.phone_number}
               `,
              icon: 'success'
            })
          } else if (
            /* Read more about handling dismissals below */
            result.dismiss === Swal.DismissReason.cancel
          ) {
            Swal.fire({
             title: 'Annulé',
             text: 'L\'affectation n\a pas était modifié.',
             icon: 'error',
            })
          }
        })
        } else {
            Swal.fire({
              title: 'Confirmation',
              text: `Modifier l'affectation ?`,
              icon: 'question',
              backdrop: true,
              showLoaderOnConfirm: true,
              showCancelButton:true,
              cancelButtonText:'Annuler',
              confirmButtonText: 'Valider',
              preConfirm: (updateAssignment) => {
                fetch(url, {
                  method: "PATCH",
                  headers: { "Accept": "application/json" },
                  body:new FormData(this.formTarget)
                })
                .then(response =>{
                  if(!response.ok) throw new Error(response.statusText)
                  return response.json()
                })
              .catch(error => {
                  Swal.showValidationMessage(
                    `Request failed: ${error}`
                  )
                })
            },
            allowOutsideClick: () => !Swal.isLoading()
            }).then((result)=>{
              if(!result.isConfirmed) this.formTarget.reset()
            })
          }
    }


    //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$Test up$$$$$$$$$$$$$$$$$$
  // new_assignment(e){
  //     e.preventDefault()
  //     //TODO:Dynamic Popup values wip
  //     // const school = this.schoolTarget.selectedOptions[0].textContent;
  //     const url = this.formTarget.action

  //     // if(!this.#isAssigned())

  //     Swal.fire({
  //       title: 'Confirmation',
  //       text: `Modifier l'affectation ?`,
  //       icon: 'question',
  //       backdrop: true,
  //       showLoaderOnConfirm: true,
  //       showCancelButton:true,
  //       cancelButtonText:'Annuler',
  //       confirmButtonText: 'Valider',
  //       preConfirm: async() =>  {
  //         return await fetch(url, {
  //                 method: "PATCH",
  //                 headers: { "Accept": "application/json" },
  //                 body:new FormData(this.formTarget)
  //               })
  //               .then(response =>{
  //                 if(!response.ok) throw new Error(response.statusText)
  //                 return response.json()
  //               })
  //               .then((data) => {
  //                 let content = ''

  //                 if (data)
  //                   content = `
  //                   ${data.name} se rendra à cette école ce jour\n
  //                   ${data.email} | ${data.phone_number}
  //                   `
  //                 else
  //                   content = `Annulé`

  //                 Swal.fire({
  //                   title: `Affectation modifié !`,
  //                   icon: 'success',
  //                   text: content,
  //                   confirmButtonText: 'Fermer',
  //                 })
  //               }).catch(error => {
  //                 Swal.showValidationMessage(
  //                   `Request failed: ${error}`
  //                 )
  //               })
  //       },
  //       allowOutsideClick: () => !Swal.isLoading()
  //     }).then((result)=>{
  //       if(!result.isConfirmed) this.formTarget.reset()
  //     })
  //   }

  //   #isAssigned(){
  //     if(this.teachersAssignedIdsValue.includes(parseInt(this.teacherTarget.value, 10))){
  //       Swal.fire({
  //         title: 'Déjà affecté !',
  //         text: `L'enseignant actuel a déjà une affectation.`,
  //         icon: 'warning',
  //         backdrop: true,
  //         showCancelButton:true,
  //         cancelButtonText:'Annuler',
  //         confirmButtonText: 'Poursuivre',
  //       }).then((result)=>{
  //         if(result.isConfirmed)
  //          return true
  //         else
  //          return false
  //       });
  //     }else{
  //       return true
  //     }
  //   }
}
