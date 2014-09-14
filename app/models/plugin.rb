class Plugin < ActiveRecord::Base
  acts_as_taggable
  has_many :authors
  belongs_to :user

  def to_param
    "#{id}-#{name}"
  end

end
