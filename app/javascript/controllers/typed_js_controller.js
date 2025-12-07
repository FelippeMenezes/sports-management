import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

// Conecta-se a data-controller="typed-js"
export default class extends Controller {
  connect() {
    new Typed(this.element, {
      strings: ["Is a web application for managing sports teams, players, matches, and fantasy sports operations."],
      typeSpeed: 40,
      loop: false,
      showCursor: false
    })
  }
}
