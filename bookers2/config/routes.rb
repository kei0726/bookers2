Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'home/about' => 'home#about'
  resources :books
  resources :users
  # resources :post_images, only: [:new, :create, :index, :show,]
end

