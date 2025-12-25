FactoryBot.define do
  factory :user do
    #Use Faker to generate random and unique data.
    email { Faker::Internet.unique.email }
    password { 'password123' }
    password_confirmation { 'password123' }
  end
end
