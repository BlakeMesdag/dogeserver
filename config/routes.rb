Dogeserver::Application.routes.draw do
  resources :accounts, only: [:show, :create], param: :name do
    resources :withdrawals, only: :create
    resources :tips, only: :create
  end

  get 'ping', to: 'application#ping'
end
