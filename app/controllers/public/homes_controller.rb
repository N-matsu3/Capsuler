class Public::HomesController < ApplicationController

def top
  @items = Item.all.order(created_at: :desc).limit(3)
end

end
