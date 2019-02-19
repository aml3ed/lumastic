class PagesController < ApplicationController
  def generic
    respond_to do |format|
      format.html
    end
  end

  def home
    @courses = Course.left_joins(:lessons).group(:id).order('COUNT(lessons) DESC').limit(4)
    @communities = Community.left_joins(:memberships).group(:id).order('COUNT(memberships) DESC').limit(6)
  end

  def search
    @query = params[:search]
    @noresults = false
    if params[:search]
      @communities = Community.where('lower(name) LIKE ?', "%#{params[:search].downcase}%")
      if @communities.empty?
        @noresults = true
        @communities = Community.all
      end
    else
      @communities = Community.all
    end
  end

  def teacher
    generic
  end

  def legal
  end

  def join
  end

  def feedback
  end

  def not_found

  end

  def internal_server_error

  end

end
