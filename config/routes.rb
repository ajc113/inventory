Rails.application.routes.draw do
  root :to => 'dashboard#show'

  get 'dashboard' => 'dashboard#show'

  resources :users
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :sales
  resource :system_configuration, only: %i[show edit update]

  get "up" => "rails/health#show", as: :rails_health_check
end
