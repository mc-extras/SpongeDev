class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :confirmable

  has_many :authors, :dependent => :destroy
  has_many :plugins, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  validates :gender, :inclusion => { :in => ['Male', 'Female'] }
  validates :avatar_serve, :inclusion => { :in => ['Gravatar', 'Crafatar'] }

  def to_param
    username
  end

  def to_s
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