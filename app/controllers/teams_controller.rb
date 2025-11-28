class TeamsController < ApplicationController
  before_action :authenticate_user!
  def index
    @teams = current_user.teams
  end

  def show
    @team = current_user.teams.find(params[:id])
    @rival_teams = Team.where(user_id: nil)
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    @team.campaign = @team.create_campaign
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
