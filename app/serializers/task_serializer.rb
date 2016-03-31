class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :user_email

  def user_email
    object.user.email
  end
end

