class DiscussionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_discussion, only: [:show, :edit, :update, :destroy]
  before_action :set_community, only: [:show, :edit, :update, :destroy]


  def index
  end

  def show
  end

  def new
    @community = Community.find(params[:community_id])
    @discussion = Discussion.new
  end

  def edit
  end

  def create
    # Build a new course object from the form parameters
    @discussion = Discussion.new(discussion_params)
    puts '**********************************************'
    puts discussion_params.inspect
    # Add the user_id from the session object
    @discussion.community_id = params[:community_id]
    @discussion.user_id = current_user.id
    # Save the new course object to the database
    respond_to do |format|
      if @discussion.save
        track_activity(@discussion)
        format.html { redirect_to community_path(@discussion.community), :flash => {:notice => "Your discussion was created successfully! Woohoo!"} }
        format.json { render :show, status: :created, location: @community }
      else
        format.html { render :new }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy
    @discussion.destroy
    respond_to do |format|
      format.html { redirect_to community_path(@community), notice: 'Discussion was deleted.' }
      format.json { head :no_content }
    end
  end

  private
  def discussion_params
    params.require(:discussion).permit(:community_id, :title, :description)
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  def set_community
    @community = @discussion.community
  end

end