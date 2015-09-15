class ListsController < ApplicationController
  before_filter :set_list, only: [:destroy, :email]
  attr_accessor :list
  respond_to :json

  def index
    respond_with presented_lists
  end

  def create
    new_list = List.create(list_attributes)
    render json: new_list
  end

  def destroy
    List.destroy(list)
    render json: 200
  end

  def email
    recipients = params['recipients']
    ListMailer.list(recipients, list).deliver
    render json: 200
  end

  private

  def list_attributes
    attrs = params.require(:list).permit(:name)
    attrs.merge(user_id: current_user.id)
  end

  def presented_lists
    lists = current_user.lists.map { |list| ListPresenter.new(list) }
    lists
  end

  def set_list
    @list ||= List.find(params[:id]) if params[:id]
  end
end