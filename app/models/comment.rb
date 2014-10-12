class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :plugin

  validates :content, presence: true
end
