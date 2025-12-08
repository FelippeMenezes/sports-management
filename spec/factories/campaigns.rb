FactoryBot.define do
  # Define a basic campaign factory
  factory :campaign do
    sequence(:name) { |n| "Campaign #{n}" }
  end
end
