class Payment < ActiveRecord::Base

	validates :from_user, presence: true
	validates :to_user, presence: true
	validate :check_valid_user
	validates :paid_amt, presence: true, length: {maximum: 10}, numericality: {greater_than_or_equal_to: 1}

	def check_valid_user
		users = User.all.map(&:id)
		errors.add(:from_user, :invalid) unless users.include?(from_user)
		errors.add(:to_user, :invalid) unless users.include?(to_user)
		errors.add(:to_user, :invalid) if from_user.eql?(to_user)
	end

	# below method adds payment transaction and updates user_accounts table with paid amount. 
	def create_payment
		begin
			ActiveRecord::Base.transaction do
			  self.save
				user_acc = UserAccount.where(from_user: from_user, to_user: to_user).first_or_initialize
				user_acc.update_attributes!(previous_cf: (user_acc.previous_cf.present? ? user_acc.previous_cf - paid_amt.to_f : -paid_amt))
				return true
			end
		rescue => e
			return false
			logger.error e.message
		end
	end

end
