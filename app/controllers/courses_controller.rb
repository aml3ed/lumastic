class CoursesController < ApplicationController
  load_and_authorize_resource
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :get_lessons, only: [:show, :edit, :show]
  before_action :ticket_breakdown, only: [:edit, :show]


  # Example route: GET /courses
  def index
    # Show only the courses for that logged-in user
    @courses = Course.where(:user_id => current_user.id)
    @course_tickets = {}
    @courses.each do |course|
      totals = course.total_tickets
      totalTickets = totals[:total]
      totalReds = totals[:red]
      totalBlues = totals[:blue]
      totalGreens = totals[:green]
      @tickets = [helpers.percent(totalReds, totalTickets),
                  helpers.percent(totalBlues, totalTickets),
                  helpers.percent(totalGreens, totalTickets)]
      @course_tickets[course.id.to_s] = @tickets
    end
  end

  # Example route: GET /courses/1
  def show
    @lessons.order(:position)
    @course_path_nav = course_path(@course)
  end

  # Example route: GET /courses/new
  def new
    @course = Course.new
  end

  # Example route: GET /courses/1/edit
  def edit
    @course_path_nav = edit_course_path(@course)
    @lessons.order(:position)
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
        format.html { redirect_to course_path(@course), :flash => {:notice => "Your course was created successfully! Woohoo!"} }
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
        format.html { redirect_to course_path(@course), :flash => {:notice => "Your course was saved successfully! Woohoo!" } }
      else
        format.html { render :show }
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

    def get_lessons
      @lessons = Lesson.where(:course_id => @course.id)
    end

    # Declares what parameters are mutatable by the controller
    def course_params
      params.require(:course).permit(:title, :course_info, :subject, :instructor_bio, :keywords, :price)
    end

    def ticket_breakdown
      totalReds = 0
      totalBlues = 0
      totalGreens = 0
      @lessons.each do |lesson|
        totalReds += lesson.out_red
        totalBlues += lesson.out_blue
        totalGreens += lesson.out_green
      end
      totalTickets = totalReds + totalBlues + totalGreens
      @tickets = [helpers.percent(totalReds, totalTickets), helpers.percent(totalBlues, totalTickets), helpers.percent(totalGreens, totalTickets)]
    end
end
