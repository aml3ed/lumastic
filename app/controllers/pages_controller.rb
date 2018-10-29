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
