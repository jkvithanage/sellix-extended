import { Controller } from "@hotwired/stimulus"
import "flowbite/dist/flowbite.turbo.js";
import 'flowbite-datepicker';

import DateRangePicker from 'flowbite-datepicker/DateRangePicker';

// Connects to data-controller="flowbite"
export default class extends Controller {
  static targets = ['datePicker']
  initialize() {
    new DateRangePicker(this.datePickerTarget, {
      format: "yyyy/mm/dd",
      autohide: true,
      clearBtn: true,
      todayBtn: true
    });
  }
}
