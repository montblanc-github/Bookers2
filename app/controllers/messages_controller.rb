class MessagesController < ApplicationController
  before_action :follow_each_other, :only => [:show]

  def show
    @user = User.find(params[:id])
    rooms = current_user.entries.pluck(:room_id)
    entries = Entry.find_by(user_id: @user.id, room_id: rooms)

    if entries.nil?
      @room = Room.new
      @room.save
      Entry.create(user_id: @user.id, room_id: @room.id)
      Entry.create(user_id: current_user.id, room_id: @room.id)
    else
      @room = entries.room
    end

    @messages = @room.messages
    @message = Message.new(room_id: @room.id)
  end

  def create
    @message = current_user.messages.new(message_params)
    @message.save
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id)
  end

  def follow_each_other
    user = User.find(params[:id])
    if !(current_user.following?(user) && user.following?(current_user))
      redirect_to books_path
    end
  end
end
