class PluginFile < ActiveRecord::Base
  mount_uploader :file, PluginFileUploader
  belongs_to :plugin
  validates :release_type, presence: true
  validates :name, presence: true
  validates :mc_version, presence: true

  def can_manage(permission_user)
    permission_user and (self.plugin.user == permission_user or permission_user.admin?)
  end

  def can_view(permission_user)
    approved ? true : can_manage(permission_user)
  end
end
