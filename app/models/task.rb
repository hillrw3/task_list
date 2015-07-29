class Task < ActiveRecord::Base
  enum status: ['started', 'finished']

  belongs_to :task_list
end