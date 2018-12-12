Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#homepage'
  get 'pages/tanks', to:'pages#tanks', as:'pages_tanks'

  get 'user/:id/dashboard', to:'dashboard#show', as: 'dashboard'
  resources :users do
    resources :tanks
    resources :sensors
    resources :readings
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
