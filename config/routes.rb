Rails.application.routes.draw do
  
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions' }

  root to: 'homes#top'
  get '/about' => "homes#about"
  get 'search' => 'microposts#search'
  get   'inquiry'         => 'inquiry#index'
  post  'inquiry/confirm' => 'inquiry#confirm'
  post  'inquiry/thanks'  => 'inquiry#thanks'
  get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
  patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:index, :create, :destroy]
  resources :comments, only: [:create, :destroy]

end
