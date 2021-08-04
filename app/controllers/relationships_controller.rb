class RelationshipsController < ApplicationController


  def show

  end

  def create
    @user = User.find(params[:relationship][:follow_id])
    following = current_user.follow(@user)
    if following.save
      flash[:success] = 'フォローしました'
      redirect_to @user
    else
      flash.now[:alate] = 'フォローに失敗しました。'
      redirect_to @user
    end
  end

  def destroy
    @user = User.find(params[:follow_id])
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to @user
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to @user
    end
  end


  private


end
