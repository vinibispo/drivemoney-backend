Rails.application.routes.draw do
  # require "sidekiq/web"
  # mount Sidekiq::Web => "/sidekiq"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  namespace :api do
    namespace :v1 do
      resources :users
      post "/login", to: "users#login"
      get "/auto_login", to: "users#auto_login"
      post "/forgot_password", to: "users#forgot_password"
      post "/reset_password", to: "users#reset_password"
      resources :accounts do
        resources :transactions
      end
    end
  end
end
