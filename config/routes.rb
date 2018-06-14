Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users

  root 'pages#home'

  resources :dive_centers, only: [:index, :show, :edit, :update] do
    collection do
      get :autocomplete
      get :validate, as: :validate
    end
  end

  get 'search', to: 'dive_centers#search'
end
