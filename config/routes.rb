Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'

  get '/oauth/kakao' => 'oauth#kakao'
  get '/oauth/kakao_redirect' => 'oauth#kakao_redirect'
end
