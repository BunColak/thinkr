Rails.application.routes.draw do

  get 'password_reset/new'

  get 'password_reset/edit'

  root 'static_pages#home'

  get 'static_pages/home'

  get '/help', to: 'static_pages#help'

  get '/about', to: 'static_pages#about'

  get '/contact', to: 'static_pages#contact'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers, :likings
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:edit, :update, :create, :new]
  resources :thoughts, only: [:create, :destroy] do
    member do
      get :likes
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
