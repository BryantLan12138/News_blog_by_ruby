Rails.application.routes.draw do
  root 'static_pages#home'
  get '/news', to: 'static_pages#news'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
