Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    namespace :admin do
      get "/", to: "users#index"
      resources :users, only: %i(new create index destroy)
    end
    root "static_pages#home"
    get "/home", to: "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/booking", to: "static_pages#booking"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :rooms
  end
end
