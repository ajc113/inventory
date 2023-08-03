Rails.application.routes.draw do
  root :to => 'dashboard#show'

  get 'dashboard' => 'dashboard#show'

  resources :users
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :sales
  resources :flavors
  resources :locations
  resources :productions
  resources :transfers
  resource :system_configuration, only: %i[show edit update]

  resource :sales_report, only: %i[show] do
    get :daily, on: :collection, controller: :daily_sales_report, action: :show
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
