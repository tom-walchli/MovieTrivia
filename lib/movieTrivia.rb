require 'imdb'

class MovieSearch
	def initialize(pattern)
		@pattern = pattern
		startQuery
	end

	def startQuery
		movies = Imdb::Search.new(@pattern)
	end
end




