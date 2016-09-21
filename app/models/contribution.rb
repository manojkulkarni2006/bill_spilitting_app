class Contribution < ActiveRecord::Base
	belongs_to :bill
	belongs_to :user

	def self.get_timely_data(from_time = nil, to_time = nil)
		from_time = DateTime.now.beginning_of_month if from_time.blank?
		to_time = DateTime.now if to_time.blank?
		users = User.all
		payments = []
		users.each do |f_user|
			users.each do |t_user|
				next if f_user.id.eql?(t_user.id)
				pay = Hash.new
				pay[:from] = f_user.name
				pay[:to] = t_user.name
				pay[:amt] = where(from_user: f_user.id, to_user: t_user.id, created_at: from_time...to_time).sum(:pay_amt)
				payments << pay
			end		
		end
		payments
	end


end
