Rails.application.routes.draw do
  root 'sessions#new'
  resources :tasks
  resources :users, only: [:new, :create, :show, :index]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users
  end
end
