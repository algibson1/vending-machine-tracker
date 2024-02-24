Rails.application.routes.draw do
  root to: "owners#index"

  resources :owners do
    resources :machines, only: [:index]
  end

  resources :machines, only: [:show] do  
    resources :snacks, only: [:create, :destroy], controller: :machine_snacks
  end 

  resources :snacks, only: [:show]
end
