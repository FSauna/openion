Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  root to: 'homes#about'
  
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  resources :posts
  resources :likes, only: [:create, :destroy]
  
end
