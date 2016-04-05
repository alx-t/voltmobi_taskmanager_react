class Web::ApplicationController < ApplicationController

  private

  helper_method :current_user, :signed_in?

  def authenticate
    unless signed_in?
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    current_user.present?
  end
end

