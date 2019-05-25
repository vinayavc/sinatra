require 'sinatra'
require 'sass'
require './student'
require './comment'

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

get '/video' do
	redirect("/login") unless session[:admin]
	erb :video
end
