class TasksController < ApplicationController
  respond_to :json

  def create
    task = Task.new(task_params)
    task.save
    render nothing: true
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end
end