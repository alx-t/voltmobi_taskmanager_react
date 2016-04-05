class Web::Members::TasksController < Web::ApplicationController
  before_action :authenticate

  def index
    @tasks = Task.user_tasks(current_user).as_json
  end
end

