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
  post '/contact', :to => "application#contact"
  if Rails.env.production?
   get '404', :to => 'errors#page_not_found'
   get '422', :to => 'errors#server_error'
   get '500', :to => 'errors#server_error'
  end
end
