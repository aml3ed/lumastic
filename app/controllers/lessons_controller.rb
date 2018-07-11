class LessonsController < ApplicationController
  before_action :set_course
  before_action :find_lessons
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  # Example route: GET /lessons
  def index
  end

  # Example route: GET /lessons/1
  def show
    # Use the YoutubeID gem to get the id from the @lesson object's video_url
    video_id = YoutubeID.from(@lesson.video_url)
    # Append that the the end of a YouTube embed url for use in the view
    if video_id
      @video_embed_url = 'https://youtube.com/embed/'+video_id
    else
      @video_embed_url = ''
    end
  end

  # Example route: GET /lessons/new
  def new
    @lesson = Lesson.new
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
    @lesson.course_id = params[:course_id]
    # Save the new lesson object to the database
    respond_to do |format|
      if @lesson.save
        format.html { redirect_to course_lesson_path(:id => @lesson.id), notice: 'Lesson was successfully created.' }
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
        format.html { redirect_to course_lessons_path, notice: 'Lesson was successfully updated.' }
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
      format.html { redirect_to course_lessons_path, notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # All of these methods are 'before_actions'
    # They get run before anything happens inside the controller

    # Finds the lesson in the database and references it in a variable
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Finds the course in the database and references it in a variable
    def set_course
      @course = Course.find(params[:course_id])
    end

    # Finds all of the lessons that belong to the specific course
    def find_lessons
      @lessons = @course.lessons
    end

    # Finds all of the materials that belong to the specific lesson
    def find_materials
      @materials = @lesson.materials
    end

    # Declares what parameters are mutatable by the controller
    def lesson_params
      params.require(:lesson).permit(:title, :video_url, :lesson_info, :keywords, materials_attributes: [:id, :title, :_destroy])
    end
end
