class Web::Admin::UsersController < Web::ApplicationController
  before_action :authenticate, only: [:index]

  def index
    if is_admin?
      render json: @users = User.select('id', 'email').as_json, root: false
    else
      render json: { errors: 'You can not have permission for this operation' }, status: :unauthorized
    end
  end

  private

  def is_admin?
    current_user && (current_user.role == 'admin')
  end
end
