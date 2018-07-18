Rails.application.routes.draw do
  root to: 'pages#home'

  resources :courses do
    resources :lessons
  end
  get '/home', to: 'pages#home'
  get '/teacher', to: 'pages#teacher'

  resources :materials

  #
  # Devise session management
  #
  devise_for :users,
             path_names: { sign_in: 'login', sign_out: 'logout' },
             controllers: { sessions: 'sessions', registrations: 'registrations' },
             skip: %i[invitations passwords]
  # as :user do
  #   get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
  #   put 'users' => 'devise/registrations#update', :as => 'user_registration'
  # end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
