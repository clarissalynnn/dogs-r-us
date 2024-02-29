import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggleableElement", "checkboxElement", "filterResult"];

  connect() {
    console.log('Connected!');
    // Hide filters on page load
    this.toggleableElementTarget.classList.add("d-none");
  }

  // This hides the filters on pageload.
  fire() {
    this.toggleableElementTarget.classList.toggle("d-none");
  }

  checkboxSelect() {
    // Initialized the checkbox element.
    const elements = this.checkboxElementTargets;

    // Created an empty array to push the values of the checked checkboxes.
    const checkedBoxes = [];

    // Iterate through all the checked checkboxes
    elements.forEach(element => {
      // If the checkbox is checked, push the value(breed) of that checkbox
      // into the empty array above.
      if (element.checked) {
        checkedBoxes.push(element.dataset.breed);
      }
    });

    // Use the array of checkbox values and pass that into the URL which will be
    // fetched in the backend. -> goes to filter() in dogs_controller
    fetch(`/dogs/filter?values=${checkedBoxes.join(',')}`, {
      headers: { "Accept": "application/json" }
    })
    // The block below processes the data received from running th filter() method
    // in dogs_controller.
      .then(response => response.json())
      .then(data => {
        this.filterResultTarget.innerHTML = "";
        data.forEach(dog => {
          this.filterResultTarget.insertAdjacentHTML("beforeend", `<div class="col-md-6 col-sm-12">${dog}</div>`);
        });
      })
      .catch(error => console.error("Error fetching data:", error));
  }
}
