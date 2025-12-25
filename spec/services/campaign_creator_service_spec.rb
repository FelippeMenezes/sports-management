require 'rails_helper'

RSpec.describe CampaignCreatorService, type: :service do
  describe '#call' do
    # Created a real user in the database for testing purposes.
    let(:user) { create(:user) }
    # Generate valid attributes for a team (e.g., { name: "Team 1", budget: 100000 })
    let(:team_params) { attributes_for(:team).except(:user, :campaign) }

    # Instantiated the service with the correct arguments: user_id and team_params.
    subject(:service_call) { described_class.new(user.id, team_params).call }

    it 'creates a new Campaign' do
      # 'expect { ... }.to change { Model.count }.by(x)' is a powerful way
      # to check if the number of records in the database has changed.
      expect { service_call }.to change(Campaign, :count).by(1)
    end

    it 'associates the campaign with the team' do
      created_team = service_call
      expect(created_team.campaign).to be_present
      expect(created_team.campaign.name).to eq("#{created_team.name.capitalize} Campaign")
    end

    it 'creates 9 rival teams' do
      # 1 main team + 9 rivals = 10 teams in total
      expect { service_call }.to change(Team, :count).by(10)
    end

    it 'creates players for the main team' do
      created_team = service_call
      expect(created_team.players.count).to eq(15)
    end

    it 'creates players for all rival teams' do
      # We expect 10 teams (1 main + 9 rivals) to be created, each with 15 players.
      expect { service_call }.to change(Player, :count).by(10 * 15)
    end
  end
end
