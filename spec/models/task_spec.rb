require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of :name }

  it { should validate_presence_of :user_id }
  it { should belong_to :user }
end

