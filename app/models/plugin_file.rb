class PluginFile < ActiveRecord::Base
  mount_uploader :file, PluginFileUploader
  belongs_to :plugin
  validates :release_type, presence: true
  validates :name, presence: true
  validates :mc_version, presence: true
end
