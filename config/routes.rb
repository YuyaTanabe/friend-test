Rails.application.routes.draw do


  get 'admins/show'
  devise_for :admins, controllers: {
        sessions: "admins/sessions",
        passwords: "admins/paswwords",
        registrations: "admins/registrations"
  }
  devise_for :users, controllers: {
        sessions: "users/sessions",
        passwords: "users/passwords",
        registrations: "users/registrations"
  }

  # devise_for :admins
  # devise_for :users

  # resources :admins


  root to: 'home#top' #ルートパス

  get "users/clip" => "users#clip"

  resources :users
  	resources :friendships, only: [:new, :create, :index, :destroy] do
  end

  resources :locations

  resources :messages, only: [:create, :show, :index, :edit, :update, :destroy]

  resources :rooms



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
