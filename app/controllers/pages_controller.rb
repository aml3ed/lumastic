class PagesController < ApplicationController
  def generic
    respond_to do |format|
      format.html
    end
  end

  def home
    @courses = Course.where(id: Lesson.select(:course_id))
    @communities = Community.all
  end

  def teacher
    generic
  end

end
