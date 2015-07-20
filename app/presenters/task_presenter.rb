class TaskPresenter < Struct.new(:task)
  def as_json(*_)
    {
      id: task.id,
      description: task.description
    }
  end
end