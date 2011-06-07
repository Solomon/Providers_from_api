class Provider < ActiveRecord::Base

# == Schema Information
#
# Table name: providers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

attr_accessor :get_providers, :get_total_results, :generate_search_query

	def get_total_results(name)
			# base = "http://api.thedealmap.com/search/deals/"
			# api = '0-691251466-634412950572967500'
			return '10'
	end

	

	

end