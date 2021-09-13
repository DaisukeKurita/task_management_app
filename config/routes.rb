Rails.application.routes.draw do
  root 'tasks#index'
  # get 'task/index'
  resources :tasks
end
