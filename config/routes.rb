Dogeserver::Application.routes.draw do
  resources :accounts, only: [:show, :create], param: :name
  resources :tips, only: [:create]
end
