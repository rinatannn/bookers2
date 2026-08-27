class GroupUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    group = Group.find(params[:group_id])

    unless group.includes_user?(current_user)
      group.group_users.create(user: current_user)
    end

    redirect_to group_path(group)
  end

  def destroy
    group = Group.find(params[:group_id])

    group_user = group.group_users.find_by(user: current_user)
    group_user&.destroy

    redirect_to group_path(group)
  end
end