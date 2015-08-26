Rails.application.routes.draw do

  root to: 'home#index'

  resource :landing, only: :show
  get 'users/sign_in' => 'landing#show'

  resources :tasks, only: [:create, :index, :destroy]
  patch '/tasks/:id/finish' => 'tasks#finish'
  patch '/tasks/:id/restart' => 'tasks#restart'

  resources :users, only: [:new, :create]
  devise_for :users
end
