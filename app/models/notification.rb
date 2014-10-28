class Notification < ActiveRecord::Base
  validates :notification_type, :presence => true

  belongs_to :subscription
  belongs_to :user

  class << self
    def for(user, notification_type=nil, read=false)
      notifications = Notification.where(:user => user).where(:read => read)
      if notification_type
        notifications = notifications.where(:notification_type => notification_type)
      end
      notifications
    end

    def read_all(user, notification_type=nil)
      notifications = Notification.where(:user => user).where(:read => false)
      if notification_type
        notifications = notifications.where(:notification_type => notification_type)
      end
      notifications.update_all(:read => true, :read_at => Time.now)
    end
  end

  def mark_as_read
    self.read = true
    self.read_at = Time.now
    self.save
  end

  def url
    link = ''
    case self.notification_type
    when "Plugin"
      link += '/plugins'
      link += "/#{self.subscription.subscribable.to_param.to_s}"
    when "PluginFile"
      link += '/plugins/downloads'
      link += "/#{self.subscription.subscribable.id.to_s}"
    end
    link
  end

  def link_text
    text = ''
    case self.notification_type
    when "Plugin"
      action = self.action
      if action == "denied" or action == "approved"
        text += "Your plugin #{self.subscription.subscribable.name}"
        text += " was #{self.action}."
      end
    when "PluginFile"
      action = self.action
      if action == "denied" or action == "approved"
        text += "Your plugin #{self.subscription.subscribable.name}"
        text += " was #{self.action}."
      elsif action == "uploaded"
        text += "A new download has been created for #{self.subscription.subscribable.name}."
      end
    end
    text
  end
end
