SignatureMovement::Application.routes.draw do
  root 'home#index'


  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks', :sessions => "users/sessions", :registrations => "users/registrations", :passwords => "users/passwords" }, :path_names => { :sign_up => 'new', :sign_in => 'login', :sign_out => 'logout' } do
    get 'login', to: 'users::Sessions#new'
    get 'logout', to:  'users::Sessions#destroy'
  end

  devise_for :admins,
             class_name: "User",
             skip: [:sessions, :registrations, :passwords, :omniauth_callbacks]


  devise_scope :admin do
    # ---- Sessions ----
    get    'admins/login',  to: 'admins/sessions#new',     as: :new_admin_session
    post   'admins/login',  to: 'admins/sessions#create',  as: :admin_session
    delete 'admins/logout', to: 'admins/sessions#destroy', as: :destroy_admin_session

    # ---- Registrations ----
    get    'admins/sign_up',    to: 'users/registrations#new',    as: :new_admin_registration
    post   'admins',             to: 'users/registrations#create', as: :admin_registration
    get    'admins/edit',        to: 'users/registrations#edit',   as: :edit_admin_registration
    patch  'admins',             to: 'users/registrations#update'
    put    'admins',             to: 'users/registrations#update'
    delete 'admins',             to: 'users/registrations#destroy'

    # ---- Passwords ----
    get   'admins/password/new',    to: 'users/passwords#new',    as: :new_admin_password
    post  'admins/password',        to: 'users/passwords#create', as: :admin_password
    get   'admins/password/edit',   to: 'users/passwords#edit',   as: :edit_admin_password
    patch 'admins/password',        to: 'users/passwords#update'
    put   'admins/password',        to: 'users/passwords#update'

    # ---- Confirmations (optional, 이메일 확인 등) ----
    get   'admins/confirmation/new',  to: 'users/confirmations#new',    as: :new_admin_confirmation
    post  'admins/confirmation',      to: 'users/confirmations#create', as: :admin_confirmation
    get   'admins/confirmation',      to: 'users/confirmations#show'
  end


  get 'home', to: 'home#index'




  scope 'admin', module: 'admin', as: 'admin' do
    root to: 'home#index'
    resources :users, :articles, :improve, :faq_categories, :faqs, :proposes, :compliment_categories, :compliments, :report_categories, :reports, :notices, :ad_models, :banks
  end

  resources :users do
    member do
      put 'like', to: 'users#upvote'
      put 'dislike', to: 'users#downvote'
    end
  end

  resources :reports do
    member do
      put 'like', to: 'reports#upvote'
      put 'dislike', to: 'reports#downvote'
    end
  end

  resources :compliments do
    member do
      put 'like', to: 'compliments#upvote'
      put 'dislike', to: 'compliments#downvote'
    end
  end

  resources :ad_models do
    member do
      put 'like', to: 'ad_models#upvote'
      put 'dislike', to: 'ad_models#downvote'
    end
  end

  resources :comments, only: [:create, :destroy]

  resources :articles, :intro, :improve, :sitemap, :faqs, :faq_categories, :proposes, :notices, :galleries
  get 'sign', to: 'users#sign'
  get 'kbsmind', to: 'home#kbsmind'
  get 'feed', to: 'home#feed'
  get 'privacy', to: 'home#privacy'
  get 'user-delete-confirm', :to=>'users#delete_confirm', as: 'delete_confirm_user'
  get 'users/add_new_comment/:id', to: 'users#new_comment', as: 'new_comment_to_users'
  post 'users/add_new_comment', to: 'users#create_comment', as: 'create_comment_to_users'


end
