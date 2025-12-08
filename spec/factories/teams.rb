FactoryBot.define do
  # Define a basic team factory
  factory :team do
    sequence(:name) { |n| "Team #{n}" }
    budget { 100_000 }
    association :user # Associate with a user created by the :user factory
    association :campaign # Associate with a campaign created by the :campaign factory
  end
end
