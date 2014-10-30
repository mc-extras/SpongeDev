module NotificationsHelper
  def subscribe_user(subscriptions, user)
    sub = subscriptions.where(:subscriber => user).first
    if not sub
      sub = subscriptions.create(:subscriber => user)
    end
    sub
  end

  def unsubscribe_user(subscriptions, user)
    sub = subscriptions.where(:subscriber => user).first
    if sub
      sub.destroy
      return true
    else
      return false
    end
  end

  def is_subscribed(subscriptions, user)
    subscriptions.where(:subscriber => user).any?
  end

  def message_all(sender, subscriptions, body, subject)
    subscriptions.each do |subscription|
      sender.send_message(subscription.subscriber, body, subject)
    end
  end
end
