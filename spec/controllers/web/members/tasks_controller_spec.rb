require 'rails_helper'

RSpec.describe Web::Members::TasksController, type: :controller do
  let!(:user) { create :user }
  let!(:user_tasks) { create_list :task, 2, user: user }
  let!(:tasks) { create_list :task, 3 }

  describe 'GET #index' do
    before do
      session[:user_id] = user.id
      get :index
    end

    it 'populates an array of user tasks' do
      expect(assigns(:tasks)).to match_array(user_tasks.as_json)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end

