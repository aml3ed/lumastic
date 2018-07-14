class PagesController < ApplicationController
  def generic
    respond_to do |format|
      format.html
    end
  end

  def home
    @lessons = Lesson.all
  end

  def teacher
    generic
  end
end
