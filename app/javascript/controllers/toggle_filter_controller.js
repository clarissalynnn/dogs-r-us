import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-filter"
export default class extends Controller {
  static targets = ["toggleableElement", "checkboxElement", "filterResult"]
  connect() {
    console.log('Connected!')
  }

  fire (){
    this.toggleableElementTarget.classList.toggle("d-none");
  }

  checkboxSelect(event){
    // Get all the breeds that are currently selected (iterate through all the checkboxes)
    const elements = this.checkboxElementTargets;
    const checkedBoxes = new Array();

    // Get a list of string with only the checked ones
    elements.forEach(element => {
      if (element.checked) {
        checkedBoxes.push(element.dataset.breed);
        console.log(checkedBoxes);
      }
    }
    );

    // Request to the backend with the filter and get all the dogs (as JSON)
    console.log("we got here")
    fetch(`/dogs/filter?values=${checkedBoxes.join(',')}`)
    .then((response) => response.json())
    .then((data) => {
      this.filterResultTarget.innerHTML = data.results;
    }).catch((error) => console.error("Error fetching data:", error));

    // console.log("Clicked!");
    const checkbox = event.target;
    const isChecked = checkbox.checked;
    console.log(checkbox.dataset.breed);
  }
}
