class CommunitiesController < ApplicationController
  load_and_authorize_resource
  # before_action :set_community, only: [:discussions, :members, :courses, :add_user, :remove_user, :show, :edit, :update, :destroy]

  def add_user
    unless @community.users.include?(current_user)
      new_member = Membership.new(user_id: current_user.id, community_id: @community.id, role: "Member")
      @community.memberships << new_member
    end
    redirect_back(fallback_location: community_path(@community))
  end

  def remove_user
    unless not @community.users.include?(current_user)
      @community.users.delete(current_user)
    end
    redirect_back(fallback_location: community_path(@community))
  end

  def members
    @members = @community.memberships
  end

  def discussions
    @discussions = @community.discussions
  end

  def courses
    @courses = @community.courses
  end

  def index
    @communities = Community.all
  end

  def show
    @courses = @community.courses
    @discussions = @community.discussions
  end

  def new
    @community = Community.new
  end

  def edit
  end

  def create
    @community = Community.new(community_params)
    first_curator = Membership.new(user_id: current_user.id, community_id: @community.id, role: "Curator")
    @community.memberships << first_curator

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
    respond_to do |format|
      if @community.update(community_params)
        format.html { redirect_to community_path(@community), :flash => {:notice => "Your community was saved successfully! Woohoo!" } }
      else
        format.html { render :show }
      end
    end
  end

  def destroy
    @community.destroy
    respond_to do |format|
      format.html{ redirect_back(fallback_location: root_path, notice: 'Community was successfully destroyed.')}
    end
  end

  private
  def community_params
    params.require(:community).permit(:name, :description, :identifier)
  end

  def set_community
    @community = Community.find(params[:id])
  end

end