class Wiki::Page < ActiveRecord::Base
  belongs_to :wiki
  has_many :editors, class_name: 'User'
end
