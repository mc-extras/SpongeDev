class MessagesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @messages = current_user.mailbox.inbox
  end

  def show
  end
end
