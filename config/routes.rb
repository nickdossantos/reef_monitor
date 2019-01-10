Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#homepage'
  get 'pages/tanks', to:'pages#tanks', as:'pages_tanks'

  get 'user/:id/dashboard/tank/:tank_id', to:'dashboard#show', as: 'dashboard'
  resources :users do
    resources :tanks do
      get '/raspberry_pi', to: 'tanks#raspberry_pi', as: 'raspberry_pi'
      resources :sensors do
        get '/graph', to: 'sensors#graph', as: 'graph'
        post '/date_ranges', to: 'sensors#graphs_with_date_range', as: 'graphs_with_date_range'
        get '/sensor_reading_data', to: 'sensors#sensor_reading_data', as: 'sensor_reading_data'
      end
      resources :readings
    end
  end

  namespace :api do
    post '/readings/:token', to: 'readings#create', constraints: { token: %r{[^\/]+} }
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
