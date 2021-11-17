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

  root to: 'home#index'
end
