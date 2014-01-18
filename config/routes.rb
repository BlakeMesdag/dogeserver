Dogeserver::Application.routes.draw do
  resources :accounts, only: [:show, :create], param: :name do
    post :deposit, on: :member
  end

  resources :tips, only: [:create]
end
