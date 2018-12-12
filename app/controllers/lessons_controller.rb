class LessonsController < ApplicationController
  load_resource :community
  load_resource :course, through: :community
  load_and_authorize_resource :lesson, through: :course
  before_action :find_lessons
  before_action :get_embed_from_url, only: [:show, :view, :edit]

  # Example route: GET /lessons
  def index
    # See get_embed_from_url before action
  end

  # Example route: GET /lessons/1
  def show
    # See get_embed_from_url before action
  end

  # Example route: GET /lessons/new
  def new
    @lesson = Lesson.new(course: @course)
    @lesson.materials.build
  end

  # Example route: GET /lessons/1/edit
  def edit
  end

  # Example route: POST /lessons
  def create
    # Build a new lesson object from the form parameters
    @lesson = Lesson.new(lesson_params)
    # Add the course_id from the url parameters
    @lesson.course = @course
    @lesson.user_id = current_user.id
    # Save the new lesson object to the database
    @lesson.position = Lesson.where(course: @course).present? ? Lesson.where(course: @course).maximum('position') + 1 : 1
    respond_to do |format|
      if @lesson.save
        format.html { redirect_to community_course_lesson_path(@community, @course, @lesson), notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # Example route: PATCH/PUT /lessons/1
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to community_course_lesson_path(@community, @course, @lesson), notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # Example route: DELETE /lessons/1
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to community_course_path(@community,@course), notice: 'Lesson was successfully destroyed.' }
    end
  end

  def sort
    params[:lesson].each_with_index do |id, index|
      Lesson.where(id: id).update_all(position: index + 1)
    end
    head :ok
  end

  def count_ticket
    @lesson = Lesson.where(id: params[:id]).first
    field = "#{params[:type]}_#{params[:color]}".to_sym
    cur_val = @lesson.send(field).nil? ? 0 : @lesson.send(field)
    @lesson.send(field.to_s + '=', cur_val + 1)
    @lesson.save!
  end

  def vote
    vote = params[:vote]
    if vote == "upvote"
      @lesson.increment!(:likes)
    else
      @lesson.increment!(:dislikes)
    end
    @lesson.save!
  end

  private
    # All of these methods are 'before_actions'
    # They get run before anything happens inside the controller


    # Finds all of the lessons that belong to the specific course
    def find_lessons
      @lessons = @course.lessons.order(:position)
    end

    # Finds all of the materials that belong to the specific lesson
    def find_materials
      @materials = @lesson.materials
    end

    # Declares what parameters are mutatable by the controller
    def lesson_params
      params.require(:lesson).permit(:title, :video_url, :lesson_info, :keywords, :user_id, materials_attributes: [:id, :title, :file, :_destroy])
    end

    def get_embed_from_url
      if @lesson.video_url != nil
        @vid_id = helpers.youtube_id(@lesson.video_url)
        @embed_url = helpers.embed_url(@vid_id)
      end
    end

    def get_ticket_percentage
      @totalTickets = @lesson.out_red + @lesson.out_blue + @lesson.out_green
      @tickets = [helpers.percent(@lesson.out_red, @totalTickets), helpers.percent(@lesson.out_blue, @totalTickets), helpers.percent(@lesson.out_green, @totalTickets)]
    end
end
