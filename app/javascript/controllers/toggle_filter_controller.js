import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggleableElement", "checkboxElement", "filterResult"];

  connect() {
    console.log('Connected!');
    // Hide filters on page load
    this.toggleableElementTarget.classList.add("d-none");
  }

  fire() {
    this.toggleableElementTarget.classList.toggle("d-none");
  }

  checkboxSelect(event) {
    const elements = this.checkboxElementTargets;
    const checkedBoxes = [];

    elements.forEach(element => {
      if (element.checked) {
        checkedBoxes.push(element.dataset.breed);
      }
    });

    fetch(`/dogs/filter?values=${checkedBoxes.join(',')}`, {
      headers: { "Accept": "application/json" }
    })
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
