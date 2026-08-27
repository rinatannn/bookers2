class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :ensure_owner, only: [:edit, :update, :destroy]

  def index
  @groups = Group.all
  @user = current_user
end

  def show
    @user = current_user
  end

  def new
  @group = Group.new
  @user = current_user
  end

  def create
  @group = Group.new(group_params)
  @group.owner = current_user
  @user = current_user

  if @group.save
    redirect_to groups_path, notice: "Group was successfully created."
  else
    render :new, status: :unprocessable_entity
  end
end

  def edit
    @user = current_user
  end

  def update
  @user = current_user

  if @group.update(group_params)
    redirect_to group_path(@group), notice: "Group was successfully updated."
  else
    render :edit, status: :unprocessable_entity
  end
end

  def destroy
    @group.destroy
    redirect_to groups_path, notice: "Group was successfully destroyed."
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def ensure_owner
    unless @group.owner == current_user
      redirect_to groups_path,
                  alert: "You are not authorized to edit this group."
    end
  end

  def group_params
    params.require(:group).permit(:name, :introduction)
  end
end