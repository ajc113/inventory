import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['salesLocationsList']

  toggleLocationDropdown() {
    this.salesLocationsListTarget.classList.toggle('hidden');
  }
}
