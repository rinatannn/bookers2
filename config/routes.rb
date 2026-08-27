Rails.application.routes.draw do
  root to: "homes#top"

  get "home/about", to: "homes#about", as: "about"

  get "/users/sign_in", to: "sessions#new", as: :new_user_session
  get "/session/new", to: "sessions#new", as: :new_session
  post "/users/sign_in", to: "sessions#create", as: :user_session

  get "/users/sign_out", to: "sessions#destroy", as: :destroy_user_session

  get "/users/sign_up", to: "users#registrations", as: :new_user_registration
  get "/users/sign_up", to: "users#registrations", as: :new_user

  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :create, :edit, :update] do
  resource :relationships, only: [:create, :destroy]

  member do
    get :followings
    get :followers
  end
end
end