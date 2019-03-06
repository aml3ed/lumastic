class CoursesController < ApplicationController
  load_resource :community
  load_and_authorize_resource :course, through: :community, :except => :new
  before_action :get_lessons, only: [:show, :edit, :update]


  # Example route: GET /courses
  def index
    # Show only the courses for that logged-in user
    @courses = @community.courses
  end

  # Example route: GET /courses/1
  def show
    @lessons.order(:position)
    @course_path_nav = community_course_path(@community, @course)
  end

  # Example route: GET /courses/new
  def new
    @course = Course.new(community: @community)
    @course.open = true
    authorize! :new, @course
  end

  # Example route: GET /courses/1/edit
  def edit
    @course_path_nav = edit_community_course_path(@community, @course)
    @lessons.order(:position)
  end

  # Example route: POST /courses
  def create
    # Build a new course object from the form parameters
    if course_params[:open] == "1"
      @course = OpenCourse.new(course_params)
    else
      @course = ClosedCourse.new(course_params)
    end
    @course.community = @community
    # Add the user_id from the session object
    @course.user_id = current_user.id
    # Save the new course object to the database
    respond_to do |format|
      if @course.save
        track_activity(@course)
        format.html { redirect_to new_community_course_lesson_path(@community, @course), :flash => {:notice => "Your course was created successfully! Woohoo!"} }
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
        format.html { redirect_to community_course_path(@community, @course), notice: 'Course was successfully updated.' }
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
      format.html { redirect_to community_path(@community), notice: 'Course was successfully destroyed.' }
    end
  end

  private
    # All of these methods are 'before_actions'
    # They get run before anything happens inside the controller

    def get_lessons
      @lessons = Lesson.where(course: @course).order(:position)
    end

    # Declares what parameters are mutatable by the controller
    def course_params
      params.require(:course).permit(:title, :course_info, :open, :instructor_bio, :keywords, :price, :thumbnail)
    end

    def ticket_breakdown
      tickets = @course.tickets
      @totalTickets = tickets[:total]
      @ticketPercents = {red: helpers.percent(tickets[:red], @totalTickets), blue: helpers.percent(tickets[:blue],@totalTickets), green: helpers.percent(tickets[:green],@totalTickets)}
    end
end
