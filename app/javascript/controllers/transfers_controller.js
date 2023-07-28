import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['newTransfersLocationList']

  toggleNewTransferDropdown() {
    this.newTransfersLocationListTarget.classList.toggle('hidden');
  }
}
