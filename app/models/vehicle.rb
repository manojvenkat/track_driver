class Vehicle < ActiveRecord::Base
	belongs_to :tenant
	has_many :daily_scores

	validates :registration, presence: true, uniqueness: true
	validates_presence_of :tenant_id
end