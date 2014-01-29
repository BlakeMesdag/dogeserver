Dogeserver::Application.routes.draw do
  resources :accounts, only: [:show, :create], param: :name do
    resources :withdrawals, only: :create
  end

  resources :tips, only: [:create]

  get 'ping', to: 'application#ping'
end
