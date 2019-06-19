Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :listings, only: [:show, :index, :create, :destroy]
      resources :bookings, only: [:show, :index, :create, :destroy]
      resources :reservations, only: [:show, :index, :create, :destroy]
      resources :missions, only: [:index]
    end
  end
end
