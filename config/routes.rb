Rails.application.routes.draw do

  devise_for :users
  root to: "products#index"

  resources :products do
    resources :comments, shallow: true
    resource :usage_manifests, only: [:create, :destroy]
  end

  resources :product_usages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
