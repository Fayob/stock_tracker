class FriendsController < ApplicationController
  
  def index
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friends = current_user.friends
      @search_friend = User.search(params[:friend])
      @search_friend = current_user.except_current_user(@search_friend)
      if @search_friend
        render 'index'
      else
        flash[:alert] = "Please enter a valid name or email"
        redirect_to friends_path
      end
    else
      flash[:alert] = "Please enter a friend name or email"
      redirect_to friends_path
    end
  end

  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "Followed friend successfully"
    else
      flash[:alert] = "There was something wrong with the tracking request"
    end
    redirect_to friends_path
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Stopped Following"
    redirect_to friends_path
  end
end