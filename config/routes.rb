Rails.application.routes.draw do
  devise_for :users
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
  resources :users
  post '/contact', :to => 'application#contact'
  resources :authentications
  get '/auth/link/server', :to => 'authentications#server', :as => 'mc_server'
  get '/auth/link/credentials', :to => 'authentications#credentials', :as => 'mc_credentials'
  post '/auth/link/credentials/post', :to => 'authentications#post_mc', :as => 'mc_post_credentials'
end
