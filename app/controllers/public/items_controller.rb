class Public::ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    # @items = Item.all
    #ランダムに表示する記述
    # @random = Item.order("RANDOM()").limit(5)
     @random = Item.order("RANDOM()").page(params[:page]).per(5)

      # タグ検索機能
      #OR検索の記述
    if params[:tag_ids]
      selected_tag_names = params[:tag_ids].select {|k,v| v == "1"}.keys
      selected_tag_ids = Tag.where(name: selected_tag_names).pluck(:id)
      @random = Item.joins(:tag_relations).where(tag_relations: { tag_id: selected_tag_ids}).page(params[:page]).per(5)
    end

  end


  def myindex
    @user = current_user
    #current_userが作ったitemのみ表示。.orderあとは作成日時順で並び替えのための記述
    @items = @user.items.order(created_at: :desc).page(params[:page]).per(5)


    if params[:tag_ids]
      selected_tag_names = params[:tag_ids].select {|k,v| v == "1"}.keys
      selected_tag_ids = Tag.where(name: selected_tag_names).pluck(:id)
      @items = Item.joins(:tag_relations).where(user: @user, tag_relations: { tag_id: selected_tag_ids}).page(params[:page]).per(5)
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

  def useritems
    @user = User.find(params[:id])
    @items = @user.items.order(created_at: :desc) .page(params[:page]).per(5)

    if params[:tag_ids]
      selected_tag_names = params[:tag_ids].select {|k,v| v == "1"}.keys
      selected_tag_ids = Tag.where(name: selected_tag_names).pluck(:id)
      @items = Item.joins(:tag_relations).where(user: @user, tag_relations: { tag_id: selected_tag_ids}).page(params[:page]).per(5)
    end

  end

  def show
    @item = Item.find(params[:id])
    @user = @item.user

    #コメント
    @comments = @item.comments
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

  def destroy
  item = Item.find(params[:id])
  item.destroy
  redirect_to my_items_path
  end


  private

  def item_params
    params.require(:item).permit(:image, :title, :detail, :star, :address, :latitude, :longitude, tag_ids: [])
    # 複数のtag_idsが渡ってくるので「配列[]」の形式での記述
  end

end
