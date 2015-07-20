class TaskPresenter < Struct.new(:task)
  def as_json(*_)
    {
      description: task.description
    }
  end
end