Rails.application.routes.draw do

  # ユーザー認証
  devise_for :users, only: [:sessions, :registrations], path: '', path_names: {
    sign_in: 'sign_in',
    sign_out: 'sign_out',
    sign_up: 'sign_up'
  }

  post 'users/guest_sign_in', to: 'users#guest_sign_in', as: 'user_guest_sign_in'


  # トップページ・その他ページ
  root 'homes#top'
  get 'about', to: 'homes#about'
  get 'search', to: 'searches#index'
  get 'mypage', to: 'users#mypage'

  # ユーザー
  resources :users, only: [:show, :edit, :update, :destroy]

  # 投稿
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end  

  # いいね
  resources :favorites, only: [:index, :create, :destroy]

  # フォロー
  resources :follows, only: [:index, :create, :destroy]

  namespace :admin do
    # 管理者認証
    devise_for :admins, only: [:sessions], path: '', path_names: {
      sign_in: 'sign_in',
      sign_out: 'sign_out'
    }

    # 管理者トップ
    root 'homes#top'

    # ユーザー管理
    resources :users, only: [:index, :show, :destroy]

    # 投稿管理
    resources :posts, only: [:index, :show, :destroy]
  end
end


