Rails.application.routes.draw do

  devise_for :users
  root to: "products#index"

  resources :products do
    resources :comments, shallow: true
    resource :usage_manifests, only: [:create, :destroy]
    resources :approval_images, only: [:index, :create, :update]
  end

  resources :users, only: :show

  resources :product_usages

  namespace :administration do
    get "/" => "base#index"
    resources :users, only: :index
    resources :products, only: :index
    resources :comments, only: :index
    resources :usage_approvals, only: :index
  end
end
