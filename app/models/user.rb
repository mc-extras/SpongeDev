class User < ActiveRecord::Base
  acts_as_messageable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :confirmable

  has_many :authors, :dependent => :destroy
  has_many :plugins, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :subscriptions, :dependent => :destroy

  validates :gender, :inclusion => { :in => ['Male', 'Female', nil] }
  validates :avatar_serve, :inclusion => { :in => ['Gravatar', 'Crafatar'] }
  validates :username, :length => { maximum: 16 }

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

  def verify_mc token
    if rt = RegistrationToken.find_by(uuid: self.uuid, token: token)
      if rt.created_at < 5.minues.ago
        return "too old"
      else
        return "success"
        rt.destroy!
      end
      return "not found"
    end
  end
end