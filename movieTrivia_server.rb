require 'sinatra'
require 'pry'
require 'sinatra/reloader' if development?
require 'logger'

require_relative 'lib/movieTrivia'

enable :sessions
set :session_secret, 'super secret'

get '/' do
	erb :start
end

post '/input' do
	erb :input
end

post '/goSearch'
	MovieSearch.new(params[:pattern])
end





# post '/login' do
# 	session[:username] = params[:username]
# 	pwd = params[:password]
# 	if authentication(pwd)
# 		redirect to('/welcome')
# 	else 
# 		redirect to('/try_again')
# 	end
# end
