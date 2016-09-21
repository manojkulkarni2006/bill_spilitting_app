class Transaction < ActiveRecord::Base
	belongs_to :bill
	belongs_to :user
end
