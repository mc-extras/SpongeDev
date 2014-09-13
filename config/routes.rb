Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  mount Forem::Engine, :at => '/forums'
  get '/resources/terms' => 'resources#terms', as: 'terms'
  get '/resources/rules' => 'resources#rules', as: 'rules'
  resources :revisions
  get '/user/:user' => 'application#profile', as: 'profile'
  resources :downloads
end
