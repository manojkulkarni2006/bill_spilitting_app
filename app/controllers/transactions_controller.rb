class TransactionsController < ApplicationController

	before_filter :get_users, only: [:index, :create]
	before_filter :check_valid_users, only: [:create]

	def index
		@bill = Bill.new
	end

	def create
		unless params[:bill].blank?
			@bill = Bill.new(transaction_parameters)	
			if @bill.valid?
				flash[:notice] = 'Transaction created successfully.'
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

end
