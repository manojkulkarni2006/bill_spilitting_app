class MonthlyCalculationsController < ApplicationController

	def index
		@payments = Contribution.get_timely_data
	end

end
