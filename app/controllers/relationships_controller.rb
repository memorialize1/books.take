class RelationshipsController < ApplicationController


  def show
    @user = User.find(params[:id])
    @follows = @user.followings
    @create = Book.new
  end


  def create
    @user = User.find(params[:relationship][:follow_id])
    following = current_user.follow(@user)
    if following.save
      flash[:success] = 'フォローしました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alate] = 'フォローに失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @user = User.find(params[:id])
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end






  private


end
