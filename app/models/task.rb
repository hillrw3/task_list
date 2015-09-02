class Task < ActiveRecord::Base
  enum status: ['started', 'finished']

  belongs_to :list
  has_one :user, through: :task_list
end