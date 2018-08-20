Rails.application.routes.draw do
  root to: 'pages#home'

  resources :courses do
    resources :lessons
  end
  get '/home', to: 'pages#home'
  get '/teacher', to: 'pages#teacher'
  get '/testvideo', to: 'pages#testvideo'

  resources :materials
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
