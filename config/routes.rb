Rails.application.routes.draw do

  devise_for :users
  root to: "products#index"

  resources :products do
    resources :comments, shallow: true
    resource :usage_manifests, only: [:create, :destroy]
    resources :approval_images
  end

  resources :product_usages
end
