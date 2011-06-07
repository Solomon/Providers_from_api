module ApplicationHelper

	def get_total_results(name)
			base = "http://api.thedealmap.com/search/deals/"
			api = '0-691251466-634412950572967500'
			url = base + generate_search_query(name, api,0)
			data = HTTParty.get(url)
			myxml = Crack::XML.parse(data.body)
			total = myxml['Deals']['TotalResults']
			if total.nil?
				return 0
			else
				return total
			end
	end

	def get_providers(name, queries)
		base = "http://api.thedealmap.com/search/deals/"
		api = '0-691251466-634412950572967500'
		providers = []

		(0..queries).each do |i|
			start = i*100
			url = base + generate_search_query(name, api,start)
			data = HTTParty.get(url)
			myxml = Crack::XML.parse(data.body)['Deals']['Results']['Deal']
			if !myxml.nil?
				myxml.each do |item|
					item_provider = item['DealSource']			
					providers << item_provider unless providers.include?(item_provider)
				end
			end
		end
		return providers

	end

	def generate_search_query(location, key, start_index)
		place = location.gsub(" ", "%20")
		if start_index > 0
			return "?l=#{place}&ps=100&si=#{start_index}&key=#{key}"
		else
			return "?l=#{place}&ps=100&key=#{key}"
		end
	end

end
