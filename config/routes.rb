Rails.application.routes.draw do
  root to: "home#index"

  devise_for :users

  get 'home/index'

  resources :categories

  resources :products do
    resources :comments, shallow: true
    resource :usage_manifests, only: [:create, :destroy]
    resources :approval_images, only: [:index, :create, :update]
  end

  resources :users, only: :show

  namespace :administration do
    get "/" => "base#index"
    resources :users, only: :index
    resources :products, only: :index
    resources :comments, only: :index
    resources :usage_approvals, only: :index
  end

  namespace :forest do
    resources :brands
    post '/actions/make-approved' => 'approval_images#make_approved'
    post '/actions/make-denied' => 'approval_images#make_denied'
    post '/actions/make-waiting-approval' => 'approval_images#make_waiting_approval'
  end

  mount ForestLiana::Engine => '/forest'
end
