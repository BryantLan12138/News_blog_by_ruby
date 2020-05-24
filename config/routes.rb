Rails.application.routes.draw do
  root  'static_pages#home'
  get   'sessions/new'
  get   'users/new'
  get   'users/index'

  get   '/news',    to: 'static_pages#news'
  get   '/signup', to: 'users#new'
  post  '/signup', to: 'users#create'
  get   '/login', to: 'sessions#new'
  post  '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/post/new', to: 'posts#new'
  post '/post/new', to: 'posts#create'
  resources :users
end
