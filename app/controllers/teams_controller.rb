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
    # Associate the team with the current user
    @team.user = current_user
    # Create associated campaign for the team
    @team.campaign = @team.create_campaign
    # Pundit authorization
    authorize @team
    if @team.save
      redirect_to team_path(@team)
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
