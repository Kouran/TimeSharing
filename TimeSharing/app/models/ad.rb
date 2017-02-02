class Ad < ActiveRecord::Base
	validates_presence_of :title, :category, :description, :expected_hours, :deadline, :applicant_user
	validates :expected_hours, numericality: {greater_than: 0}
end
