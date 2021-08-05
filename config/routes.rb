Rails.application.routes.draw do

  get 'followers/show'
  root 'homes#top'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :relationships, only: [:show, :create, :destroy]
  resources :followers, only: [:show]
  #get 'relationships/followers_show' => 'relationships#followers_show'


  resources :books do
    resource :favorites, only:[:create, :destroy]
    resource :comments, only: [:show, :create, :destroy]

  end
  get 'home/about' => 'homes#about'

end