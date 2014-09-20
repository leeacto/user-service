FactoryGirl.define do
  factory :user do
    first_name 'First'
    last_name  'Last'
    sequence(:email_address) { |n| "test#{n}@test.com" }
  end
end
