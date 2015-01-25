require 'imdb'
require 'pry'



# class Movie_old
#     attr_accessor :id, :title, :poster, :year
#     def initialize(options={})
#     	@id = options[:id] if options[:id]
#     	@title = options[:title] if options[:title]
#     	@poster = options[:poster] if options[:poster]
#     	@year = options[:year] if options[:year]
#     end

#     def pretty_title
#     	self.title.capitalize
#     end

# 	def search_old(term)
# 	  results = []
#       imdb_results = Imdb::Search.new(term).movies
#       binding.pry
      
#       results = imdb_results.map{|m|
#         Movie.new(id: m.id, title: m.title,poster: m.poster,year: m.year)
#       }
#       binding.pry
#       results = results.map{|m| m if !m.poster.nil?}.compact
#       results
# 	end
# 	def search(term)
# 	  results = []
#       imdb_results = Imdb::Search.new(term).movies.map{|m| m if !m.poster.nil?}.compact.sample(9)
#       binding.pry
      
#       results = imdb_results.map{|m|
#         Movie.new(id: m.id, title: m.title,poster: m.poster,year: m.year)
#       }
#       binding.pry
#       results = results
#       results
# 	end
# end

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

