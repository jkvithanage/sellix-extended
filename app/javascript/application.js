// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "flowbite/dist/flowbite.turbo.js";
import 'flowbite-datepicker';
import "./controllers"

import DateRangePicker from 'flowbite-datepicker/DateRangePicker';

const dateRangePickerEl = document.getElementById('date-picker');
new DateRangePicker(dateRangePickerEl, {
  format: "yyyy/mm/dd",
  autohide: true,
  clearBtn: true,
  todayBtn: true
});
