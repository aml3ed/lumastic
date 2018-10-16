class CommunitiesController < ApplicationController
  before_action :set_community, only: [:add_user, :remove_user, :show, :edit, :update, :destroy]

  def add_user
    unless @community.users.include?(current_user)
      @community.users << current_user
    end
    redirect_to community_path(@community)
  end

  def remove_user
    unless not @community.users.include?(current_user)
      @community.users.delete(current_user)
    end
    redirect_to community_path(@community)
  end

  def index
  end

  def show
  end

  def new
    @community = Community.new
  end

  def edit
  end

  def create
    # Build a new course object from the form parameters
    @community = Community.new(community_params)
    # Add the user_id from the session object
    @community.users << current_user
    # Save the new course object to the database
    respond_to do |format|
      if @community.save
        format.html { redirect_to community_path(@community), :flash => {:notice => "Your community was created successfully! Woohoo!"} }
        format.json { render :show, status: :created, location: @community }
      else
        format.html { render :new }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy
  end

  private
  def community_params
    params.require(:community).permit(:name, :description)
  end

  def set_community
    @community = Community.find(params[:id])
  end

end