class Public::ItemsController < ApplicationController

  def index
  end

  def myindex
    @user = current_user
    #current_userが作ったitemのみ表示。.orderあとは作成日時順で並び替えのための記述
    @items = @user.items.order(created_at: :desc)


  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id

    if  @item.save
        flash[:notice] = "投稿しました！"
        redirect_to item_path(@item)
    else
      render :myindex
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
      if @item.update(item_params)
            flash[:notice] = "更新しました！"
          redirect_to item_path(@item)
      else
        render :edit
      end
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :detail)
  end

end
