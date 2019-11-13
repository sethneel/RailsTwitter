Rails.application.routes.draw do
  resources :users do
    resources :statuses
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get root to: 'users#home' 
  get '/home', to: 'users#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/login', to: 'sessions#create'
  patch '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  get '/users/:id/follow', to: 'users#follow'
  get 'users/:id/unfollow', to: 'users#unfollow'
end
