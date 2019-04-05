class TopCommentersController < ApplicationController
  def index
    @users = User.top_commenters
  end
end
