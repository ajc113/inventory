import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/requestjs";

export default class extends Controller {
  static values = { url: String }

  updateReportData(event) {
    get(this.urlValue, {
      contentType: "application/json",
      query: {
        date: event.target.value
      },
      responseKind: "turbo-stream",
      traditional: true
    });
  }
}
