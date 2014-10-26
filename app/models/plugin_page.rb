class PluginPage < ActiveRecord::Base
  belongs_to :plugin

  validates :title, presence: true

  def to_param
    "#{id}-#{title}"
  end
end
