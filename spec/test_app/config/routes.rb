Rails.application.routes.draw do
  devise_for :admin_users#, path: 'admin4rails'
  mount Admin4rails::Engine => '/admin4rails'
end
