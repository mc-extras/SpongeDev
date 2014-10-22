class RegistrationToken < ActiveRecord::Base
  validates_presence_of :uuid
  validates_presence_of :token
end