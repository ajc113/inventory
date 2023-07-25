import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['salesLocationsList', 'productionsLocationsList']

  connect() {
    let currentPath = window.location.pathname;

    document.querySelectorAll('.nav-link').forEach( link => {
      link.parentElement.classList.remove('active-link')
    });

    if (currentPath == '/') { currentPath = '/dashboard' }

    if (currentPath == '/sales') {
      document.getElementById('sales-menu-button').parentElement.classList.add('active-link');
    } else if (currentPath == '/productions') {
      document.getElementById('productions-menu-button').parentElement.classList.add('active-link');
    } else {
      document.querySelector(`a[href="${currentPath}"]`).parentElement.classList.add('active-link');
    }
  }

  activeLink(event) {
    document.querySelectorAll('.nav-link').forEach( link => {
      link.parentElement.classList.remove('active-link')
    });

    event.target.parentElement.classList.add('active-link');
  }

  toggleLocationDropdown() {
    this.salesLocationsListTarget.classList.toggle('hidden');
  }

  toggleProdLocationDropdown() {
    this.productionsLocationsListTarget.classList.toggle('hidden');
  }
}
