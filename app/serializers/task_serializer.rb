class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :task_created_at, :user_email

  def user_email
    object.user.email
  end

  def task_created_at
    object.created_at.strftime("%Y-%m-%dT%H:%M:%S.000Z")
  end
end

