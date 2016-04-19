require 'rails_helper'

RSpec.describe Web::Admin::UsersController, type: :controller do

  describe 'GET #index' do
    let!(:users) { create_list :user, 3 }

    it_behaves_like "HTTP Authenticable" do
      let(:http_method) { 'get' }
      let(:http_path) { 'index' }
    end

    context 'authorized' do
      context 'get list of users if admin' do
        let!(:admin) { create :user, role: 'admin' }

        before do
          sign_in admin
          get :index
        end

        it 'populates an array of users' do
          expect(assigns(:users)).to match_array ((users << admin).inject([]) { |res, u| res << {id: u.id, email: u.email} }).as_json
        end

        it 'get success status' do
          expect(response).to be_success
        end
      end

      context 'get unauthorized if not admin' do
        let!(:user) { create :user }

        before do
          sign_in user
          get :index
        end

        it 'get unauthorized status' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
