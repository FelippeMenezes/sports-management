import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

// Conecta-se a data-controller="typed-js"
export default class extends Controller {
  initialize() {
    this.boundStartTyped = this.startTyped.bind(this);
  }

  connect() {
    document.addEventListener("turbo:load", this.boundStartTyped);
    this.startTyped(); // Para a primeira carga da página
  }

  disconnect() {
    document.removeEventListener("turbo:load", this.boundStartTyped);
  }

  startTyped() {
    new Typed(this.element, {
      strings: ["It's a web application for managing soccer teams, players, playing friendly matches and exclusive championships."],
      typeSpeed: 40,
      loop: false,
      showCursor: false
    })
  }
}
