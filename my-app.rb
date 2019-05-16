require 'sinatra'
require 'sendgrid-ruby'
include SendGrid

get '/' do
    'Hello World'
end