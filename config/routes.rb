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
    #homes
      root to: "homes#top"
      get "about" => "homes#about"

    #users
      get "users/my_page" => "users#show"
      get "users/my_page/edit" => "users#edit"
      patch "users/my_page" => "users#update"

    #items
      resources :items, only:[:index, :new, :create, :show, :edit, :update, :destory, :myindex, :delete]
      get "my_items" => "items#myindex"

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
    get "sign_up" => "registrations#new"

  #items
    resources :items,only:[:index, :show, :destroy, :delete, :edit, :update]
  # users
    resources :users,only:[:index, :show, :edit, :update]

    # comments
    resources :comments,only:[:destroy, :delete]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
