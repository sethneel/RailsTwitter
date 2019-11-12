Rails.application.routes.draw do
  resources :users do
    resources :statuses
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get root to: 'pages#home' 
  get '/home', to: 'pages#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/login', to: 'sessions#create'
  patch '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
end
