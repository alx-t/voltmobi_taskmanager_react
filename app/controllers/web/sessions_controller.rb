class Web::SessionsController < Web::ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: session_params[:email])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_user
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

  def redirect_user
    case current_user.role
    when 'user'
      redirect_to members_tasks_path
    when 'admin'
      redirect_to admin_tasks_path
    end
  end
end

