require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of :email }
  it do
    create :user
    should validate_uniqueness_of(:email).case_insensitive
  end
  it { should allow_value('valid@test.com').for(:email) }
  it { should_not allow_value('invalid@test').for(:email) }
end

