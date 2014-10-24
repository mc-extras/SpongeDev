Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  root 'home#index'
  get '/resources/terms' => 'resources#terms', as: 'terms'
  get '/resources/rules' => 'resources#rules', as: 'rules'
  resources :revisions
  resources :downloads
  resources :plugins do
    resources :comments
    resources :plugin_files, :path => 'files'
    resources :plugin_pages, :path => 'pages'
  end
  resources :users do
    get :avatar
    get :about
    get :notifications
  end
  post '/contact', :to => 'application#contact'
  resources :authentications
  get '/auth/link/server', :to => 'authentications#server', :as => 'mc_server'
  get '/auth/link', :to => 'authentications#server'
  post '/auth/link/server', :to => 'authentications#post_server', :as => 'mc_post_server'
  get '/auth/link/credentials', :to => 'authentications#credentials', :as => 'mc_credentials'
  post '/auth/link/credentials', :to => 'authentications#post_credentials', :as => 'mc_post_credentials'
end
