require 'rails_helper'

RSpec.describe Web::SessionsController, type: :controller do
  let!(:user) { create :user }

  describe 'GET #new' do
    it 'renders new view' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before { post :create, email: user.email, password: '123456' }

      it 'creates a user session' do
        expect(session[:user_id]).to eq user.id
      end

      it 'redirects to to members tasks view' do
        expect(response).to redirect_to members_tasks_path
      end
    end

    context 'with invalid attributes' do
      before { post :create, email: user.email, password: 'invalid' }

      it 'does not create a user session' do
        expect(session[:user_id]).to be_nil
      end

      it 'renders new view' do
        expect(response).to render_template :new
      end

      it 'assigns error message' do
        expect(assigns(:error_message)).to include "Invalid email/password"
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      post :create, email: user.email, password: '123456'
      expect(session[:user_id]).to eq user.id
      delete :destroy
    end

    it 'destroys user session' do
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to root path' do
      expect(response).to redirect_to root_path
    end
  end
end

