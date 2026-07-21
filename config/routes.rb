Rails.application.routes.draw do
  root "home#index"

  resources :servers
  namespace :api do
    get "servers", to: "servers#index"
    get "servers/target", to: "servers#show"
    post "servers", to: "servers#create"
    patch "servers", to: "servers#update"
    delete "servers", to: "servers#destroy"
  end

  resources :cabinets
  namespace :api do
    get "cabinets", to: "cabinets#index"
    get "cabinets/target", to: "cabinets#show"
    post "cabinets", to: "cabinets#create"
    patch "cabinets", to: "cabinets#update"
    delete "cabinets", to: "cabinets#destroy"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
