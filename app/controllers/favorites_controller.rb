class FavoritesController < ApplicationController

  def create
    nill = Book.find(params[:book_id])
    @favo = Favorite.new
    @favo.user_id = current_user.id
    @favo.book_id = nill.id
    @favo.save

    redirect_back(fallback_location: root_path)
    #元の画面に戻る

  end

  def destroy
    nill = Book.find(params[:book_id])
    @favo = Favorite.find_by(book_id: nill.id)
    @favo.destroy

    redirect_back(fallback_location: root_path)
  end

end
