class User < ActiveRecord::Base
  devise :database_authenticatable
  validates_presence_of :email, :username, :password
  validates_confirmation_of :password

  has_one :list
  accepts_nested_attributes_for :list
  has_many :tasks, through: :list

  after_create :create_list

  private

  def create_list
    list = self.build_list
    list.name = "#{username}'s tasks"
    list.save
  end
end