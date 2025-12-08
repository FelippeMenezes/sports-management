require 'rails_helper'

RSpec.describe CampaignCreatorService, type: :service do
  describe '#call' do
    # Use 'let' to define a team in memory that will be used in the tests.
    # It is not saved to the database yet.
    let(:team) { build(:team, campaign: nil) } # Use a factory to build a team without a campaign

    # 'subject' is a shorthand to refer to the object we are testing.
    subject(:service_call) { described_class.new(team).call }

    it 'creates a new Campaign' do
      # 'expect { ... }.to change { Model.count }.by(x)' is a powerful way
      # to check if the number of records in the database has changed.
      expect { service_call }.to change(Campaign, :count).by(1)
    end

    it 'associates the campaign with the team' do
      service_call
      # 'reload' ensures we are getting the most recent version of the object from the database.
      expect(team.reload.campaign).to be_present
      expect(team.campaign.name).to eq("#{team.name.capitalize} Campaign")
    end

    it 'creates 9 rival teams' do
      # The main team + 9 rivals = 10 teams in total for the campaign.
      expect { service_call }.to change(Team, :count).by(10)
    end

    it 'creates players for the main team' do
      service_call
      expect(team.reload.players.count).to eq(15) # 15 players for the main team
    end

    it 'creates players for all rival teams' do
      # We expect 10 teams (1 main + 9 rivals) to be created, each with 15 players.
      expect { service_call }.to change(Player, :count).by(10 * 15)
    end
  end
end
