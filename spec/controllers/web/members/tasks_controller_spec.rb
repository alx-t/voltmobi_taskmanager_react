require 'rails_helper'

RSpec.describe Web::Members::TasksController, type: :controller do
  let!(:user) { create :user }
  let!(:user_tasks) { create_list :task, 2, user: user }
  let!(:tasks) { create_list :task, 3 }

  describe 'GET #index' do
    it_behaves_like "HTTP Authenticable" do
      let(:http_method) { 'get' }
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

  describe 'DELETE #destroy' do
    let!(:user_task) { create :task, user: user }
    let!(:task) { create :task }

    it 'no authorized' do
      delete :destroy, id: user_task
      expect(response).to be_redirect
    end

    context 'authorized' do
      before { sign_in user }

      context "user's task" do
        let(:subject) { delete :destroy, id: user_task }

        it 'deletes the task' do
          expect { subject }.to change(Task, :count).by(-1)
        end

        it 'get success status' do
          subject
          expect(response).to be_success
        end
      end

      context "other user's task" do
        let(:subject) { delete :destroy, id: task }

        it 'does not delete the task' do
          expect { subject }.to_not change(Task, :count)
        end

        it 'get unauthorized status' do
          subject
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'PATCH #update' do
    let!(:user_task) { create :task, user: user }
    let!(:task) { create :task }

    it 'no authorized' do
      patch :update, id: user_task.id, task: user_task
      expect(response).to be_redirect
    end

    context 'authorized' do
      before { sign_in user }

      context "user's task" do
        context 'with valid attributes' do
          before do
            patch :update, id: user_task, task: { name: 'new name', description: 'new description' }
          end

          it 'change task attributes' do
            user_task.reload
            expect(user_task.name).to eq 'new name'
            expect(user_task.description).to eq 'new description'
          end

          it 'get :unprocessable_entity status' do
            expect(response).to be_success
          end
        end

        context 'with invalid attributes' do
          before do
            @old_task = user_task
            patch :update, id: user_task, task: { name: nil, description: 'new description' }
          end

          it 'does not change task attributes' do
            user_task.reload
            expect(user_task.name).to eq @old_task.name
            expect(user_task.description).to eq @old_task.description
          end

          it 'get :unprocessable_entity status' do
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end

      context "other user's task" do
        before do
          @old_task = task
          patch :update, id: task, task: { name: 'new name', description: 'new description' }
        end

        it 'does not change task attributes' do
          task.reload
          expect(task.name).to eq @old_task.name
          expect(task.description).to eq @old_task.description
        end

        it 'get unauthorized status' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  def sign_in(user)
    session[:user_id] = user.id
  end
end

