import { Controller } from "@hotwired/stimulus";
import 'sortablejs';

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
