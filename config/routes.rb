Rails.application.routes.draw do
  # devise_for :users
  # root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "dogs#index"

  resources :users do
    resources :bookings, only: [:index, :create]
    resources :dogs
  end

  resources :dogs do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:show, :edit, :update, :destroy]

  devise_for :user,
      controllers: {
         omniauth_callbacks: 'users/omniauth_callbacks'
      }

end
