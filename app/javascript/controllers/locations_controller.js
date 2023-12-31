import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["flavorCheckBox"]

  selectAllOptions(event){
    this.flavorCheckBoxTargets.forEach(checkbox => {
      if(event.target.checked == true) {
        checkbox.checked = 'checked'
      } else {
        checkbox.checked = false
      }
    });
  }
}
