SignatureMovement::Application.routes.draw do
  root 'home#index'

  if Rails.env.production?
    mount LetsEncrypt::Engine => '/.well-known'
  end

  devise_for :admins, :controllers => {:sessions => "admins/sessions", :registrations => "admins/registrations"}, :path_names => {:sign_up => 'new', :sign_in => 'login', :sign_out => 'logout'} do
    get 'edit', :to => 'admins::Registrations#edit'
    get 'login', :to => 'admins::Sessions#new'
    get 'logout', :to => 'admins::Sessions#destroy'
  end

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks', :sessions => "users/sessions", :registrations => "users/registrations", :passwords => "users/passwords" }, :path_names => { :sign_up => 'new', :sign_in => 'login', :sign_out => 'logout' } do
    get 'login', to: 'users::Sessions#new'
    get 'logout', to:  'users::Sessions#destroy'
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

  resources :models do
    member do
      put 'like', to: 'models#upvote'
      put 'dislike', to: 'models#downvote'
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

  get 'home', to: 'home#index'
  scope 'admin', module: 'admin', as: 'admin' do
    get '/' => 'admin_home#index'
    resources :users, :articles, :improve, :faq_categories, :faqs, :proposes, :compliment_categories, :compliments, :report_categories, :reports, :notices, :models, :banks
  end
end
