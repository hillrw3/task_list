class List < ActiveRecord::Base
  has_many :tasks
  belongs_to :user

  validates_presence_of :user_id

  def started_tasks
    tasks.where(status: 0)
  end

  def finished_tasks
    tasks.where(status: 1)
  end
end