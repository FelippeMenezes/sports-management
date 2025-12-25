require 'rails_helper'

RSpec.describe User, type: :model do
  # Teste de sanidade: verifica se a factory consegue criar um usuário válido
  it 'has a valid factory' do
    user = build(:user)
    expect(user).to be_valid
  end

  # Validation tests (using shoulda-matchers)
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    # Devise validates email uniqueness by default, but requires an existing record in the database for testing.
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end
