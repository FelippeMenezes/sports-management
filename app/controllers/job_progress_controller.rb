class JobProgressController < ApplicationController
  # We don't need authentication for the status page, as the job_id is already a secret token.
  skip_before_action :authenticate_user!, only: [:progress, :status], raise: false
  # Skip Pundit authorization verification for this controller.
  skip_after_action :verify_authorized
  def progress
    @job_id = params[:job_id]
  end

  def status
    job_status = Sidekiq::Status::get_all params[:job_id]
    render json: {
      status: job_status['status'],
      progress: job_status['pct_complete'],
      message: job_status['message'],
      team_id: job_status['team_id'] # Passing the ID of the created team
    }
  end
end

