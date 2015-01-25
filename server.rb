require 'sinatra'
require 'sinatra/flash'
require 'pry'
require 'sinatra/reloader' if development?
require 'logger'

require_relative 'lib/movieTrivia'

enable :sessions
set :session_secret, 'super secret'

get '/' do
	erb :index
end

get '/search' do
	@score_incremented = nil
	session[:score] = 0 unless session[:score]
	movies_flat = Movie.new(params[:pattern]).movies
	if movies_flat.length < 9
		"""<h3>Not enough movies with posters found...
		<br><br><a href='/'>Start over</a>
		"""
	else
		@movies = []
		movies_flat.each_slice(3) {|group| @movies.push(group)}
		session[:question_movie] = movies_flat.sample
		session[:movies] = @movies
		erb :search
	end
end

get '/poster/click/:movie_year' do
	year = params[:movie_year]

	@movies = session[:movies]
	@score_incremented = evaluate_score(year)
	session[:score] += ( @score_incremented ? 1 : -1 )
	if @score_incremented
		erb :nailed_it
	else 
		if session[:score] < 0 
			session[:score] = 0
		end
		erb :search
	end
end

def evaluate_score(year)
	if year.to_s == session[:question_movie][:year].to_s
		return true
	end
	return false
end


