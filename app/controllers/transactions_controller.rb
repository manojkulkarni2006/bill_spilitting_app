class TransactionsController < ApplicationController

	before_filter :get_users, only: [:index, :create]

	def index
		@bill = Bill.new
	end

	def create
		unless params[:bill].blank?
			@bill = Bill.new(transaction_parameters)	
			if @bill.valid?
				if are_users_valid? && user_amount_matches?
					flash[:notice] = 'Transaction created successfully.'
				else
					flash[:error] = 'Please check Users and their Amounts'
				end
			end
		end
		render :index
	end

	private

	def transaction_parameters
		params.require(:bill).permit(:event, :amount, :location, :date)
	end

	def get_users
		@users = User.all
	end

	def are_users_valid?
		params[:user_present].present? && params[:user_present].to_set.subset?(@users.ids.map(&:to_s).to_set)
	end

	def user_amount_matches?
		if params[:user_present].present?
			total_amt = 0
			params[:user_present].each do |user_id|
				total_amt += params["user_amt_#{user_id}".intern].to_f unless params["user_amt_#{user_id}".intern].blank?
			end
		end
		params[:bill][:amount].to_f.eql?(total_amt)
	end

end
