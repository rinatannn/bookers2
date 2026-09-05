Rails.application.routes.draw do
  root to: "homes#top"

  get "home/about", to: "homes#about", as: "about"

  # ログイン・ログアウト
  get "/users/sign_in", to: "sessions#new", as: :new_user_session
  get "/session/new", to: "sessions#new", as: :new_session
  post "/users/sign_in", to: "sessions#create", as: :user_session
  get "/users/sign_out", to: "sessions#destroy", as: :destroy_user_session

  # ゲストログイン
  post "/guest_sign_in", to: "guest_sessions#create", as: :guest_sign_in

  # 新規登録
  get "/users/sign_up", to: "users#registrations", as: :new_user_registration
  get "/users/sign_up", to: "users#registrations", as: :new_user

  # 検索
  get "/search", to: "searches#search", as: :search

  resources :notifications, only: [:update]
  
  # 投稿
  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  # グループ
  resources :groups do
    resource :group_users, only: [:create, :destroy]

    member do
      get :new_mail
      post :send_mail
    end
  end

  # ユーザー
  resources :users, only: [:index, :show, :create, :edit, :update] do
    resource :relationships, only: [:create, :destroy]

    member do
      get :followings
      get :followers
      get :search_count
    end

    resources :rooms, only: [:create]
  end

  # DM
  resources :rooms, only: [:show] do
    resources :messages, only: [:create]
  end
end