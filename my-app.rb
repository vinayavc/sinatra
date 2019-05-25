require 'sinatra'
require 'erb'
require 'sendgrid-ruby'
# require 'sass'
require './student'
include SendGrid

configure do
    enable :sessions
    set :username, 'frank'
    set :password, 'sinatra'
  end

# get '/' do
#     erb:index
# end

get("/_bootswatch.scss") {scss :styles}

# get '/' do
#   redirect("/login") unless session[:admin]
#   erb :index
# end

configure :development do
    DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/test.db")
    DataMapper.auto_migrate!
end

get '/' do
    redirect("/login") unless session[:admin]
    erb :login
  end

post '/login' do
    if params["login"]["username"] == 'frank' && params['login']['password'] == "sinatra"
        session[:admin] = true
        redirect to ("/home")
    else
        erb :login
    end
end

get '/home' do
    redirect("/login") unless session[:admin]
    erb :index
end

get '/contact' do
    redirect("/login") unless session[:admin]
    erb :contact
end

get "/login" do
    erb :login
  end

  
  get "/logout" do
    session[:admin] = nil
    redirect to ("/")
  end
  
  get '/about' do
    redirect("/login") unless session[:admin]
    @title = "All About This Website"
    erb :about
  end
