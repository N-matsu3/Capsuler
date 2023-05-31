class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all.order(created_at: :desc)

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

  def show
  end
end
