class Public::ItemsController < ApplicationController

  def index
  end

  def myindex
    @user = current_user
    #current_userが作ったitemのみ表示
    @items = @user.items
    
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id

    if  @item.save
        flash[:notice] = "投稿しました！"
        redirect_to my_items_path
    else
      render :myindex
    end
  end

  def show
    @item = Item.find(params[:id])
  end


  private

  def item_params
    params.require(:item).permit(:image, :title, :detail)
  end

end
