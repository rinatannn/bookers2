class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.find(params[:room_id])

    unless @room.users.include?(current_user)
      redirect_to users_path
      return
    end

    @message = current_user.messages.new(message_params)
    @message.room = @room

    if @message.save
      redirect_to room_path(@room)
    else
      @messages = @room.messages.order(created_at: :asc)
      render "rooms/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:message)
  end
end