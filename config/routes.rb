Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    namespace :admin do
      get "/", to: "users#index"
      resources :users, except: %i(show edit update)
      resources :rooms, except: %i(index show)
      resources :room_types, except: %i(index show)
    end
    root "static_pages#home"
    get "/home", to: "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/book", to: "static_pages#booking"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :rooms, only: %i(index show)
    resources :room_types, only: :show
    resources :bookings do
      get "delete"
    end
    resources :payments, only: %i(new create)
  end
end
