Rails.application.routes.draw do
  resources :labels
  resources :middles, only:[:create, :destroy]
  namespace :admin do
    get 'users/index'
    get 'users/new'
    get 'users/show'
    get 'users/edit'
  end
  get 'sessions/new'
  get '/', to: 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only:[:new, :create, :destroy]

  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
