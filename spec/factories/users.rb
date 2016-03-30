FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    email
    password_digest "MyString"
    role "MyString"
  end
end
