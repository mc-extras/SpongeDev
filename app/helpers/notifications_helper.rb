module NotificationsHelper
  def subscribe_user(subscriptions, user)
    sub = subscriptions.where(:subscriber => user).first
    if not sub
      sub = subscriptions.create(:subscriber => user)
    end
    sub
  end

  def notify_all(subscriptions, *args)
    subscriptions.each do |subscription|
      subscription.dispatch(args)
    end
  end
end
