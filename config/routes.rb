Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :projects do
    resources :bugs
  end
  root "projects#index"
  resources :bugs
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
