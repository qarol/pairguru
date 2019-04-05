class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    movie = Movie.find(params[:id])
    comment = movie.comments.build(params_comment)
    comment.assign_attributes(user: current_user)
    if comment.save
      notice = "Comment successfully created"
      redirect_back fallback_location: movies_path, notice: notice
    else
      alert = "We couldn't create comment. #{comment.errors.full_messages.to_sentence}"
      redirect_back fallback_location: movies_path, alert: alert
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_back fallback_location: movies_path, notice: "Comment was successfully deleted"
  end

  private

  def params_comment
    params.require(:comment).permit(:content)
  end
end
