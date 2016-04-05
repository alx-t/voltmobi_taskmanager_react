class Task < ActiveRecord::Base
  belongs_to :user

  validates :name, :user_id, presence: true

  scope :user_tasks, -> (user_id) { where user_id: user_id }

  def as_json(options = {})
    TaskSerializer.new(self).as_json(root: false)
  end
end
