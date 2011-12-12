class MessagesController < ApplicationController
  before_filter :dont_display_projects
  
  def index
    @messages = @current_user.messages
    @messages.reverse!
  end
  
  def new
    @message = Message.new
    setup_new_message
  end
  
  def create
    @message = Message.new(params[:message])
    unless params[:user][:id].empty?
      @message.user = User.find(params[:user][:id])
      @message.sender_id = @current_user.id
      @message.sender = @current_user.username
      if @message.save
        @message.deliver!
        redirect_to messages_path
      else
        setup_new_message
        render :action => 'new'
      end
    else
      setup_new_message
      flash[:error] = "User must be specified"
      render :action => 'new'
    end
  end
  
  def show
    @message = Message.find(params[:id])
    @message.mark_read!
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    flash[:notice] = 'Message was successfully deleted.'
    redirect_to messages_path
  end
  
  private
  
    def setup_new_message
      @to = []
      @current_user.contacts_from.each do |contact|
        @to << contact.contactee
      end
      @to.uniq!
    end
end
