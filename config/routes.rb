Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "landing_page#index"
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :show]
    end
  end

  namespace :admin do
    resources :products
    resources :categories
  end
end
