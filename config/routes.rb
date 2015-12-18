Rails.application.routes.draw do
  root 'homes#index'
  match '/oauth' => 'authentications#create', via: [:get, :post]
  devise_for :users
end
