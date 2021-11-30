Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :users do
    collection do
      get :verification_screen
      put :verification
      get :resend_verification_code
    end
  end

  resources :payment_requests

  get '/short/:identifier' => 'short_urls#redirect'

  root to: 'home#index'
end
