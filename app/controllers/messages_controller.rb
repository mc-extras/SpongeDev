class MessagesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @messages = current_user.mailbox.inbox
  end

  def show
    unless @conversation = Mailboxer::Conversation.find(params[:id])
      return redirect_to messages_path, :notice => "That conversation does not exist."
    end
    unless @conversation.is_participant?(current_user)
      return redirect_to messages_path, :notice => "You do not have permission to view that conversation."
    end
    @message = @conversation.messages.new
  end

  def create
    @message = Mailboxer::Message.new(message_params)
    if @message.conversation_id
      @conversation = Mailboxer::Conversation.find(@message.conversation_id)
      unless @conversation.is_participant?(current_user)
        return redirect_to messages_path, :notice => "You do not have permission to view that conversation."
      end
      receipt = current_user.reply_to_conversation(@conversation, @message.body, nil, true, true, @message.attachment)
    end
    return redirect_to message_path(receipt.conversation), :notice => "Message created."
  end

  private
  def message_params
    params.require(:mailboxer_message).permit(:body, :conversation_id)
  end
end
