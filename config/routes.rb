Rails.application.routes.draw do
  # resources :users
  devise_for :users
  
  get "/home"          => "home#index"
  # get "users/sign_out" => "devise/sessions#destroy"
  
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
    # get "/users/sign_in" => "devise/sessions#new"
  end

  post "/new_test_account", to: "tasks#new_test_account", as: "new_test_account"

  resources :tasks
  resources :searches

  root to: "home#index"
end
