class Web::Admin::TasksController < Web::ApplicationController
  before_action :authenticate
  before_action :load_task, only: [:destroy, :update]

  def index
    @tasks = Task.all.as_json
  end

  def destroy
    @task.destroy
    head :no_content
  end

  def create
    @task = Task.new(task_params.merge(user: current_user))
    if @task.save
      render json: @task, root: false
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task, root:false
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def load_task
    @task = Task.find_by(id: params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :user_id)
  end
end

