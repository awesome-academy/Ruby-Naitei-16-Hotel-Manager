Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks,
              controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  scope "(:locale)", locale: /en|vi/ do
    mount RailsAdmin::Engine => "/admin", as: "rails_admin"
    root "static_pages#home"
    get "/home", to: "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/book", to: "static_pages#user_booking"
    devise_for :users, controllers: {registrations: "users"},
                       skip: :omniauth_callbacks
    resources :users
    resources :rooms, only: %i(index show)
    resources :room_types, only: :show
    resources :bookings do
      get "delete"
    end
    resources :payments, only: %i(new create show)
  end
end
