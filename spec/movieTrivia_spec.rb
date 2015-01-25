require 'rspec'
require_relative '../lib/movie' 

RSpec.describe "MovieTrivia" do 

	let(:movie) do
		@query = "Funny"
		Movie.new(@query)
	end

	it "movies is an Array" do
		expect(movie.movies.class).to eq(Array)
	end

	it "Each movie is of class movie" do
		expect(movie.movies[0].class).to eq(Hash)
	end

	it "movies.length = 9" do
		expect(movie.movies.length).to eq(9)
	end

	it "movie attributes are accessed via e.g. .movies[k].title " do
		expect(movie.movies[0][:title].include?(@query)).to eq(true)
	end
end