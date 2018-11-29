class AdminController < ApplicationController
  before_action :check_admin

  def dashboard
  end

  def admin_users
    @users = User.all.order(:created_at).reverse_order
  end

  def admin_communities
    @communities = Community.all.order(:created_at).reverse_order
  end

  def admin_courses
    @courses = Course.all.order(:updated_at).reverse_order
  end

  def admin_lessons
    @lessons = Lesson.all.order(:updated_at).reverse_order
  end

  private

  def check_admin
    if current_user
      unless helpers.is_admin(current_user)
        redirect_back(fallback_location: root_path)
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

end