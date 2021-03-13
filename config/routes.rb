Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      require "sidekiq/web"
      mount Sidekiq::Web => "/sidekiq"
      post "/login", to: "users#login"
      get "/auto_login", to: "users#auto_login"
      post "/forgot_password", to: "users#forgot_password"
    end
  end
end
