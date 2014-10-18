# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :plugin do
    name "Test plugin"
    body "This is a **super** cool test plugin."
    summary "A cool plugin."
    downloads 100
    views 1000
    allow_comments true
    license "MIT"
    custom_license ""
    custom_text ""
    primary_category "Admin Tools"
  end
end
