class ListsController < ApplicationController
  respond_to :json

  def index
    list = current_user.list
    respond_with ListPresenter.new(list)
  end
end