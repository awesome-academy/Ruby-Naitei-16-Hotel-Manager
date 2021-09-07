Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    mount RailsAdmin::Engine => "/admin", as: "rails_admin"
    root "static_pages#home"
    get "/home", to: "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/book", to: "static_pages#user_booking"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :rooms, only: %i(index show)
    resources :room_types, only: :show
    resources :bookings do
      get "delete"
    end
    resources :payments, only: %i(new create show)
  end
end
