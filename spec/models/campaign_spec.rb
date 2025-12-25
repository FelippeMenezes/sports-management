require 'rails_helper'

RSpec.describe Campaign, type: :model do
  it 'has a valid factory' do
    expect(build(:campaign)).to be_valid
  end

  describe 'associations' do
    it { should have_many(:teams) }
  end
end
