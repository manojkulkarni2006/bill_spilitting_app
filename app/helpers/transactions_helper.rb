module TransactionsHelper

	def check_user_present(current_id)
		params[:user_present].present? && params[:user_present].include?(current_id.to_s)
	end

	def set_user_amount(current_id)
		params["user_amt_#{current_id}".intern] || 0
	end

end
