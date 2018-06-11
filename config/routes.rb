Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users

  root 'pages#home'

  resources :dive_centers, only: [:index, :show] do
    collection do
      get :autocomplete
    end
  end

  get 'search', to: 'dive_centers#search' #, defaults: {format: :json}
end
