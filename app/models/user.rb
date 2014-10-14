class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :authors
  has_many :plugins
  has_many :comments

  def to_param
    username
  end
end
