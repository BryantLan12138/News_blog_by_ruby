Rails.application.routes.draw do
  get 'users/new'
  root 'static_pages#home'
  get '/news', to: 'static_pages#news'
  get  '/signup',  to: 'users#new'
  resources :users
end
