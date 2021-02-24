Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'bands#index'
  resource :session, only: [:create, :destroy, :new]
  get "/users/activate", to: "users#activate"
  resources :users, only: [:create, :new, :show]
  resources :bands do 
    resources :albums, only: :new
  end
  resources :albums, only: [:show, :create, :edit, :update, :destroy] do
    resources :tracks, only: :new
  end
  resources :tracks, only: [:create, :edit, :show, :update, :destroy] do
    resources :notes, only: :new
  end
  resources :notes, only: [:create, :show, :destroy]
end
