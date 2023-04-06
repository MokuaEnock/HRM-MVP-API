Rails.application.routes.draw do
  resources :employeeinsuarances
  resources :employeesaccos
  resources :employeecurrents
  resources :employeecontacts
  resources :employeeworks
  resources :disciplinaries
  resources :employeetasks
  resources :payrates
  resources :payslips do
    collection do
      get "totals"
      get :calculate_payslip_totals
    end
  end
  resources :attendances
  resources :employeelocations
  resources :employeefinancials
  resources :employeeschedules
  resources :employeebanks
  resources :employeedetails
  resources :departmentdetails
  resources :employerdetails
  resources :departments
  resources :employerbanks
  resources :employerfinancials
  resources :employerlocations
  resources :employees
  resources :employers
  get "/attendance_summary/:id", to: "attendances#attendance_summary"
  get "/payslips/cpt/:id", to: "payslips#calculate_payslip_totals"
  get "payslip/:id", to: "payslips#payslip"
  # mount SwaggerUiEngine::Engine, at: "/api-docs"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
