Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users
  root 'pages#index'

  get 'dashboard', to: 'dashboards#show'
  get 'orders', to: 'orders#index'
  post 'webhooks/:source', to: 'webhooks#create'

  resource :dashboard
end
