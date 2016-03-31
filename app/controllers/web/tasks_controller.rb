class Web::TasksController < Web::ApplicationController

  def index
    @tasks = Task.all.as_json
  end
end

