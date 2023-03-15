class FriendsController < ApplicationController
  
  def index
    @friends = current_user.friends
  end

  def search
    render json: params
  end
end