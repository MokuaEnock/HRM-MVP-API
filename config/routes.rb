Rails.application.routes.draw do
  resources :disciplines
  resources :employeeinsuarances
  resources :employeesaccos
  resources :employeecurrents
  resources :employeecontacts
  resources :employeeworks
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
  get "/employee_payslip/:id", to: "payslips#employee_payslips"
  get "/department_payslip/:id", to: "payslips#department_payslips"
  get "/employer_payslip/:id", to: "payslips#employer_payslips"
  post "departments_all", to: "departments#create_multiple"
  post "employees_all", to: "employees#create_multiple"
  get "/generate_data", to: "payslips#generate_data"
  get "/total_employees/:id", to: "employers#total_employees"
  get "/all_employees/:id", to: "employers#all_employees"
  get "/rating/:id", to: "employees#average_rating"
  get "/download_pay/:id", to: "departments#download_pay"

  # mount SwaggerUiEngine::Engine, at: "/api-docs"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
