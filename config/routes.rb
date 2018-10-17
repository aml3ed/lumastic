Rails.application.routes.draw do
  root to: 'pages#home'

  resources :courses do
    get '/new/:community_id', to: "courses#new"
    resources :lessons do
      collection do
        patch :sort
      end
      member do
        get 'view'
        patch :count_ticket
      end
    end
  end
  get '/home', to: 'pages#home'
  get '/teacher', to: 'pages#teacher'
  get '/testvideo', to: 'pages#testvideo'

  resources :materials

  resources :communities do
    member do
      put :add_user
      put :remove_user
    end
  end
  #
  # Devise session management
  #
  devise_for :users,
             path_names: { sign_in: 'login', sign_out: 'logout' },
             controllers: { sessions: 'sessions', registrations: 'registrations', passwords: 'passwords' },
             skip: %i[invitations]
  # as :user do
  #   get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
  #   put 'users' => 'devise/registrations#update', :as => 'user_registration'
  # end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
