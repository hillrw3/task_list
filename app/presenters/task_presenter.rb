class TaskPresenter < Struct.new(:task)
  def as_json(*_)
    {
      id: task.id,
      description: task.description,
      status: task.status
    }
  end
end