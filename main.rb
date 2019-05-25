require 'sinatra'
require 'sass'
require './student'
require './comment'
#require './song'
# require 'sinatra/reloader' if development?

#enable :sessions
configure :production do
    DataMapper.setup(:default, ENV['DATABASE_URL']|| "sqlite3://#{Dir.pwd}/development.db") #connecting to db
end

configure :development do
    DataMapper.setup(:default, ENV['DATABASE_URL']|| "sqlite3://#{Dir.pwd}/test.db") #connecting to db
end



get('/styles.css'){ scss :styles }

get '/' do
	redirect("/login") unless session[:admin]
    erb :login
  	# if session[:admin] == true
	# 	erb :home, :layout => :layout2
	# else
	# 	erb :home
	# end
end

get '/home' do
	redirect("/login") unless session[:admin]
    erb :home
end

get '/about' do
 	@title = "All About This Website"
	redirect("/login") unless session[:admin]
	erb :about
end

get '/contact' do
	redirect("/login") unless session[:admin]
	erb :contact
end

# get '/students' do
# 	erb :students
# end

# get '/comment' do
# 	if session[:admin] == true
# 		erb :comment, :layout => :layout2
# 	else
# 		erb :comment
# 	end
# end

get '/video' do
	redirect("/login") unless session[:admin]
	erb :video
end

# not_found do
#   	erb :not_found
# end
