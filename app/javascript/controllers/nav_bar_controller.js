import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['salesLocationsList', 'productionsLocationsList']

  connect() {
    let currentPath = window.location.pathname;
    let secondSlashIndex = window.location.pathname.indexOf('/', 1);

    if(secondSlashIndex > 0) { currentPath = currentPath.substring(0, secondSlashIndex) }

    document.querySelectorAll('.nav-link').forEach( link => {
      link.parentElement.classList.remove('active-link')
    });

    if (currentPath == '/') { currentPath = '/dashboard' }

    if (currentPath == '/sales') {
      document.getElementById('sales-menu-button').parentElement.classList.add('active-link');
    } else if (currentPath == '/productions') {
      document.getElementById('productions-menu-button').parentElement.classList.add('active-link');
    }else if(currentPath == '/transfers') {
      document.querySelector(`a[href="/transfers/new"]`).parentElement.classList.add('active-link');
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
