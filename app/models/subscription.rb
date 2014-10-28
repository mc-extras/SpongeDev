class Subscription < ActiveRecord::Base
  belongs_to :subscribable, :polymorphic => true
  belongs_to :subscriber, :class_name => 'User'

  def dispatch(*args)
    case self.subscribable.class.name
    when "Plugin"
      Notification.create(
        :user => subscriber, 
        :subscription => self, 
        :notification_type => self.subscribable.class.name,
        :action => args[0])
    end
  end
end
