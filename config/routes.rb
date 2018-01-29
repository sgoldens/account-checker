Rails.application.routes.draw do
  devise_for :views
  devise_for :controllers
  devise_for :users
  
  get "/home"          => "home#index"
  
  devise_scope :user do
    devise_for :users, only: []
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  # Automation tasks
  post "/new_test_account", to: "tasks#new_test_account", as: "new_test_account"
  post "/sign_in_as_new_test_account", to: "tasks#sign_in_as_new_test_account", as: "sign_in_as_new_test_account"
  post "/remove_latest_test_account", to: "tasks#remove_latest_test_account", as: "remove_latest_test_account"

  resources :users
  resources :tasks
  resources :searches

  root to: "home#index"
end
