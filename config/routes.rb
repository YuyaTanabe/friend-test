Rails.application.routes.draw do

  devise_for :users


  root to: 'home#top' #ルートパス

  get "users/clip" => "users#clip"

  resources :users
  	resources :friendships, only: [:new, :create, :index, :destroy] do
  end

  resources :locations


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
