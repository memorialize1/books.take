class CommentsController < ApplicationController

  def create
    nill = Book.find(params[:book_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.book_id = nill.id
    comment.save
    redirect_to book_path(nill)
  end

  def destroy
    nill = Book.find(params[:book_id])
    comment = Comment.find_by(book_id: nill.id)
    comment.destroy
    redirect_to book_path(nill)
  end


  private

  def comment_params
    params.require(:comment).permit(:com)
  end

end
