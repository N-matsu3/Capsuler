class Admin::CommentsController < ApplicationController

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
      if comment.destroy
        flash[:success] = 'コメントを削除しました。'
      else
        flash[:danger] = '削除に失敗しました。'
      end
      
    @item = Item.find(params[:id])
    redirect_to admin_item_path(@item.id)
  end

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_back(fallback_location: items_path)
    else
      redirect_back(fallback_location: items_path)
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:comment_content, :item_id)  #formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
  end
end
