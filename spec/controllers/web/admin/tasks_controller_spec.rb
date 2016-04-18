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

  describe 'DELETE #destroy' do
    ###
    let!(:task) { create :task }

    it 'not authorized' do
      delete :destroy, id: task
      expect(response).to be_redirect
    end

    context 'authorized' do
      let(:subject) { delete :destroy, id: task }

      before { sign_in admin }

      it 'deletes the task' do
        expect { subject }.to change(Task, :count).by(-1)
      end

      it 'get success status' do
        expect(response).to be_success
      end
    end
  end

  describe 'POST #create' do
    it_behaves_like "HTTP Authenticable" do
      let(:http_method) { 'post' }
      let(:http_path) { 'create' }
    end

    context 'authorized' do
      before { sign_in admin }

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
end

