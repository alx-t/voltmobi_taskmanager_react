FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    email
    password '123456'
    password_confirmation '123456'
    role "user"
  end

  factory :invalid_user, class: 'User' do
    email
    password '123'
    password_confirmation '12345'
  end
end

