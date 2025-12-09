class TeamsController < ApplicationController
  before_action :authenticate_user!
  def index
    # Pundit policy scope
    @teams = policy_scope(Team)
  end

  def show
    @team = Team.find(params[:id])
    # Pundit authorization
    authorize @team
    # Search for rival teams in the same campaign excluding the current team
    @rival_teams = Team.where(campaign: @team.campaign).where.not(id: @team.id)
  end

  def new
    @team = Team.new
    # Pundit authorization
    authorize @team
  end

  def create
    # 1. We create a Team instance just for Pundit authorization.
    @team = Team.new(team_params.merge(user: current_user))
    authorize @team
    # 2. We enqueue the job with the user data and team parameters.
    #    The `to_h` method converts the parameters to a Hash, which is serializable.
    job_id = CampaignCreationJob.perform_later(current_user.id, team_params.to_h).provider_job_id
    # 3. We IMMEDIATELY redirect to the progress page.
    #    The response to the browser is instant. The job will handle the creation in the background.
    redirect_to job_progress_path(job_id: job_id)
  end

  private

  def team_params
    params.require(:team).permit(:name, :number_of_teams)
  end
end
