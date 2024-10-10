Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end

  get 'prototypes/index'
  resources :prototypes, only: [:new, :create, :show, :update, :edit, :destroy] do
    resources :comments, only: :create
end

  resources :users, only: :show

  root to: "prototypes#index"
end
