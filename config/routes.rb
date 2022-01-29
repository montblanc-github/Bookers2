Rails.application.routes.draw do
  devise_for :users
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    collection do
      get "search" => "books#search"
    end
  end

  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
    get "search" => "users#search"
  end

  resources :groups do
    get "join"
		get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end

  get "message/:id", to: "messages#show", as: "message"
  resources :messages, only: [:create]
  get "/home/about" => "homes#about"
  get '/search'=> 'searches#search'
  root to: "homes#top"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
