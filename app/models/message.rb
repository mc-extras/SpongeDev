class Message < ActiveRecord::Base
  has_many :recipients
  belongs_to :creator, class_name: 'User'

  def messages_for(user)
    recipients.where(:user => user).or(:user => creator)
  end
end
