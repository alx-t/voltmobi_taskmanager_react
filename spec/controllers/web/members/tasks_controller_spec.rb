require 'rails_helper'

RSpec.describe Web::Members::TasksController, type: :controller do
  let!(:user) { create :user }
  let!(:user_tasks) { create_list :task, 2, user: user }
  let!(:tasks) { create_list :task, 3 }

  describe 'GET #index' do
    it_behaves_like "HTTP Authenticable" do
      let(:http_path) { 'index' }
    end

    context 'authorized' do
      before do
        sign_in(user)
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

  describe 'POST #create' do
    it_behaves_like "HTTP Authenticable" do
      let(:http_method) { 'post' }
      let(:http_path) { 'create' }
    end

    context 'authorized' do
      before { sign_in user }

      context 'with valid attributes' do
        let(:subject) { post :create, task: attributes_for(:task) }

        it 'saves the new task in the database' do
          expect { subject }.to change(Task, :count).by(1)
        end

        it 'set success status' do
          subject
          expect(response).to be_success
        end
      end

      context 'with invalid attributes' do
        let(:subject) { post :create, task: attributes_for(:invalid_task) }

        it 'does not save the task' do
          expect { subject }.to_not change(Task, :count)
        end

        it 'set unprocessable_entity status' do
          subject
          expect(response).to have_http_status(422)
        end
      end
    end
  end

  def sign_in(user)
    session[:user_id] = user.id
  end
end

