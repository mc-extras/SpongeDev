class User < ActiveRecord::Base
  acts_as_messageable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessor :login

  has_many :authors, :dependent => :destroy
  has_many :plugins, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :subscriptions, :dependent => :destroy

  validates :gender, :inclusion => { :in => ['Male', 'Female', nil] }
  validates :avatar_serve, :inclusion => { :in => ['Gravatar', 'Crafatar'] }
  validates :username, :length => { maximum: 16 }, :uniqueness => {:case_sensitive => false}

  def to_param
    username
  end

  def to_s
    username
  end

  def mailboxer_email(object)
    email
  end

  def name
    username
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

end