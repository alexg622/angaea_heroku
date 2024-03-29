class ChatroomsController < ApplicationController
  before_action :user_logged_in?, only: [:show]
  def index
    @chatroom = Chatroom.new
    @chatrooms = Chatroom.all
  end

  def new
    if request.referrer.split("/").last == "chatrooms"
      flash[:notice] = nil
    end
    @chatroom = Chatroom.new
  end

  def edit
    @chatroom = Chatroom.find_by(slug: params[:slug])
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    @chatroom.activity = Activity.first
    if @chatroom.save
      respond_to do |format|
        format.html { redirect_to @chatroom }
        format.js
      end
    else
      respond_to do |format|
        flash[:notice] = {error: ["a chatroom with this topic already exists"]}
        format.html { redirect_to new_chatroom_path }
      end
    end
  end

  def update
    chatroom = Chatroom.find_by(slug: params[:slug])
    chatroom.update(chatroom_params)
    redirect_to chatroom
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    @chatroom.create_read_messages(current_user)
    render json: {activityName: @chatroom.activity.activity_name, chatroom: @chatroom, messages: @chatroom.returnMessages.reverse}
  end

  private
  def chatroom_params
    params.require(:chatroom).permit(:topic)
  end
end
