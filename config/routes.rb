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

  resources :users do
    member do
      get 'my_profile', to: 'users#my_profile'
      get 'my_posts', to: 'users#my_posts'
      get 'my_comments', to: 'users#my_comments'
      get 'settings', to: 'users#settings'
      get 'commentstome', to: 'users#commentstome'
    end
  end

  get '/selected_topics', to: 'posts#selectedPost'
  resources :users
  resources :posts do
    member do
      get :selectedPost
    end
  end
end
