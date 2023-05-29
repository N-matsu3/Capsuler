class Public::ItemsController < ApplicationController

  def index
  end

  def myindex
    @user = current_user
    #current_userが作ったitemのみ表示。.orderあとは作成日時順で並び替えのための記述
    @items = @user.items.order(created_at: :desc)
    
    #コメント一覧 
    @comments = @post.comments  
    @comment = current_user.comments.new  

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
     
    #コメント
    @comments = @post.comments  
    @comment = current_user.comments.new  

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
    params.require(:item).permit(:image, :title, :detail, :star, tag_ids: [])
    # 複数のtag_idsが渡ってくるので「配列[]」の形式での記述
  end

end
