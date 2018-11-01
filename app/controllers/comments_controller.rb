class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @discussion = Discussion.find(params[:discussion_id])
    @comment =@discussion.comments.new(comment_params)
    if @comment.save
      redirect_to discussion_path(@discussion), notice: "Your comment was successfully posted!"
    else
      redirect_to discussion_path(@discussion), notice: "Your comment wasn't posted!"
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :discussion_id, :parent_id, :content)
  end
end