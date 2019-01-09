Rails.application.routes.draw do

  devise_for :users


    root to: 'home#top' #ルートパス

    # get "users/:id" => "users#show", as: :mypage #ログイン中はマイページ

    get '/top' => 'home#top'



  resources :users
  	resources :friendships, only: [:new, :create, :index, :destroy] do
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
