class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  def forem_name
    username
  end

  def forem_email
    email
  end
  
  has_many :authors
  has_many :plugins
end
