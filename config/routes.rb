Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  resources :pets
  resources :shelters do
    resources :pets, controller: "shelter_pets", only: [:index, :new, :create]
  end
  resources :applications do
    resources :pets, controller: "application_pets", only: [:create]
  end
  scope :admin, as: "admin" do
    resources :applications, controller: "admin_applications", only: [:show]
  end
  # get '/admin/applications/:id', to: 'admin_applications', as: :admin_application


  # get "/shelters", to: "shelters#index"
  # get "/shelters/new", to: "shelters#new"
  # get "/shelters/:id", to: "shelters#show"
  # delete "/shelters/:id", to: "shelters#destroy"
  # post "/shelters", to: "shelters#create"
  # get "/shelters/:id/edit", to: "shelters#edit"
  # patch "/shelters/:id", to: "shelters#update"
  
  # resources :pets
  # get "/pets", to: "pets#index"
  # get "/pets/:id", to: "pets#show"
  # get "/pets/:id/edit", to: "pets#edit"
  # patch "/pets/:id", to: "pets#update"
  # delete "/pets/:id", to: "pets#destroy"

  # get "/shelters/:shelter_id/pets", to: "shelter_pets#index", as: :shelter_pets
  # get "/shelters/:shelter_id/pets/new", to: "shelter_pets#new", as: :new_shelter_pet
  # post "/shelters/:shelter_id/pets", to: "shelter_pets#create"


end
