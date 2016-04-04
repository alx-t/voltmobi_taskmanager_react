require 'rails_helper'

RSpec.describe Web::UsersController, type: :controller do

  describe 'GET #new' do
    before { get :new }

    it 'assigns a new User to @user' do
      expect(assigns(:user)).to be_a_new User
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do
      let(:subject) { post :create, user: attributes_for(:user) }

      it 'saves the new user in the database' do
        expect { subject }.to change(User, :count).by(1)
      end

      it 'redirects to members tasks view' do
        subject
        expect(response).to redirect_to members_tasks_path
      end
    end

    context 'with invalid attributes' do
      let(:invalid_subject) { post :create, user: attributes_for(:invalid_user) }

      it 'does not save the user' do
        expect { invalid_subject }.to_not change(User, :count)
      end

      it 'renders new view' do
        invalid_subject
        expect(response).to render_template :new
      end
    end
  end
end

