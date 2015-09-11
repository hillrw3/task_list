class User < ActiveRecord::Base
  devise :database_authenticatable
  validates_presence_of :email, :username, :password
  validates_confirmation_of :password

  has_many :lists
  accepts_nested_attributes_for :lists
  has_many :tasks, through: :lists

  after_create :create_list

  private

  def create_list
    list = self.lists.build
    list.name = "#{username}'s tasks"
    list.save
  end
end