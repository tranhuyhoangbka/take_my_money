Rails.application.routes.draw do
  devise_for :users
  # get 'events/index'
  # get 'events/show'
  mount Sidekiq::Web => "/sidekiq" # monitoring console
  root "home#index"
  # root to: "visitors#index"
  resources :events
  resource :shopping_cart
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
