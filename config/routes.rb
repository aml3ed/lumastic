Rails.application.routes.draw do
  resources :courses do
    resources :lessons
  end
  root to: 'pages#home'

  resources :materials
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
