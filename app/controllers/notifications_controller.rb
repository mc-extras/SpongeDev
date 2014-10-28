class NotificationsController < ApplicationController
  def show
    @notification = Notification.find(params[:id])

    if !@notification.read
      @notification.mark_as_read
    end

    redirect_to @notification.url
  end
end
