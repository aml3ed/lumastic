class CommunitiesController < ApplicationController
  def index
    @course = Course.all.first()
    render 'communities/show'
  end
end