class UserPaymentsController < ApplicationController

	before_filter :get_users, only: [:index, :create]
	before_filter :map_user_names, only: [:index]

	def index
		@payment = Payment.new
		@user_acc = UserAccount.all
	end

	def create
		unless params[:payment].blank?
			@payment = Payment.new(payment_parameters)
			if @payment.valid?
				is_success = @payment.create_payment
				if is_success
					flash[:notice] = 'Payment created successfully.'
					redirect_to user_payments_path
				else
					flash[:error] = 'Saving data is unsuccessful.'
					render :index
				end
				return
			end
		end
		render :index
	end


	private

	def payment_parameters
		params.require(:payment).permit(:from_user, :to_user, :paid_amt)
	end

	def get_users
		@users = User.all
	end

	def map_user_names
		@map_name = Hash.new
		@users.each do |usr|
			@map_name[usr.id] = usr.name			
		end
	end

end
