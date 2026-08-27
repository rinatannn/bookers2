class RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @room = Room.find(params[:id])

    unless @room.users.include?(current_user)
      redirect_to users_path
      return
    end

    @messages = @room.messages.order(created_at: :asc)
    @message = Message.new
  end

  def create
    user = User.find(params[:user_id])

    unless current_user.following?(user) && user.following?(current_user)
      redirect_to user_path(user),
                  alert: "相互フォローしているユーザーのみDMできます。"
      return
    end

    room = find_existing_room(user)

    unless room
      room = Room.create!
      room.entries.create!(user: current_user)
      room.entries.create!(user: user)
    end

    redirect_to room_path(room)
  end

  private

  def find_existing_room(user)
    shared_room_ids = current_user.room_ids & user.room_ids

    Room.find_by(id: shared_room_ids.first)
  end
end