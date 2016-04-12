class Web::Members::TasksController < Web::ApplicationController
  before_action :authenticate
  before_action :load_task, only: [:destroy]

  def index
    @tasks = Task.user_tasks(current_user).as_json
  end

  def create
    @task = Task.new(task_params.merge(user: current_user))
    if @task.save
      render json: @task, root: false
    else
      render json: @task.errors, status: :unprocessable_entity, text: 'test text'
    end
  end

  def destroy
    if valid_user?
      @task.destroy
      head :no_content
    else
      render json: { errors: 'You can not have permission for this operation' }, status: :unauthorized
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def load_task
    @task = Task.find_by(id: params[:id])
  end

  def valid_user?
    current_user && (current_user.id == @task.user_id)
  end
end

