Rails.application.routes.draw do

  scope module: 'web' do
    root to: 'tasks#index'
    resources :tasks
  end
end

