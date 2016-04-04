Rails.application.routes.draw do

  scope module: 'web' do
    root to: 'tasks#index'
    resources :tasks, only: [:index]

    resources :users, only: [:new, :create]
    resources :sessions, only: [:new, :create, :destroy]
    get "logout", to: "sessions#destroy", as: "logout"
    get "login", to: "sessions#new", as: "login"
    get "signup", to: "users#new", as: "signup"

    namespace :admin do
      resources :tasks
    end

    namespace :members do
      resources :tasks
    end
  end
end

