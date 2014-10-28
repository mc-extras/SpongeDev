class Plugin < ActiveRecord::Base
  has_many :subscriptions, :as => :subscribable

  acts_as_taggable
  has_many :authors, :dependent => :destroy
  belongs_to :user
  has_many :plugin_files, :dependent => :destroy
  has_many :plugin_pages, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  validates :summary, presence: true
  validates :body, presence: true
  validates :name, presence: true, uniqueness: true
  validates :license, presence: true
  validates :primary_category, presence: true
  validate :category_count
  validate :require_custom
  validate :verify_primary

  def to_param
    "#{id}-#{name}"
  end

  def all_categories
    cats = Array.new
    cats << primary_category
    self.tags.each { |t| cats << t.name }
    return cats
  end

  def latest_download
    plugin_files.first
  end

  def can_manage(permission_user)
    permission_user and (self.user == permission_user or permission_user.admin?)
  end

  def can_view(permission_user)
    approved ? true : can_manage(permission_user)
  end

  private
  def category_count
    errors.add :tag_list, "is invalid. Select up to four categories for your plugin." unless tag_list.size <= 4
  end

  def require_custom
    errors.add :custom_license, "is required if the custom option is selected." if license == "Custom" and custom_license.empty?
    errors.add :custom_text, "for your license needs to be entered when using a custom license." if license == "Custom" and custom_text.empty?
  end

  def verify_primary
    errors.add :primary_category, "is invalid. It should not be included in your sub categories." if tag_list.include?(primary_category)
    errors.add :primary_category, 'is invalid. Please do not try to add a custom category.' if not CATEGORIES.include?(primary_category)
  end
end
