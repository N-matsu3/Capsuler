class Public::UsersController < ApplicationController
  # before_action :authenticate_user!
  # before_action :is_matching_login_user, only: [:edit, :update]
   before_action :set_user, only: [:favorites]

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    user.update(user_params)
     flash[:notice] = "プロフィールを更新しました！"
    redirect_to  users_my_page_path
  end

  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:item_id)
    @favorite_items =Item.find(favorites)
  end

  def introduction
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

   private
  def user_params
    params.require(:user).permit(:user_name, :email, :introduction, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
