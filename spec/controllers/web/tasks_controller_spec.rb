require 'rails_helper'

RSpec.describe Web::TasksController, type: :controller do
  let(:task) { create :task }

  describe "GET #index" do
    let!(:tasks) { create_list :task, 2 }

    before { get :index }

    it 'populates an array of all tasks' do
      expect(assigns(:tasks)).to match_array(tasks.as_json)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end

