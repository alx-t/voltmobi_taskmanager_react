class Web::SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: session_params[:email])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      # TODO: add check roles
      # TODO: change path
      redirect_to members_tasks_path
    else
      @error_message = "Invalid email/password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end

