class CoursesController < ApplicationController
  load_resource :community
  load_and_authorize_resource :course, through: :community
  before_action :get_lessons, only: [:show, :edit]
  before_action :ticket_breakdown, only: [:edit, :show]


  # Example route: GET /courses
  def index
    # Show only the courses for that logged-in user
    @courses = Course.where(:user_id => current_user.id)
    @course_tickets = {}
    @courses.each do |course|
      totals = course.tickets
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
    @course_path_nav = community_course_path(@community, @course)
  end

  # Example route: GET /courses/new
  def new
    @course = Course.new(community: @community)
  end

  # Example route: GET /courses/1/edit
  def edit
    @course_path_nav = edit_community_course_path(@community, @course)
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
    puts "************************** #{course_params.inspect}"
    if course_params[:open] == "1"
      @course = OpenCourse.new(course_params)
    else
      @course = ClosedCourse.new(course_params)
    end
    @course.community = @community
    puts "community *******"
    puts @community.inspect
    # Add the user_id from the session object
    @course.user_id = current_user.id
    # Save the new course object to the database
    respond_to do |format|
      if @course.save
        puts @course.inspect
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
        format.html { redirect_to community_course_path(@community, @course), :flash => {:notice => "Your course was saved successfully! Woohoo!" } }
      else
        format.html { render :show }
      end
    end
  end

  # Example route: DELETE /courses/1
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to community_courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
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
      params.require(:course).permit(:title, :course_info, :open, :instructor_bio, :keywords, :price)
    end

    def ticket_breakdown
      tickets = @course.tickets
      @totalTickets = tickets[:total]
      @ticketPercents = {red: helpers.percent(tickets[:red], @totalTickets), blue: helpers.percent(tickets[:blue],@totalTickets), green: helpers.percent(tickets[:green],@totalTickets)}
    end
end
