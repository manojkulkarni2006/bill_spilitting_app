class Bill < ActiveRecord::Base
	validates :event, presence: true, inclusion: { in: ['Breakfast', 'Lunch', 'Dinner', 'Snacks'] }
	validates :amount, presence: true, length: {maximum: 10}
	validates :location, presence: true, length: {maximum: 30}
	validates :date, presence: true, length: {maximum: 10}
	validate :validate_date
	validates :comment, length: {maximum: 100}

	def validate_date
		unless (Date.parse(date.to_s) rescue false)
			errors.add(:date, :invalid)			
		end
	end

end
