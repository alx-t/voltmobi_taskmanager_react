class Web::Admin::TasksController < Web::ApplicationController
  before_action :authenticate
  before_action :load_task, only: [:destroy]

  def index
    @tasks = Task.all.as_json
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private

  def load_task
    @task = Task.find_by(id: params[:id])
  end
end
