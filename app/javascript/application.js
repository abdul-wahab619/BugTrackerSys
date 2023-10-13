// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

document.addEventListener("DOMContentLoaded", function () {
  const typeSelect = document.querySelector(".type-select");
  const statusSelect = document.querySelector(".status-select");
  console.log("typeSelect:", typeSelect);
  console.log("statusSelect:", statusSelect);
  function updateStatusDropdown(selectedType) {
    statusSelect.innerHTML = "";

    const options = {
      Feature: ["New", "Started", "Completed"],
      Bug: ["New", "Started", "Resolved"],
    };

    if (options[selectedType]) {
      options[selectedType].forEach((option) => {
        const optionElement = document.createElement("option");
        optionElement.value = option.toLowerCase();
        optionElement.text = option;
        statusSelect.appendChild(optionElement);
      });
    }
  }

  typeSelect.addEventListener("change", function (event) {
    const selectedType = event.target.value;
    updateStatusDropdown(selectedType);
  });

  // Initialize the status dropdown based on the initial bug type
  const initialType = typeSelect.value;
  updateStatusDropdown(initialType);
});

const search_box = document.getElementById("search");
const bodyData = document.getElementById("s_body");
search_box.addEventListener("keyup", searchBox);

function searchBox(event) {
  if (event.target.value == "") {
    window.location.href = "/";
    return;
  }
  const ajax = new XMLHttpRequest();

  ajax.onreadystatechange = function () {
    if (ajax.readyState === XMLHttpRequest.DONE) {
      if (ajax.status === 200) {
        bodyData.innerHTML = "";
        const data = JSON.parse(ajax.responseText);
        data.forEach((element) => {
          bodyData.innerHTML +=
            "<tr><td style= 'padding:10px; border:1px solid #000;'>" +
            element.id +
            "</td><td style= 'padding:10px; border:1px solid #000;'>" +
            element.title +
            "</td><td style= 'padding:10px; border:1px solid #000;'>" +
            element.body +
            "</td><td style= 'padding:10px; border:1px solid #000;'><a href=/projects/" +
            element.id +
            ">Show</a> <a href=/projects/" +
            element.id +
            "/edit>Edit</a></tr>";
        });
        console.log(data);
      } else {
        console.error("Error", ajax.status, ajax.statusText);
      }
    }
  };
  ajax.open("GET", "/?a=" + event.target.value, true);
  ajax.send();
}
