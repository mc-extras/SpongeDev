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

  has_many :infractions
  has_many :sent_messages, class_name: 'Message', inverse_of: 'creator'
  belongs_to :recieved_messages, class_name: 'Message', inverse_of: 'recipients'
  has_many :authors
  has_many :plugins
end
