class Web::Members::TasksController < Web::ApplicationController
  before_action :authenticate

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

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end

