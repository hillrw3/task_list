class Task < ActiveRecord::Base
  enum status: ['started', 'finished']
end