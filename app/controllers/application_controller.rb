class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization

  # Pundit: allow-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Pundit: rescue from not authorized error
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  private

  # Pundit: allow-list approach
  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)/
  end

  protected

  # Override Devise method to set the path after sign in
  def after_sign_in_path_for(resource)
    teams_path
  end
end
