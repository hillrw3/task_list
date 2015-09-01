Rails.application.routes.draw do

  root to: 'home#index'

  resource :session, only: :create

  resources :tasks, only: [:create, :index, :destroy]
  patch '/tasks/:id/finish' => 'tasks#finish'
  patch '/tasks/:id/restart' => 'tasks#restart'

  resources :users, only: [:new, :create]
  devise_for :users, controllers: { sessions: 'sessions'}
end
