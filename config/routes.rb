Rails.application.routes.draw do

  root 'homes#top'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]

  resources :books do
    resource :favorites, only:[:create, :destroy]
    resource :comments, only: [:show, :create, :destroy]

  end
  get 'home/about' => 'homes#about'

end