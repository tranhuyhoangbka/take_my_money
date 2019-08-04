Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
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
  resource :user
  post "stripe/webhook", to: "stripe_webhook#action"
  resources :subscriptions, only: %i(edit update destroy)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
