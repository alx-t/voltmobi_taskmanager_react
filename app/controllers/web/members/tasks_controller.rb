class Web::Members::TasksController < Web::ApplicationController
  before_action :authenticate
  before_action :load_task, only: [:destroy, :update, :show]
  before_action :verify_user, only: [:destroy, :update]

  def index
    @tasks = Task.user_tasks(current_user).as_json
  end

  def create
    @task = Task.new(task_params.merge(user: current_user))
    if @task.save
      render json: @task, root: false
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    if @task.update(task_params)
      render json: @task, root:false
    else
      render json: { errors: @task.errors.full_messages },
              status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def load_task
    @task = Task.find_by(id: params[:id])
  end

  def verify_user
    unless valid_user?
      render json: { errors: 'You can not have permission for this operation' },
              status: :unauthorized
    end
  end

  def valid_user?
    current_user && (current_user.id == @task.user_id)
  end
end

