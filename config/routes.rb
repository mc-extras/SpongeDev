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
end
