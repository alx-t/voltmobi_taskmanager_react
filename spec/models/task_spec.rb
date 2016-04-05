require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of :name }

  it { should validate_presence_of :user_id }
  it { should belong_to :user }

  context 'user scope' do
    let(:task_user) { create :user }
    let!(:user_tasks) { create_list :task, 2, user: task_user }
    let!(:tasks) { create_list :task, 3 }

    it 'valid count' do
      expect(Task.user_tasks(task_user).count).to eq 2
    end
  end
end

