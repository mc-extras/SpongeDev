# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "test@example.com"
    password "examplepass"
    password_confirmation { "examplepass" }
    username "exampleuser"
  end
end