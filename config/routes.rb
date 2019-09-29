Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :discount_codes
  resources :shipping_details
  resources :affiliates

  devise_scope :user do
    post "users/sessions/verify" => "Users::SessionsController"
  end
  resource :daily_revenue_report
  resource :purchase_audit
  # get 'events/index'
  # get 'events/show'
  mount Sidekiq::Web => "/sidekiq" # monitoring console
  root "home#index"
  # root to: "visitors#index"
  resources :events
  resource :shopping_cart
  resources :payments
  get "paypal/approved", to: "pay_pal_payments#approved"
  resources :plans, only: [:index]
  resource :subscription_cart
  resources :users
  resource :user_simulation, only: %i(create destroy)
  post "stripe/webhook", to: "stripe_webhook#action"
  resources :subscriptions, only: %i(edit update destroy)
  post "refund", to: "refunds#create", as: :refund
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
