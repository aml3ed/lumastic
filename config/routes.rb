Rails.application.routes.draw do
  resources :activities
  root to: 'pages#home'

  resources :communities do
    member do
      put :add_user
      put :remove_user
      get :members
      get :discussions
    end
    resources :courses do
      resources :lessons do
        resources :comments, only: [:new, :create]
        collection do
          patch :sort
        end
        member do
          patch :count_ticket
          patch :vote
        end
      end
    end
  end

  resources :materials

  resources :discussions do
    resources :comments, only: [:new, :create]
  end

  resource :comments do
    member do
      patch :vote
    end
    resource :comments
  end

  # Devise session management

  devise_for :users,
             path_names: { sign_in: 'login', sign_out: 'logout' },
             controllers: { sessions: 'sessions', registrations: 'registrations', passwords: 'passwords' },
             skip: %i[invitations]

  resources :member, only: [:show, :index]

  # Admin Pages
  scope '/admin' do
    get '', to: 'admin#dashboard', as: 'admin_dashboard'
    get '/users', to: 'admin#admin_users', as: 'admin_users'
    match '/users/:id', to: 'admin#admin_user_destroy', :via => :delete, as: 'admin_user_destroy'
    get '/communities', to: 'admin#admin_communities', as: 'admin_communities'
    get '/courses', to: 'admin#admin_courses', as: 'admin_courses'
    get '/lessons', to: 'admin#admin_lessons', as: 'admin_lessons'
  end

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
