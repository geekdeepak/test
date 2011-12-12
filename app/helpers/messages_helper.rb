module MessagesHelper
  def messages_link_title
    messages = @current_user.messages.unopened.count
    if messages > 0
      "Messages (#{messages})"
    else
      "Messages"
    end
  end
end
