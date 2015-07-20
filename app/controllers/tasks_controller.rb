class TasksController < ApplicationController
  respond_to :json

  def index
    respond_with Task.all
  end

  def create
    task = Task.new(task_params)
    render json: TaskPresenter.new(task)
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end
end