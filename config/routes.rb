Rails.application.routes.draw do
  get 'dashboards/show'
  devise_for :users
  root 'pages#index'

  post 'webhooks/:source', to: 'webhooks#create'

  resource :dashboard
end
