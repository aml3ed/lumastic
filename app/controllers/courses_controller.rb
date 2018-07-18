class CoursesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, :except => [:show] #-> routes to the login / signup if not authenticated
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # Example route: GET /courses
  def index
    puts current_user.role.inspect
    # Show only the courses for that logged-in user
    @courses = Course.where(:user_id => current_user.id)
  end

  # Example route: GET /courses/1
  def show
  end

  # Example route: GET /courses/new
  def new
    @course = Course.new
  end

  # Example route: GET /courses/1/edit
  def edit
    # Check to see if the course belongs to this user
    if @course.user_id != current_user.id
      # If it doesn't, redirect to the homepage (we should make this go somewhere else)
      redirect_to root_path
    end
  end

  # Example route: POST /courses
  def create
    # Build a new course object from the form parameters
    @course = Course.new(course_params)
    # Add the user_id from the session object
    @course.user_id = current_user.id
    # Save the new course object to the database
    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # Example route: PATCH/PUT /courses/1
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # Example route: DELETE /courses/1
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # All of these methods are 'before_actions'
    # They get run before anything happens inside the controller

    # Finds the course in the database and references it in a variable
    def set_course
      @course = Course.find(params[:id])
    end

    # Declares what parameters are mutatable by the controller
    def course_params
      params.require(:course).permit(:title, :course_info, :subject, :instructor_bio, :keywords, :price)
    end
end
