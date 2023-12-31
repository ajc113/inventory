import { Controller } from "@hotwired/stimulus";
import "select2";

export default class extends Controller {
  connect() {
    $('.select2').select2({
      closeOnSelect: false
    });
  }

  selectAllOptions(event) {
    if($(`#${event.target.id}`).is(':checked') ){
      $('.select2').find('option').prop('selected', 'selected').end().select2()
    } else {
      $('.select2').find('option').prop('selected', false).end().select2()
    }
  }
}
