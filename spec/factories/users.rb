

FactoryGirl.define do
  pw = Faker::Internet.password

  factory :user do
    name Faker::Name.first_name
    email Faker::Internet.email
    password pw
    password_confirmation pw
    role :standard
    confirmed_at Time.now
  end
end
