module NotificationsHelper
  def subscribe_user(subscriptions, user)
    sub = subscriptions.where(:subscriber => user).first
    if not sub
      sub = subscriptions.create(:subscriber => user)
    end
    sub
  end

  def message_all(sender, subscriptions, body, subject)
    subscriptions.each do |subscription|
      sender.send_message(subscription.subscriber, body, subject)
    end
  end
end
