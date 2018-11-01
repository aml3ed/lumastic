Rails.application.routes.draw do
  root to: 'pages#home'

  resources :courses do
    get '/new/:community_id', to: "courses#new"
    resources :lessons do
      collection do
        patch :sort
      end
      member do
        patch :count_ticket
      end
    end
  end

  resources :materials

  resources :communities do
    member do
      put :add_user
      put :remove_user
      get :members
      get :courses
      get :discussions
    end
  end

  resources :discussions do
    resources :comments, only: [:new, :create]
  end

  resource :comments do
    resource :comments
  end


  # Devise session management

  devise_for :users,
             path_names: { sign_in: 'login', sign_out: 'logout' },
             controllers: { sessions: 'sessions', registrations: 'registrations', passwords: 'passwords' },
             skip: %i[invitations]

  # Static Pages

  get '/home', to: 'pages#home'
  get '/legal', to: 'pages#legal'
  get '/join', to: 'pages#join'
  get '/feedback', to: 'pages#feedback'
  get '/search', to: 'pages#search'
  get '/teacher', to: 'pages#teacher'
  get '/testvideo', to: 'pages#testvideo'
  match "/404", :to => "pages#not_found", :via => :all
  match "/500", :to => "pages#internal_server_error", :via => :all

end
