import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["flavorCheckBox"]

  selectAllOptions(event) {
    const isChecked = event.target.checked;
    this.flavorCheckBoxTargets.forEach(checkbox => {
      checkbox.checked = isChecked;
    });
  }
}
