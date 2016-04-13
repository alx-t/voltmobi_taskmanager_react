class Web::Admin::TasksController < Web::ApplicationController
  before_action :authenticate

  def index
    @tasks = Task.all.as_json
  end
end
