class Task < ActiveRecord::Base
  belongs_to :user
  validates :name, :user_id, presence: true

  def as_json(options = {})
    TaskSerializer.new(self).as_json(root: false)
  end
end
