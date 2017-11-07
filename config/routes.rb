Rails.application.routes.draw do
  root 'books#index'
  devise_for :users
  resources :categories
  resources :authors
  resources :books do
  	resources :reviews
  end
end
