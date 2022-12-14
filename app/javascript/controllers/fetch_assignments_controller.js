import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

// Connects to data-controller="fetch-assignments"
export default class extends Controller {
  static targets = ['form','teacher','data' ];

  /**
   *
   * @param {*} e
   */
  new_assignment(e){

        e.preventDefault()
        // const school = this.schoolTarget.selectedOptions[0].textContent;
        const schoolsFilled = JSON.parse(this.dataTarget.dataset.schoolsFilled)
        const validatedAssign = JSON.parse(this.dataTarget.dataset.validatedAssign)

        const url = this.formTarget.action

        const isUnavailable = this.#isAssigned(this.teacherTarget.value, validatedAssign)

        if(isUnavailable.isAssigned){

        const school = this.#getSchool(schoolsFilled, isUnavailable.schoolID)
        const teacherSelected = this.teacherTarget.selectedOptions[0].textContent;

        Swal.fire({
          title: 'Êtes-vous sûr ?',
          text: `
          ${teacherSelected} est déjà affecté\n
          à ${school.name}\n
          située ${school.address}\n
          `,
          icon: 'warning',
          showCancelButton: true,
          confirmButtonText: 'Je confirme',
          cancelButtonText: 'J\'annule',
          backdrop:true,
          reverseButtons: true,
          preConfirm: async () => {
              return await fetch(url, {
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
          if(result.isConfirmed) {
            Swal.fire({
              title:'Modifié !',
              text:`
              ${result.value.teacher.name} se rendra à cette école ce jour\n
              ${result.value.teacher.email} | ${result.value.teacher.phone_number}
              `,
              icon: 'success'
            })
            this.#updatedRatio(result.value.rank, result.value.ratio)
          } else if (
            /* Read more about handling dismissals below */
            result.dismiss === Swal.DismissReason.cancel
          ) {
            this.formTarget.reset()
            Swal.fire({
             title: 'Annulé',
             text: 'L\'affectation n\a pas était modifiée.',
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
              preConfirm: async () => {
                return await fetch(url, {
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
              let content = ''

              if(result.value.teacher){
                content =`
                ${result.value.teacher.name} se rendra à cette école ce jour\n
                ${result.value.teacher.email} | ${result.value.teacher.phone_number}
                `
              }else{
                content ='Affectation annulée'
              }

              if(result.isConfirmed){
                Swal.fire({
                  title:'Modifié',
                  text: content,
                  icon:'success',
                  timer:3000
                })
                this.#updatedRatio(result.value.rank, result.value.ratio)
              }else{
                this.formTarget.reset()
              }
            })
          }
          this.styleForm()
    }

    /**
     *
     * @param {integer} teacher
     * @param {array} assignments
     * @returns
     */
    #isAssigned(teacher, assignments){
      let result = {
        isAssigned : false,
        schoolID: null,
      }

      assignments.forEach((assignment)=>{
       if(assignment.teacher_id === parseInt(teacher)){
          result.isAssigned = true
          result.schoolID = assignment.school_id
       }

      })
      return result
    }

    /**
     *
     * @param {array} schools
     * @param {integer} id
     * @returns
     */
    #getSchool(schools, id){
      let result = {}
      schools.forEach((school)=>{
          if(school.id === id){
            result = school
          }
      })
      return result;
    }

    /**
     *
     * @param {*} e
     */
    styleForm(e = null){
      const selected = e ? parseInt(e.currentTarget.value) : this.teacherTarget.value
      const teachersIds = JSON.parse(this.dataTarget.dataset.teachersAssigned).map(teacher => teacher.id)
      const teacher = this.teacherTarget

      if(teachersIds.includes(selected)){
        teacher.classList.remove('is-valid', 'is-invalid')
        teacher.classList.add('is-invalid')
      }else{
        teacher.classList.remove('is-invalid','is-valid')
        teacher.classList.add('is-valid')
      }

    }

    /**
     *
     * @param {string} rank
     * @param {integer} ratio
     */
    #updatedRatio(rank, ratio){
      const currentRatio = document.querySelector('#ratio');
      currentRatio.innerHTML = `${Math.floor(ratio*100)}%`
      currentRatio.classList.remove('low','medium','high')
      currentRatio.classList.add(rank)
    }
}
