Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users

  root 'pages#home'

  resources :dive_center, only: [:index, :show] do
    collection do
      get :autocomplete
    end
  end

  get 'search', to: 'dive_centers#index', as: :search
end
