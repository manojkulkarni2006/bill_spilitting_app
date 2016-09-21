class Bill < ActiveRecord::Base
	has_many :transactions
	has_many :users, through: :transactions
	has_many :contributions

	validates :event, presence: true, inclusion: { in: ['Breakfast', 'Lunch', 'Dinner', 'Snacks'] }
	validates :amount, presence: true, length: {maximum: 10}, numericality: {greater_than_or_equal_to: 1}
	validates :location, presence: true, length: {maximum: 30}
	validates :date, presence: true, length: {maximum: 10}
	validate :validate_date
	validates :comment, length: {maximum: 100}

	def validate_date
		selected_date = Date.parse(date.to_s) rescue false
		unless selected_date
			errors.add(:date, :invalid)
		end
		if selected_date
			if selected_date < Date.today.beginning_of_month
				errors.add(:date, 'Please enter date of current month.')
			elsif selected_date > Date.today
				errors.add(:date, 'Please do not enter future date.')
			end
		end
	end

	def create_transaction(contribution_hash)
		begin
			ActiveRecord::Base.transaction do
			  self.save
				contribution_hash.each do |transact|
					Transaction.create(user_id: transact[0].to_i, bill_id: self.id, paid_amt: transact[1].to_f)
				end
				individual_contri = get_individual_contribution_hash(contribution_hash)
				individual_contri.each do |due|
					Contribution.create(bill_id: self.id, from_user: due[:from_usr].to_i, to_user: due[:to_usr].to_i, pay_amt: due[:amt])
					user_acc = UserAccount.where(from_user: due[:from_usr].to_i, to_user: due[:to_usr].to_i).first_or_initialize
					user_acc.update_attributes!(previous_cf: (user_acc.previous_cf.present? ? user_acc.previous_cf + due[:amt] : due[:amt]))
				end
				return true
			end
		rescue => e
			return false
			logger.error e.message
		end
	end

	def get_individual_contribution_hash(contribution_hash)
		due_array = Array.new
		devide_into = contribution_hash.size
		contribution_hash.each do |contri|
			next if contri[1].to_f.eql?(0.0)
			per_head_contri = contri[1].to_f/contribution_hash.size
			(contribution_hash.keys - [contri[0]]).each do |usr|
				pay_hash = Hash.new
				pay_hash[:to_usr] = contri[0]
				pay_hash[:from_usr] = usr
				pay_hash[:amt] = per_head_contri
				due_array << pay_hash
			end
		end
		due_array
	end
end
