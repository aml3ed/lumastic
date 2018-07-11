class PagesController < ApplicationController
  def generic
    respond_to do |format|
      format.html
    end
  end

  def home
  end

  def teacher
    generic
  end
end
