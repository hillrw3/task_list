class TasksController < ApplicationController
  respond_to :json

  def index
    respond_with Task.all.each { |task|  TaskPresenter.new(task) }
  end

  def create
    task = Task.new(task_params)
    task.save
    render json: TaskPresenter.new(task)
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    render nothing: true
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end
end