Rails.application.routes.draw do
  get 'dashboards/show'
  devise_for :users
  root 'pages#index'

  resource :dashboard
end
