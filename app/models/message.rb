class Message < ActiveRecord::Base
  has_many :recipients, class_name: 'User'
  belongs_to :creator, class_name: 'User'
end
