Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'requests#new'
  resources :requests, only: [:new, :create]
  get 'confirm_email', to: 'requests#confirm_email'
end
