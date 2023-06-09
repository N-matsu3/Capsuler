Rails.application.routes.draw do

  namespace :admin do
    get 'items/index'
    get 'items/show'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do

  end
  #[ :registrations,]を付けることによってサインアップはできないようにしている。
  devise_for :admin, skip: [:registrations,:passwords], controllers: {

    sessions: "admin/sessions"
}

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
}


##ユーザ
scope module:
  :public do
    # ゲストログイン
      post '/homes/guest_sign_in', to: 'homes#guest_sign_in'

    #homes
      root to: "homes#top"
      get "about" => "homes#about"

    #users
      get "users/introduction/:id" => "users#introduction" ,as:"users_introduction" #asでパスを作ってあげないとrailsがうまくpathを作ってくれない

      get "users/my_page" => "users#show"
      get "users/my_page/edit" => "users#edit"
      patch "users/my_page" => "users#update"

      resources :users,only:[:introduction]

      get "users/index" => "users#index"

    resources :users do
      member do
        get :favorites
      end

    end

    #items
      resources :items, only:[:index, :new, :create, :show, :edit, :update, :destory, :myindex, :delete]
      get "my_items" => "items#myindex"
      get "index_useritems/:id"  => "items#useritems" ,as:"index_useritems"

    #comment
      resources :items do
        resources :comments, only: [:create]
        # commentsリソースをpostsリソース内にネストすることで、post_comments_pathなどのようにパスを指定できる！

    #favorites
      resource :favorites, only: [:create, :destroy]

    end
  end

##管理者
  namespace :admin do
    root to: "homes#top"
    # 上記の記述でskipしているので、実際は入力しても出ない。
    get "sign_up" => "registrations#new"

  #items
    resources :items,only:[:index, :show, :destroy, :delete, :edit, :update]
    get "index_user_items/:id"  => "items#user_items" ,as:"index_user_items"
  # users
    resources :users,only:[:index, :show, :edit, :update]

    # comments
    resources :comments,only:[:destroy, :delete]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
