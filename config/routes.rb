Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'

  resources :users, only: :show
  
  get '/oauth/kakao' => 'oauth#kakao'
  get '/oauth/kakao_redirect' => 'oauth#kakao_redirect'
end
