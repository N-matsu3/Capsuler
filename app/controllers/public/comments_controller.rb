class Public::CommentsController < ApplicationController
  
  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_back(fallback_location: item_path(@item))  
    else
      redirect_back(fallback_location: item_path(@item))  
    end
  end


  private
  
  def comment_params
    params.require(:comment).permit(:comment_content, :post_id)  #formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
  end
end
  

