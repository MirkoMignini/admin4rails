Rails.application.routes.draw do
  devise_for :admin_users
  mount Admin4rails::Engine => '/admin4rails'
end
