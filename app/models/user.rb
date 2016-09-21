class User < ActiveRecord::Base
	has_many :transactions
	has_many :bills, through: :transactions
end
