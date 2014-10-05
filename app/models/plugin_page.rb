class PluginPage < ActiveRecord::Base
  belongs_to :plugin

  def to_param
    "#{id}-#{title}"
  end
end
