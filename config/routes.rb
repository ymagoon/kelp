Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users

  root 'pages#home'
  resources :dive_center, only: [:index, :show]
  # get 'search', to: 'pages#search', as: :search
end
