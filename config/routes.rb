Rails.application.routes.draw do
  resources :employerdetails
  resources :departments
  resources :employerbanks
  resources :employerfinancials
  resources :employerlocations
  resources :employees
  resources :employers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
