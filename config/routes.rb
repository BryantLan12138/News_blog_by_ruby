Rails.application.routes.draw do
  root  'static_pages#home'
  get   'sessions/new'
  get   'users/new'
  get   '/news',    to: 'static_pages#news'
  get'/signup', to: 'users#new'
  post'/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/', to: 'users#index'
  
  resources :users
end
