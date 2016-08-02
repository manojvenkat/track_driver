class Tenant < ActiveRecord::Base
  has_many :users
  has_many :vehicles
  has_many :drivers

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  validates :name,  presence: true, uniqueness: true, length: { maximum: 50 }

  after_create :create_default_user

  private 

  def create_default_user
  	self.users.create!(name: self.name, email: self.email, password: "tracker", password_confirmation: "tracker")
  end
end