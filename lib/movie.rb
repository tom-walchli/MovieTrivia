require 'imdb'
require 'pry'

class Movie
	attr_reader :movies
	def initialize(pattern)
		@movies  = search(pattern)
	end  

	def search(pattern)
		slice_each = 20
 		movs = Imdb::Search.new(pattern)
 		puts "#{movs.movies.length} movies found matching pattern '#{pattern}'"

 		movies = []
 		movies_groups = []

 		# taking samples from earlier slices increases the chance of finding posters and 
 		# returns movies better related to the search term
 		movs.movies.each_slice(slice_each) {|group| movies_groups.push(group)}
 		movies_groups.each do |group|
 			puts "switching group..."
 			while movies.length < 9 && group.length > 0
 				mov = group.sample
 				group.delete mov
 				poster = mov.poster
 				if poster
 					id = mov.id
 					movies.push({:title=>mov.title,:year=>mov.year,:poster=>poster,:id=>id})
 					puts "Found with poster"
 				else 
	 				puts "Found no poster"
 				end
 			end
 			if movies.length == 9
 				break
 			end
	 	end
		return movies
	end
end

