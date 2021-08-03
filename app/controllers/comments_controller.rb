class CommentsController < ApplicationController

  before_action :ensure_correct_user, only:[:edit, :update]

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

  def ensure_correct_user
    @book = Book.find(params[:id])
    if current_user != @book.user
      redirect_to book_path(@book)
    end
  end
end
