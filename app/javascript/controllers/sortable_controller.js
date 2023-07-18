import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    this.initializeSortable();
  }

  initializeSortable() {
    let el = document.getElementById('items');

    Sortable.create(el, {
      handle: '.handle',
      group: 'nested',
      animation: 150,
      fallbackOnBody: true,
      swapThreshold: 0.7,
      emptyInsertThreshold: 5,
      direction: 'vertical'
    });
  }
}
