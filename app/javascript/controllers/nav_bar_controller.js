import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['salesLocationsList', 'productionsLocationsList']

  toggleLocationDropdown() {
    this.salesLocationsListTarget.classList.toggle('hidden');
  }

  toggleProdLocationDropdown() {
    this.productionsLocationsListTarget.classList.toggle('hidden');
  }
}
