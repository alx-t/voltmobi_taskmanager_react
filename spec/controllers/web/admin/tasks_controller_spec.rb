require 'rails_helper'

RSpec.describe Web::Admin::TasksController, type: :controller do
  let!(:admin) { create :user, role: 'admin' }
  let!(:tasks) { create_list :task, 3 }

  describe 'GET #index' do

    it 'not authorized' do
      get :index
      expect(response).to be_redirect
    end

    context 'authorized' do
      before do
        sign_in admin
        get :index
      end

      it 'populates an array of all tasks' do
        expect(assigns(:tasks)).to match_array(tasks.as_json)
      end

      it 'renders index view' do
        expect(response).to render_template :index
      end
    end
  end
end

