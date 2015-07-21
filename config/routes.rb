Rails.application.routes.draw do

  root 'home#index'

  resources :tasks, only: [:create, :index, :destroy]
  patch '/tasks/:id/finish' => 'tasks#finish'
end
