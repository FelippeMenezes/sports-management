import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="progress"
export default class extends Controller {
  static values = {
    jobId: String,
    statusUrl: String,
    redirectUrl: String,
  }
  static targets = ["bar", "percentage", "message", "redirect"]

  connect() {
    this.checkProgress()
    this.timer = setInterval(() => {
      this.checkProgress()
    }, 10)
  }

  disconnect() {
    clearInterval(this.timer)
  }

  checkProgress() {
    const url = this.statusUrlValue.replace('JOB_ID_PLACEHOLDER', this.jobIdValue)

    fetch(url)
      .then(response => response.json())
      .then(data => {
        this.updateProgressBar(data.progress, data.message)

        if (data.status === 'complete' || data.status === 'completed') {
          clearInterval(this.timer)
          this.barTarget.classList.remove('progress-bar-animated')
          this.redirectTarget.classList.remove('d-none')
          this.messageTarget.textContent = "Campanha criada com sucesso! Redirecionando..."

          // Redirect the user to the created team's dashboard
          const teamId = data.team_id || ''; // Ensures teamId is not null/undefined
          const redirectUrl = this.redirectUrlValue.replace('TEAM_ID_PLACEHOLDER', teamId);
          setTimeout(() => { window.location.href = redirectUrl }, 500)

        } else if (data.status === 'failed') {
          clearInterval(this.timer)
          this.messageTarget.textContent = "Ocorreu um erro ao criar a campanha."
          this.barTarget.classList.add('bg-danger')
        }
      })
  }

  updateProgressBar(progress, message) {
    this.barTarget.style.width = `${progress}%`
    this.percentageTarget.textContent = `${progress || 0}%`
    if (message) this.messageTarget.textContent = message
  }
}
