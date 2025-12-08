class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  skip_after_action :verify_authorized, only: [ :home ]

  def home
  end

  def dashboard
    # Find the team based on the ID passed in the URL (ex: /teams/1/dashboard)
    @team = Team.find(params[:id])
    # Pundit authorization for dashboard action
    authorize @team, :dashboard?
    # Here you can add any statistics or data you want to display on the dashboard
    # @matches_played = @team.matches.count
    # @championships_won = @team.championships.where(status: 'won').count
  end
end
