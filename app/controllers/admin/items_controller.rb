class Admin::ItemsController < ApplicationController
   before_action :authenticate_admin!

  def index
    @items = Item.all.order(created_at: :desc).page(params[:page]).per(6)

    #タグ検索機能
    #OR検索の記述
    if params[:tag_ids]
      @items = []
      params[:tag_ids].each do |key, value|
        @items += Tag.find_by(name: key).items if value == "1"
      end
      @items.uniq!
    end

    # AND検索の記述
    if params[:tag_ids]
      @items = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_items = Tag.find_by(name: key).items
          @items = @items.empty? ? tag_items : @items & tag_items
        end
      end
    end
  end

  def user_items
    @user = User.find(params[:id])
    @items = @user.items.order(created_at: :desc) .page(params[:page]).per(5)
  end


  def show
    @item = Item.find(params[:id])

     #コメント
    @comments = @item.comments

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

def destroy
  item = Item.find(params[:id])
  item.destroy
  redirect_to admin_items_path
end

  private

  def item_params
    params.require(:item).permit(:image, :title, :detail, :star, tag_ids: [])
    # 複数のtag_idsが渡ってくるので「配列[]」の形式での記述
  end


end
