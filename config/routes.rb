Rails.application.routes.draw do
  resources :expenses
  resources :needs
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: "budgets#index"
  devise_for :users
  resources :budgets
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
