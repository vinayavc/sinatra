require 'sinatra'
require 'erb'
require 'sendgrid-ruby'
require 'sass'
require './student'
include SendGrid

configure do
    enable :sessions
    set :username, 'frank'
    set :password, 'sinatra'
  end

get '/' do
    erb:index
end
