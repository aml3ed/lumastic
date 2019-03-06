class AdminController < ApplicationController
  authorize_resource class: false

  def dashboard
    @list_activities = Activity.order("created_at desc").take(20)
    @logins_and_signups = Activity.where(trackable_type: "User")
    @contribution_activities = Activity.where.not(trackable_type: "User")
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

  def admin_user_destroy
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroy
      redirect_back(fallback_location: root_path, notice: "User deleted.")
    end
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