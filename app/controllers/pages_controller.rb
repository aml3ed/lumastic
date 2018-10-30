class PagesController < ApplicationController
  def generic
    respond_to do |format|
      format.html
    end
  end

  def home
    @courses = Course.all.order(:created_at).reverse_order
    @communities = Community.all.order(:created_at).reverse_order
  end

  def search
    @query = params[:search]
    @noresults = false
    if params[:search]
      @communities = Community.where('name LIKE ?', "%#{params[:search]}%")
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
