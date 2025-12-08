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
    @team = Team.new(team_params)
    # Pundit authorization
    authorize @team
    @team.user = current_user
    @team.budget = 100_000

    # Call the service. The service will create the campaign, associate it with the team,
    # save the team, and create rivals and players.
    @campaign = CampaignCreatorService.new(@team).call

    if @campaign.persisted? && @team.persisted?
      redirect_to dashboard_team_path(@team), notice: 'Team and Campaign were successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
