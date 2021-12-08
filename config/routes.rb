Rails.application.routes.draw do
  devise_for :users
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:show, :index, :edit, :update]
  get "/home/about" =>"homes#about"
  root to: "homes#top"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
