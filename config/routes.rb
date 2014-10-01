Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get '/resources/terms' => 'resources#terms', as: 'terms'
  get '/resources/rules' => 'resources#rules', as: 'rules'
  resources :revisions
  get '/user/:user' => 'application#profile', as: 'profile'
  resources :downloads
  resources :plugins do
    resources :plugin_files, :path => "files"
  end
end
