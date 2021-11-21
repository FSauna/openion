Rails.application.routes.draw do
  root to: 'homes#top'
  get '/about' => "homes#about" 
  get   'inquiry'         => 'inquiry#index'     
  post  'inquiry/confirm' => 'inquiry#confirm'   
  post  'inquiry/thanks'  => 'inquiry#thanks'
  get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
  patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  
end
