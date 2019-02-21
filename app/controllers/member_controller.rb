class MemberController < ApplicationController

  def index
    @courses = Course.all
    # Course.inProgress
    # Course.newCourses
    # Course.completedCourses ->create a join table like in schema.rb - "20181018014615_create_memberships" and the one after that
  end

  def show
  end

end