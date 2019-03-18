Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#homepage'
  get 'pages/tanks', to:'pages#tanks', as:'pages_tanks'

  get 'user/:id/dashboard/tank/:tank_id', to:'dashboard#show', as: 'dashboard'
  get 'users/1/new', to: 'registrations#new'
  post 'users/1/create', to: 'registrations#create', as: 'create_user_registration'
  resources :users do
    get 'turn_off_relay', to:'users#turn_off_relay', as: 'turn_off_relay'
    get 'turn_on_relay', to:'users#turn_on_relay', as: 'turn_on_relay'
    get 'notifications', to:'users#notifications', as: 'notifications'
    #get 'generate_auth_token', to:'users#generate_auth_token', as: 'generate_auth_token'
    get 'generate_temporary_pin_token', to:'users#generate_temporary_pin_token', as: 'generate_temporary_pin_token'
    get '/raspberry_pi', to: 'users#raspberry_pi', as: 'raspberry_pi'
    get '/devices/control', to:'devices#device_control', as: 'device_control'
    resources :tanks do
      get '/raspberry_pi', to: 'tanks#raspberry_pi', as: 'raspberry_pi' 
      get '/tank_sensors', to: 'tanks#tank_sensors', as: 'tank_sensors'     
      resources :sensors do
        get '/graph', to: 'sensors#graph', as: 'graph'
        post '/date_ranges', to: 'sensors#graphs_with_date_range', as: 'graphs_with_date_range'
        get '/sensor_reading_data', to: 'sensors#sensor_reading_data', as: 'sensor_reading_data'
      end
      resources :readings do
        get 'edit_reading_data/:index', to: 'readings#edit_reading_data', as: 'edit_reading_data'
        patch 'update_reading_data', to: 'readings#update_reading_data', as: 'update_reading_data'
        get 'delete_reading_data/:index', to: 'readings#destroy_data', as: 'delete_reading_data'
      end 
      resources :devices do
        get 'turn_on', to: 'devices#turn_on_device', as: 'turn_on_device'
        get 'turn_off', to: 'devices#turn_off_device', as: 'turn_off_device'
      end 
    end
  end

  namespace :api do
    post '/verify_pin_number', to: 'users#verify_pin_number', as: 'verify_pin_number'
    post '/readings/:token', to: 'readings#create', constraints: { token: %r{[^\/]+} }
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
