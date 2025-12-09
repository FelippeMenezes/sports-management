class CampaignCreationJob < ApplicationJob
  queue_as :default
  # Includes progress monitoring methods (at, store, etc.) from the sidekiq-status gem.
  include Sidekiq::Status::Worker

  def perform(user_id, team_params)
    # We pass the job (self) to the service so it can report progress.
    # The service will also return the created team.
    team = CampaignCreatorService.new(user_id, team_params, self).call
    # We store the ID of the created team for the final redirection.
    store team_id: team.id if team
  end
end
