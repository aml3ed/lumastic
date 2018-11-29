class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    if params.has_key?(:discussion_id)
      @discussion = Discussion.find(params[:discussion_id])
      @comment =@discussion.comments.new(comment_params)
      redirect = discussion_path(@discussion)
    else params.has_key?(:lesson_id)
      @lesson = Lesson.find(params[:lesson_id])
      @comment =@lesson.comments.new(comment_params)
      redirect = course_lesson_path(@lesson.course, @lesson)
    end
    if @comment.save
      redirect_to redirect, notice: "Your comment was successfully posted!"
    else
      redirect_to redirect, notice: "Your comment wasn't posted!"
    end
  end

  def destroy
  end

  def vote
    @comment = Comment.find(params[:comment_id])
    if params[:type] == 'up'
      @comment.upvote += 1
    else
      @comment.downvote += 1
    end
    @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :discussion_id, :lesson_id, :parent_id, :content)
  end
end