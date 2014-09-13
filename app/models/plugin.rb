class Plugin < ActiveRecord::Base
  acts_as_taggable_on :categories
  has_many :authors
  belongs_to :user

  def to_param
    "#{name} #{id}"
  end
end
