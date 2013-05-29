Shaipz::Application.routes.draw do
  opinio_model

  get "pricing/show"

  get "legal/show"

  get "about/show"

  devise_for :admins, :controllers => { :sessions => 'admin/sessions' }
  devise_for :users, :controllers => { :registrations => 'users/registrations', :sessions => 'users/sessions', :confirmations => 'users/confirmations', :omniauth_callbacks => 'users/omniauth_callbacks' }

  authenticated :user do
    root :to => 'streams#show'
  end

  namespace :admin do
    resources :projects
    resources :users
    resources :participations

    root :to => 'users#index'
  end

  resources :users do
    resources :reports
  end

  resources :projects do
    opinio
    resources :reports
  end

  resources :reports
  resources :participations
  resource :stream
  resource :friend_invitations
  resource :shaipz
  resource :change_password
  resource :how_it_works

  match '/howitworks' => 'how_it_works#show'
  match '/legal' => 'legal#show'
  match '/about' => 'about#show'
  match '/pricing' => 'pricing#show'

  root :to => 'home#index'
end
