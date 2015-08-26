class User < ActiveRecord::Base

  devise :database_authenticatable
  validates_presence_of :email, :username, :password, :password_confirmation
  validates_confirmation_of :password
end