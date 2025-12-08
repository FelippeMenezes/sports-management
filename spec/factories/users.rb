FactoryBot.define do
  # Define a basic user factory
  factory :user do
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password" }
  end
end
