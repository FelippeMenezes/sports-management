require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'associations' do
    it { should belong_to(:user).optional }
    it { should belong_to(:campaign) }
    it { should have_many(:players) }
  end

  # lets test the instance method #create_players_for_team
  describe '#create_players_for_team' do
    # We use 'create(:team)' from FactoryBot to have a real team saved in the test database.
    let(:team) { create(:team) }

    it 'creates 15 players for the team' do
      # The 'change' matcher checks if the block of code changes the number of records in the database.
      # We expect that calling the method will increase the total number of Players by 15.
      expect { team.create_players_for_team }.to change(Player, :count).by(15)
    end

    it 'associates the created players with the team' do
      team.create_players_for_team
      # We check if, after execution, the 'players' association of our team contains 15 players.
      expect(team.players.count).to eq(15)
    end
  end
end
