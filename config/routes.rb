Rails.application.routes.draw do
  resources :users do
    resources :statuses
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get root to: 'pages#home' 
  get '/home', to: 'pages#home'
end
