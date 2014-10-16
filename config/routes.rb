Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get '/resources/terms' => 'resources#terms', as: 'terms'
  get '/resources/rules' => 'resources#rules', as: 'rules'
  resources :revisions
  resources :downloads
  resources :plugins do
    resources :comments
    resources :plugin_files, :path => "files"
    resources :plugin_pages, :path => "pages"
  end
  resources :users
  post '/contact', :to => "application#contact"
  get '/mc/link_account', :to => "application#link_mc", :as => 'mc_account'
  post '/post_mc', :to => "application#post_mc", :as => "mc_post"
end
