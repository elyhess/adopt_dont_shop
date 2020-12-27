Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  resources :pets

  resources :shelters do
    resources :pets, controller: "shelter_pets", only: [:index, :new, :create]
  end

  resources :applications do
    resources :pets, controller: "application_pets", only: [:create, :update]
  end

  scope :admin, as: "admin" do
    resources :applications, controller: "admin_applications", only: [:show]
    resources :shelters, controller: "admin_shelters", only: [:index, :show]
  end

  resources :users

end
