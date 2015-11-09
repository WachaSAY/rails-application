Rails.application.routes.draw do

  root 'welcomes#index'

  devise_for :users, controllers: { sessions: "users/sessions" }

  namespace :users do
    resource :account, only: [:show, :edit, :update]
    resource :digest, only: [:show]
  end

  resources :motions, controller: 'motion/motions'

  namespace :motion do
    resources :fronts
    resources :responses
    resources :comments
    resources :replies
    resource :rating
  end

  resource :search, only: [:show]

  get 'tests/index'

end
