class Plugin < ActiveRecord::Base
  acts_as_taggable
  has_many :authors
  belongs_to :user
  has_many :plugin_files

  validates :summary, presence: true
  validates :body, presence: true
  validates :name, presence: true, uniqueness: true
  validates :license, presence: true
  validate :category_count
  validate :require_custom
  validate :verify_primary

  def to_param
    "#{id}-#{name}"
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
  end
end
